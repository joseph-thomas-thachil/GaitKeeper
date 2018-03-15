import sys
import os
import glob
import cv2
import csv
import pymysql
from functools import partial
import numpy as np
import pickle
from sklearn import preprocessing, neighbors, svm
import pandas as pd
from sklearn.cluster import MeanShift, estimate_bandwidth
from PyQt5.QtGui import QImage
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot, QThread
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem, QQuickImageProvider
from PyQt5.QtQml import QQmlApplicationEngine

'''
processWindow class inherits QObject class and this is where the main process is implemented.
This class consists of 6 PyQt Signals: 

    1. processCompleted: This signal is emitted when the entire process is completed.
    2. processStatus: This signal is emitted along with the progress bar value to display progress in the GUI.
    3. cacheCompleted: This signal is emitted when the cache clearing process is done.
    4. dbError: This signal is used in the Registration section when the start button is pressed before filling the form.
    5. verifyCompleted: This signal is emitted along with database values when a MATCH is found.
    6. unauthCheck: This signal is emitted when NO MATCH is found.

This class also contains 3 PyQt Slots:

    1. process: This function is called in the QML when START button is pressed.
    2. clearprocess: This function is called when the CLEAR CACHE is pressed.
    3. processDatabase: This function is called in the Registration page when the form is filled.

'''
class processWindow(QObject) :
    def __init__(self) :
        QObject.__init__(self)

    processCompleted = pyqtSignal(int, arguments=['done'])
    processStatus = pyqtSignal(int, arguments=['val'])

    cacheCompleted = pyqtSignal(int, arguments=['cval'])

    dbError = pyqtSignal(int, arguments=['errstat'])
    dbSuccess = pyqtSignal()

    verifyCompleted = pyqtSignal(str, str, str, str, arguments=['id', 'name', 'pos', 'clr'])
    
    unauthCheck = pyqtSignal(int, arguments=['unath'])

    idError = pyqtSignal()
    nameError = pyqtSignal()
    posError = pyqtSignal()
    clrError = pyqtSignal()

    @pyqtSlot(bool, str)
    def process(self, train, uid) :
        self.busy = busyThread()
        self.thread = QThread(self)
        self.busy.threadCompleted.connect(self.done)

        self.busy.frameProgress.connect(self.progress)

        self.busy.verifyDone.connect(self.verify)

        self.busy.unauthVerify.connect(self.unauthorized)

        self.busy.moveToThread(self.thread)
        self.thread.started.connect(partial(self.busy.do_work, train, uid))
        self.thread.start()

    @pyqtSlot()
    def clearprocess(self) :
        self.busy = cacheThread()
        self.thread = QThread(self)
        
        self.busy.cacheClear.connect(self.clear)

        self.busy.moveToThread(self.thread)
        self.thread.started.connect(self.busy.deleteCache)
        self.thread.start()

    def unauthorized(self) :
        self.unauthCheck.emit(1)

    def verify(self, uid, name, pos, clr) :
        
        self.verifyCompleted.emit(uid, name, pos, clr)

    def progress(self, percent) :

        self.processStatus.emit(percent)
    
    def done(self) :
        self.processCompleted.emit(1)

    def clear(self) :
        self.cacheCompleted.emit(1)

    def createDatabase(self, host, user, password, database) :
        
        db = pymysql.connect(host, user, password, database)
        cursor = db.cursor()

        query = """CREATE TABLE IF NOT EXISTS gaituser(id CHAR(20) NOT NULL, name CHAR(20) NOT NULL, position CHAR(50) NOT NULL, clearance INT NOT NULL, image LONGBLOB NOT NULL, PRIMARY KEY(id))"""

        cursor.execute(query) 

        db.close()
    
    @pyqtSlot(str, str, str, str, str)
    def processDatabase(self, uid, uname, upos, uclr, uimg) :

        HOSTNAME = "localhost"
        USER = "gaitadmin"
        PASSWORD = "gaitkeeper"
        DATABASE = "gaitkeeper"

        uimg = uimg.split(':')[1]

        blob = open(uimg, 'rb').read()

        print(uid)
        if not uid.isnumeric() :
            self.idError.emit()
            return

        if not uname.isalpha() :
            if not uname.replace(' ', '').isalpha() :
                self.nameError.emit()
                return
            else :
                pass

        if not upos.isalpha() :
            if not upos.replace(' ', '').isalpha() :
                self.posError.emit()
                return
            else :
                pass

        if not uclr.isnumeric() :
            self.clrError.emit()
            return

        self.createDatabase(HOSTNAME, USER, PASSWORD, DATABASE)

        db = pymysql.connect(HOSTNAME, USER, PASSWORD, DATABASE)
        cursor = db.cursor()
        
        query = """INSERT INTO gaituser(id, name, position, clearance, image) VALUES(%s, %s, %s, %s, %s)"""
        
        try :
            cursor.execute(query, (uid, uname, upos, uclr, blob))

            db.commit()
            self.dbSuccess.emit()
        except pymysql.IntegrityError as e :
            self.dbError.emit(1)
        else :
            self.dbError.emit(0)

        db.close()

'''
busyThread class also inherits from QObject class and this is where the threaded process is implemented.
Since processWindow manages the whole program, it is important that the video processing be done in a separate thread.
Otherwise during video processing, the GUI will become unresponsive.
This class consists of 4 PyQt Signals:

    1. threadCompleted: This signal is sent to processWindow class when the thread process is completed.
    2. frameProgress: This signal is sent to processWindow along with the progress value to show in the GUI.
    3. verifyDone: This signal is sent to processWindow when a MATCH is found.
    4. unauthVerify: This signal is sent to processWindow when NO MATCH is found.

'''
class busyThread(QObject) :
    def __init__(self) :
        QObject.__init__(self)

    threadCompleted = pyqtSignal()
    frameProgress = pyqtSignal(int)
    verifyDone = pyqtSignal(str, str, str, str)
    unauthVerify = pyqtSignal()

    '''
    do_work function accepts two values: train and uid.
    train is a boolean value to check whether the process is for Registration or for Verification.
    uid is an integer value providing the user id of the user in case of Registration, otherwise it is taken as 0.
    
    Entire openCV video processing is done in this function.
    Background Subtration is done using the function createBackgroundSubtractorMOG()
    Since the video is processed with 24 FPS, only 240 frames are processed, i.e 10s video.
    Gaussian Blurring is done with a matrix size of 9x9.
    
    After processing, the extracted features are written to a CSV file. In case of Registration, the file name will be uid.csv and in case of Verification, it will be test.csv.
    
    '''
    def do_work(self, train, uid) :
        self.cap = cv2.VideoCapture("sources/walk_sample.mp4")
        print(uid)

        self.kernel = np.ones((3, 3), np.uint8)

        self.frameWidth = int(self.cap.get(3))
        self.frameHeight = int(self.cap.get(4))

        self.outOriginal = cv2.VideoWriter('cache/original.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))
        self.outDetect = cv2.VideoWriter('cache/detect.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))
        self.outSkel = cv2.VideoWriter('cache/skel.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))

        self.fgbg = cv2.bgsegm.createBackgroundSubtractorMOG()


        self.frameCount = 0

        cacheDir = os.path.join(os.getcwd(), 'cache')
        sourceDir = os.path.join(os.getcwd(), 'sources')
        try :
            pass
            os.remove(os.path.abspath(os.path.join(cacheDir, 'test.csv')))
        except OSError as e :
            pass
        try :
            if train :
                os.remove(os.path.abspath(os.path.join(sourceDir, str(uid) + '.csv')))
        except OSError as e :
            pass

        while self.frameCount < 240 :

            status, frame = self.cap.read()

            if not status :
                break

            blur = cv2.GaussianBlur(frame, (9, 9), 0)
            fgmask = self.fgbg.apply(blur)

            img = cv2.dilate(fgmask,self.kernel,iterations = 1)

            x, y, height, length = self.contourDetect(img)
            boxImg = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
            boxImg = cv2.rectangle(boxImg, (x, y), (x + length, y + height), (0, 0, 255), 2)
            cv2.line(boxImg, (0, int(y + 0.75 * height)), (640, int(y + 0.75 * height)), (0, 255, 0), 2)
            cv2.line(boxImg, (0, int(y + 0.15 * height)), (640, int(y + 0.15 * height)), (255, 0, 0), 2)

            skel, hip, shoulder = self.skelRegion(img, x, y, height, length)

            if self.frameCount > 50 and self.frameCount < 151 :
                if train :
                    with open('sources/' + str(uid) + '.csv', 'a', newline = '') as csvfile :
                        with open('cache/target.csv', 'a', newline = '') as targetfile :
                            fieldnames = ['height', 'stride', 'lowerbody', 'upperbody', 'hipangle', 'shoulderx', 'shouldery']
                            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

                            targetnames = ['class']
                            targetWriter = csv.DictWriter(targetfile, fieldnames=targetnames)

                            writer.writerow({'height': height, 'stride': length, 'lowerbody': round(0.53 * height, 2), 'upperbody': round(0.4 * height, 2), 'hipangle': round(hip, 2), 'shoulderx': shoulder[0], 'shouldery': shoulder[1]})

                            targetWriter.writerow({'class': uid})
                            targetWriter.writerow({'class': 0})
                else :
                    with open('cache/test.csv', 'a', newline = '') as csvfile :
                        fieldnames = ['height', 'stride', 'lowerbody', 'upperbody', 'hipangle', 'shoulderx', 'shouldery']
                        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

                        writer.writerow({'height': height, 'stride': length, 'lowerbody': round(0.53 * height, 2), 'upperbody': round(0.4 * height, 2), 'hipangle': round(hip, 2), 'shoulderx': shoulder[0], 'shouldery': shoulder[1]})
               
            self.outOriginal.write(frame)

            self.outDetect.write(boxImg)
            self.outSkel.write(skel)            

            self.frameCount += 1

            if self.frameCount % 10 == 0 : 
                self.trackProgress(self.frameCount/240)

        print("processing done!")
        self.cap.release()
        self.outDetect.release()
        self.outOriginal.release()
        self.outSkel.release()

        verify = False

        if train :
            pass
        else :
            csv_files = glob.glob('sources/*.csv')
            for cfile in csv_files :
                cf = pd.read_csv(cfile)
                master_array = cf.as_matrix()
                
                df = pd.read_csv('cache/test.csv')
                numpy_array = df.as_matrix()
                print(numpy_array)
            
                bandwidth = estimate_bandwidth(master_array, quantile = 0.1)
                ms = MeanShift(bandwidth = bandwidth, bin_seeding = True)
                ms.fit(master_array)
                master_labels = ms.labels_
                master_centers = ms.cluster_centers_
                print("Master centroids:\n", master_centers)
                print("Number of Master clusters: ", len(np.unique(master_labels)))

                bandwidth = estimate_bandwidth(numpy_array, quantile = 0.1)
                ms = MeanShift(bandwidth = bandwidth, bin_seeding = True)
                ms.fit(numpy_array)
                labels = ms.labels_
                cluster_centers = ms.cluster_centers_
                print("Test centroids:\n", cluster_centers)
                print("Number of Test clusters: ", len(np.unique(labels)))

                bandwidth = estimate_bandwidth(master_centers, quantile = 0.9)
                ms = MeanShift(bandwidth = bandwidth, bin_seeding = True)
                ms.fit(master_centers)
                master_centers = ms.cluster_centers_

                bandwidth = estimate_bandwidth(cluster_centers, quantile = 0.9)
                ms = MeanShift(bandwidth = bandwidth, bin_seeding = True)
                ms.fit(cluster_centers)
                cluster_centers = ms.cluster_centers_

                # new_centers = np.concatenate((master_centers, cluster_centers))
                LIMIT = np.matrix([[5, 5, 5, 5, 5, 5, 5]])
                if abs(master_centers - cluster_centers).all() < LIMIT.all() :
                    verify = True
                    uid = cfile.split('.')[0].split('/')[1]
                    data = self.fetchDatabase(uid)
                    img = open('cache/image.png', 'wb')
                    img.write(data[4])
                    img.close()
                    self.verifyDone.emit(str(data[0]), data[1], data[2], str(data[3]))
                    print(master_centers)
                    print(cluster_centers)
        
                    break

                print(master_centers)
                print(cluster_centers)
        
        if not verify :
            print("Working")
            self.unauthVerify.emit()
        self.threadCompleted.emit()

    '''
    fetchDatabase function is used to retrieve the matching data from the database.
    Data consists of ID, NAME, POS, CLR, IMAGE.

    '''
    def fetchDatabase(self, uid) :
        HOSTNAME = "localhost"
        USER = "gaitadmin"
        PASSWORD = "gaitkeeper"
        DATABASE = "gaitkeeper"

        db = pymysql.connect(HOSTNAME, USER, PASSWORD, DATABASE)
        cursor = db.cursor()
        
        query = """SELECT * FROM gaituser WHERE id = %s"""
        
        try :
            cursor.execute(query, (uid,))

            data = cursor.fetchone()
            print(uid)
            print(data)
        except Exception as e :
            print(e)
        else :
            pass

        db.close()
        
        return data

    '''
    trackProgress function emits the percentage completed which will be displayed in the progress bar.

    '''
    def trackProgress(self, percent) :
        self.frameProgress.emit(int(percent*100))

    '''
    contourDetect function accepts the background subtracted image and finds the contour with maximum size (which will be the human figure).
    A bounding rectangle is provided in the image as output.

    '''
    def contourDetect(self, img) :

        im2,contours,hierarchy = cv2.findContours(img, 1, 2)
        x = y = h = w = 0
        if len(contours) > 0 : 
            cnt = max(contours, key=cv2.contourArea)

            x,y,w,h = cv2.boundingRect(cnt)
            cv2.drawContours(im2, contours, -1, (255,255,255), 1)
        return x, y, h, w

    '''
    skelRegion function accepts the image processed by contourDetect and then finds the required features from the human silhoutte.
    Features are calculated as follows:

        1. Height of the person is the height of the bounding rectangle.
        2. Stride length is the width of the bounding rectangle.
        3. Shoulder is calculated as 15% from top of the head (top of bounding rectangle).
        4. Hip is calculared as 47% from top of the head.
        5. Knee is calculated as 67% from top of the head. The angle formed by the line joining hip and knee is calculated as hip angle.

    '''
    def skelRegion(self, img, x, y, h, w) :

        xy = [0] * 10

        xy[0], xy[1] = self.contourCenter(img, x, x + w, y, y + 5 )
        
        xy[2], xy[3] = self.contourCenter(img, x, x + w, int(y + 0.15 * h), int(y + 5 + 0.15 * h))

        xy[4], xy[5] = self.contourCenter(img, x, x + w, int(y + 0.47 * h), int(y + 5 + 0.47 * h))

        xy[6], xy[7], xy[8], xy[9] = self.contourCenter(img, x, x + w, int(y + 0.66 * h), int(y + 0.74 * h), True)

        im3 = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
        cv2.circle(im3, (x + xy[0], y + xy[1]), 3, (0, 0, 255), -1)
        cv2.circle(im3, (x + xy[2], y + xy[3] + int(0.15 * h)), 3, (0, 0, 255), -1)
        cv2.line(im3, (x + xy[0], y + xy[1]), (x + xy[2], y + xy[3] + int(0.15 * h)), (255, 0, 0), 2)
        shoulder = (x + xy[2], y + xy[3] + int(0.15 * h))

        cv2.circle(im3, (x + xy[4], y + xy[5] + int(0.47 * h)), 3, (0, 0, 255), -1)
        cv2.line(im3, (x + xy[2], y + xy[3] + int(0.15 * h)), (x + xy[4], y + xy[5] + int(0.47 * h)), (255, 0, 0), 2)

        cv2.circle(im3, (x + xy[6], y + xy[7] + int(0.66 * h)), 3, (0, 0, 255), -1)
        cv2.line(im3, (x + xy[4], y + xy[5] + int(0.47 * h)), (x + xy[6], y + xy[7] + int(0.66 * h)), (255, 0, 0), 2)

        hipAng = 0
        if x + xy[6] - (x + xy[4]) != 0 :
            hipAng = (y + xy[7] + int(0.66 * h) - (y + xy[5] + int(0.47 * h))) / (x + xy[6] - (x + xy[4]))

        if xy[8] != 0 and xy[9] != 0 :
            cv2.circle(im3, (x + xy[8], y + xy[9] + int(0.66 * h)), 3, (0, 0, 255), -1)
            cv2.line(im3, (x + xy[4], y + xy[5] + int(0.47 * h)), (x + xy[8], y + xy[9] + int(0.66 * h)), (255, 0, 0), 2)
        
        return im3, hipAng, shoulder
    
    '''
    contouCenter is the function used to find the centroid of the region of image provided. 
    Since we do not know the exact location of the body within the bounding rectangle, we find it by taking the centroid of a small region within the bounding box.
    Centroid is calculated as:

        x = int(M["m10"] / M["m00"])
        y = int(M["m01"] / M["m00"])
    '''
    def contourCenter(self, img, x1, x2, y1, y2, multiple=False) :

        c1 = img[y1:y2, x1:x2]
        im2, contours, hierarchy = cv2.findContours(c1, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        cx, cy = 0, 0
        cx1 = cy1 = cx2 = cy2 = 0
        if len(contours) > 0 :
            if len(contours) > 1 and multiple == True :
                cnt = contours[0]
                M = cv2.moments(cnt)
                if M["m00"] != 0 :
                    cx1 = int(M["m10"] / M["m00"])
                    cy1 = int(M["m01"] / M["m00"])
                cnt = contours[1]
                M = cv2.moments(cnt)
                if M["m00"] != 0 :
                    cx2 = int(M["m10"] / M["m00"])
                    cy2 = int(M["m01"] / M["m00"])
                return cx1, cy1, cx2, cy2
            cnt = max(contours, key=cv2.contourArea)
            M = cv2.moments(cnt)
            if M["m00"] != 0 :
                cx = int(M["m10"] / M["m00"])
                cy = int(M["m01"] / M["m00"])

        if multiple == True :
            return cx, cy, cx2, cy2
        return cx, cy 

'''
cacheThread class is similar to busyThread class with this class being used for clearing the cache directory.
It has 1 PyQt Signal:
    1. cacheClear: This signal is sent to processWindow class to show that the cache is cleared.

deleteCache function within this class takes care of that.

'''
class cacheThread(QObject) :
    def __init__(self) :
        QObject.__init__(self)
    
    cacheClear = pyqtSignal()

    def deleteCache(self) :
        cacheDir = os.path.join(os.getcwd(), 'cache')
        files = os.listdir(cacheDir)
        [os.remove(os.path.abspath(os.path.join(cacheDir, file))) for file in files]
        print("cache cleared!")
        self.cacheClear.emit()

if __name__ == '__main__':
    myApp = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    videoanalyze = processWindow()
    engine.rootContext().setContextProperty("videoanalyze", videoanalyze)
    engine.load('main.qml')

    myApp.exec_()
    sys.exit()

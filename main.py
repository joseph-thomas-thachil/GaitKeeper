import sys
import os
# from videoprocess import *
import cv2
import numpy as np
from PyQt5.QtGui import QImage
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot, QThread
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem, QQuickImageProvider
from PyQt5.QtQml import QQmlApplicationEngine


class processWindow(QObject) :
    def __init__(self) :
        QObject.__init__(self)

    processCompleted = pyqtSignal(int, arguments=['done'])
    processStatus = pyqtSignal(int, arguments=['val'])

    cacheCompleted = pyqtSignal(int, arguments=['cval'])
    
    @pyqtSlot()
    def process(self) :
        # vid = vprocess("sources/sample.mp4")
        self.busy = busyThread()
        self.thread = QThread(self)
        self.busy.threadCompleted.connect(self.done)

        self.busy.frameProgress.connect(self.progress)

        self.busy.moveToThread(self.thread)
        self.thread.started.connect(self.busy.do_work)
        self.thread.start()
        # self.busy.finished.connect(self.done)
        # self.ProcessCompleted.connect(self.busy, SIGNAL("signal"), self.done)
        # self.busy.start()

    @pyqtSlot()
    def clearprocess(self) :
        self.busy = cacheThread()
        self.thread = QThread(self)
        
        self.busy.cacheClear.connect(self.clear)

        self.busy.moveToThread(self.thread)
        self.thread.started.connect(self.busy.deleteCache)
        self.thread.start()

    def progress(self, percent) :

        self.processStatus.emit(percent)
    
    def done(self) :
        self.processCompleted.emit(1)

    def clear(self) :
        self.cacheCompleted.emit(1)


class busyThread(QObject) :
    def __init__(self) :
        QObject.__init__(self)

    threadCompleted = pyqtSignal()
    frameProgress = pyqtSignal(int)


    @pyqtSlot()
    def do_work(self) :
        # vid = vprocess("souces/gait.mp4")

    ########################
        self.cap = cv2.VideoCapture("sources/sample.mp4")

        self.hog = cv2.HOGDescriptor()
        self.hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())

        # self.surf = cv2.xfeatures2d.SURF_create(5000)
        self.kernel = np.ones((5, 5), np.uint8)

        self.frameWidth = int(self.cap.get(3))
        self.frameHeight = int(self.cap.get(4))

        self.outOriginal = cv2.VideoWriter('cache/original.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))
        self.outDetect = cv2.VideoWriter('cache/detect.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))
        self.outSkel = cv2.VideoWriter('cache/skel.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))

        self.fgbg = cv2.bgsegm.createBackgroundSubtractorMOG()


        self.frameCount = 0

        while self.frameCount < 240 :

            status, frame = self.cap.read()

            if not status :
                break

            blur = cv2.GaussianBlur(frame, (9, 9), 0)
            fgmask = self.fgbg.apply(blur)

            img = cv2.dilate(fgmask,self.kernel,iterations = 1)

            skel = self.skeltonize(img)

            x, y, height, length = self.contourDetect(img)
            print("height: ", height, ", stride: ", length, ", lowerbody: ", round(0.53 * height, 2), ", upperbody: ", round(0.4 * height, 2))
            boxImg = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
            boxImg = cv2.rectangle(boxImg, (x, y), (x + length, y + height), (0, 0, 255), 2)
            cv2.line(boxImg, (0, int(y + 0.39 * height)), (640, int(y + 0.39 * height)), (0, 255, 0), 2)
            cv2.line(boxImg, (0, int(y + 0.15 * height)), (640, int(y + 0.15 * height)), (255, 0, 0), 2)

            skel1 = self.skelRegion(img, x, y, height, length)

            skel = cv2.cvtColor(skel, cv2.COLOR_GRAY2BGR)
            self.outOriginal.write(frame)

            self.outDetect.write(boxImg)
            self.outSkel.write(skel1)            

            self.frameCount += 1

            if self.frameCount % 10 == 0 : 
                self.trackProgress(self.frameCount/240)

        print("processing done!")
        self.cap.release()
        self.outDetect.release()
        self.outOriginal.release()
        self.outSkel.release()
    ########################
        self.threadCompleted.emit()
        # print("done")
        # self.emit(SIGNAL("signal"),"completed")


    def trackProgress(self, percent) :
        self.frameProgress.emit(int(percent*100))

    def skeltonize(self, img) :
        size = np.size(img)
        skel = np.zeros(img.shape,np.uint8)

        ret,img = cv2.threshold(img,127,255,cv2.THRESH_TOZERO)
        element = cv2.getStructuringElement(cv2.MORPH_RECT,(3,3))
        done = False

        while( not done):
            eroded = cv2.erode(img,element)
            temp = cv2.dilate(eroded,element)
            temp = cv2.subtract(img,temp)
            skel = cv2.bitwise_or(skel,temp)
            img = eroded.copy()

            zeros = size - cv2.countNonZero(img)
            if zeros==size:
                done = True

        return skel

    def houghTransform(self, edges, frame) :
        # lines = cv2.HoughLines(edges,1,np.pi/180,2)
        lines = cv2.HoughLinesP(edges, 1, np.pi/180, 10, 50, 1)
        # if  lines is not None:
        #     if lines[0] is not None:
        #         for rho,theta in lines[0]:
        #             a = np.cos(theta)
        #             b = np.sin(theta)
        #             x0 = a*rho
        #             y0 = b*rho
        #             x1 = int(x0 + 1000*(-b))
        #             y1 = int(y0 + 1000*(a))
        #             x2 = int(x0 - 1000*(-b))
        #             y2 = int(y0 - 1000*(a))

        #             cv2.line(frame,(x1,y1),(x2,y2),(0,255,0),3)
        if lines is not None :
            for line in lines :
                x1, y1, x2, y2 = line[0]
                cv2.line(edges, (x1, y1), (x2, y2), (0, 0, 0), 2)

        return edges

    def contourDetect(self, img) :

        im2,contours,hierarchy = cv2.findContours(img, 1, 2)
        x = y = h = w = 0
        if len(contours) > 0 : 
            # contours.pop()
            cnt = max(contours, key=cv2.contourArea)

            x,y,w,h = cv2.boundingRect(cnt)
            # im2 = cv2.rectangle(im2,(x,y),(x+w,y+h),(255,255,255),2)
            cv2.drawContours(im2, contours, -1, (255,255,255), 1)
        return x, y, h, w

    def skelRegion(self, img, x, y, h, w) :

        xy = [0] * 10

        xy[0], xy[1] = self.contourCenter(img, x, x + w, y, y + 5 )
        
        xy[2], xy[3] = self.contourCenter(img, x, x + w, int(y + 0.15 * h), int(y + 5 + 0.15 * h))

        xy[4], xy[5] = self.contourCenter(img, x, x + w, int(y + 0.39 * h), int(y + 5 + 0.39 * h))
        
        im3 = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
        cv2.circle(im3, (x + xy[0], y + xy[1]), 3, (0, 0, 255), -1)
        cv2.circle(im3, (x + xy[2], y + xy[3] + int(0.15 * h)), 3, (0, 0, 255), -1)
        cv2.line(im3, (x + xy[0], y + xy[1]), (x + xy[2], y + xy[3] + int(0.15 * h)), (255, 0, 0), 2)

        cv2.circle(im3, (x + xy[4], y + xy[5] + int(0.39 * h)), 3, (0, 0, 255), -1)
        cv2.line(im3, (x + xy[2], y + xy[3] + int(0.15 * h)), (x + xy[4], y + xy[5] + int(0.39 * h)), (255, 0, 0), 2)

        print(xy[0], xy[1])
        return im3
        
    def contourCenter(self, img, x1, x2, y1, y2) :

        c1 = img[y1:y2, x1:x2]
        im2, contours, hierarchy = cv2.findContours(c1, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        cx, cy = 0, 0

        if len(contours) > 0 :
            cnt = max(contours, key=cv2.contourArea)
            M = cv2.moments(cnt)
            cx = int(M["m10"] / M["m00"])
            cy = int(M["m01"] / M["m00"])

        return cx, cy 

class cacheThread(QObject) :
    def __init__(self) :
        QObject.__init__(self)
    
    cacheClear = pyqtSignal()

    @pyqtSlot()
    def deleteCache(self) :
        cacheDir = os.path.join(os.getcwd(), 'cache')
        files = os.listdir(cacheDir)
        [os.remove(os.path.abspath(os.path.join(cacheDir, file))) for file in files]
        print("cache cleared!")
        self.cacheClear.emit()

# Main Function
if __name__ == '__main__':
    # Create main app
    myApp = QApplication(sys.argv)
    # Create a label and set its properties
    engine = QQmlApplicationEngine()

    videoanalyze = processWindow()
    engine.rootContext().setContextProperty("videoanalyze", videoanalyze)
    # engine.addImageProvider("OCV", win)
    engine.load('main.qml')
    # win = engine.rootObjects()[0]
    # Show the Label
    # win.showFullScreen()

    # Execute the Application and Exit
    myApp.exec_()
    sys.exit()

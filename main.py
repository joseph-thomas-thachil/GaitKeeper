import sys
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

    def progress(self, percent) :

        self.processStatus.emit(percent)
    
    def done(self) :
        self.processCompleted.emit(1)


class busyThread(QObject) :
    def __init__(self) :
        QObject.__init__(self)

    threadCompleted = pyqtSignal()
    frameProgress = pyqtSignal(int)

    @pyqtSlot()
    def do_work(self) :
        # vid = vprocess("souces/gait.mp4")

    ########################
        self.cap = cv2.VideoCapture("sources/walk_sample.mp4")

        self.hog = cv2.HOGDescriptor()
        self.hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())

        # self.surf = cv2.xfeatures2d.SURF_create(5000)

        self.frameWidth = int(self.cap.get(3))
        self.frameHeight = int(self.cap.get(4))

        self.outOriginal = cv2.VideoWriter('cache/original.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))
        self.outDetect = cv2.VideoWriter('cache/detect.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 24, (self.frameWidth, self.frameHeight))

        self.fgbg = cv2.bgsegm.createBackgroundSubtractorMOG()

        self.frameCount = 0

        while self.frameCount < 240 :

            status, frame = self.cap.read()

            if not status :
                break

            fgmask = self.fgbg.apply(frame)

            # kp, des = self.surf.detectAndCompute(frame, None)
            # print(len(kp))
            # keyFrame = cv2.drawKeypoints(frame, kp, None, (255, 0, 0), 4)
            # found,w = self.hog.detectMultiScale(frame, winStride=(8,8), padding=(32,32), scale=1.05)
            # for x, y, w, h in found:
                # pad_w, pad_h = int(0.15*w), int(0.05*h)
                # cv2.rectangle(frame, (x+pad_w, y+pad_h), (x+w-pad_w, y+h-pad_h), (0, 255, 0), 1)

            # self.draw_detections(fgmask,found)
            
            self.outOriginal.write(frame)
            self.outDetect.write(cv2.merge([fgmask, fgmask, fgmask]))

            self.frameCount += 1

            if self.frameCount % 10 == 0 : 
                self.trackProgress(self.frameCount/240)

        print("processing done!")
        self.cap.release()
        self.outDetect.release()
        self.outOriginal.release()
    ########################
        self.threadCompleted.emit()
        # print("done")
        # self.emit(SIGNAL("signal"),"completed")

    def draw_detections(img, rects, thickness = 1):
        for x, y, w, h in rects:
            pad_w, pad_h = int(0.15*w), int(0.05*h)
            cv2.rectangle(img, (x+pad_w, y+pad_h), (x+w-pad_w, y+h-pad_h), (0, 255, 0), thickness)


    def trackProgress(self, percent) :
        self.frameProgress.emit(int(percent*100))

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

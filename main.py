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
    
    @pyqtSlot()
    def process(self) :
        # vid = vprocess("sources/sample.mp4")
        self.busy = busyThread()
        self.thread = QThread(self)
        self.busy.threadCompleted.connect(self.done)
        self.busy.moveToThread(self.thread)
        self.thread.started.connect(self.busy.do_work)
        self.thread.start()
        # self.busy.finished.connect(self.done)
        # self.ProcessCompleted.connect(self.busy, SIGNAL("signal"), self.done)
        # self.busy.start()

    
    def done(self) :
        self.processCompleted.emit(1)


class busyThread(QObject) :
    def __init__(self) :
        QObject.__init__(self)

    threadCompleted = pyqtSignal()
    
    @pyqtSlot()
    def do_work(self) :
        # vid = vprocess("souces/gait.mp4")

    ########################
        self.cap = cv2.VideoCapture("sources/gait.mp4")
        self.frame_width = int(self.cap.get(3))
        self.frame_height = int(self.cap.get(4))

        self.out_original = cv2.VideoWriter('cache/original.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 30, (self.frame_width, self.frame_height))
        self.out_detect = cv2.VideoWriter('cache/detect.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 30, (self.frame_width, self.frame_height))

        self.fgbg = cv2.bgsegm.createBackgroundSubtractorMOG()

        while True :

            status, frame = self.cap.read()

            if not status :
                break

            fgmask = self.fgbg.apply(frame)
            
            self.out_original.write(frame)
            self.out_detect.write(cv2.merge([fgmask, fgmask, fgmask]))

        print("processing done!")
        self.cap.release()
        self.out_detect.release()
        self.out_original.release()
    ########################
        self.threadCompleted.emit()
        # print("done")
        # self.emit(SIGNAL("signal"),"completed")


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

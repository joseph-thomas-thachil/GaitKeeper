import sys
from videoprocess import *
from PyQt5.QtGui import QImage
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem, QQuickImageProvider
from PyQt5.QtQml import QQmlApplicationEngine


class processWindow(QObject) :
    def __init__(self) :
        QObject.__init__(self)
        vid = vprocess("sources/sample.mp4")

    ProcessCompleted = pyqtSignal(arguments=['process'])

    @pyqtSlot()
    def process(self) :
        self.ProcessCompleted.emit()


# Main Function
if __name__ == '__main__':
    # Create main app
    myApp = QApplication(sys.argv)
    # Create a label and set its properties
    engine = QQmlApplicationEngine()

    win = processWindow()
    engine.rootContext().setContextProperty("videoanalyze", win)
    # engine.addImageProvider("OCV", win)
    engine.load('main.qml')
    # win = engine.rootObjects()[0]
    # Show the Label
    # win.showFullScreen()

    # Execute the Application and Exit
    myApp.exec_()
    sys.exit()

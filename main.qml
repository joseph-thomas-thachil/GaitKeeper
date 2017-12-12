import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtMultimedia 5.9

ApplicationWindow {
    visible: true
    width: 1920
    height: 1080
    visibility: Window.FullScreen
    title: qsTr("GaitKeeper")
    color: "#454545"

    Image {
        id: gaitframe
        x: 66
        y: 49
        width: 1049
        height: 330
        fillMode: Image.Tile
        source: "images/gaitBG.png"
    }


    Video {
        id: detectframe
        x: 66
        y: 426
        width: 1049
        height: 335
        fillMode: 0
        autoPlay: true
        source: "cache/detect.avi"
//        source: "qrc:/qtquickplugin/images/template_image.png"
    }

    Video {
        id: originalframe
        x: 66
        y: 795
        width: 520
        height: 230
        fillMode: 0
        autoPlay: true
        source: "cache/original.avi"
//        source: "qrc:/qtquickplugin/images/template_image.png"
    }

    Image {
        id: mugshot
        x: 745
        y: 795
        width: 272
        height: 230
        source: "images/proBG.png"
    }

    Label {
        id: details
        x: 1077
        y: 795
        width: 786
        height: 230
        text: qsTr("Label")
    }

//    Connections {
//        target: videoanalyze

//        onProcessCompleted: {
//            originalframe.source="cache/original.avi"
//            detectframe.source="cache/detect.avi"
//        }
//    }
}

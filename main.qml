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
    color: "#002b36"

    Rectangle {
        id: gaitframe
        x: 66
        y: 49
        width: 1049
        height: 330
        color: "#00000000"
        border.color: "#00afaf"
        border.width: 5
        Frame {
            padding: 5
            anchors.fill: parent
            Image {
                anchors.fill: parent
                fillMode: Image.Tile
                source: "images/gaitBG.png"
            }
        }
    }

    Button {
        id: control
        x: 1440
        y: 49
        text: qsTr("START")
        background: Rectangle {
            implicitWidth: 423
            implicitHeight: 48
            opacity: enabled ? 1 : 0.3
            color: control.down ? "#cb4b16" : "#2aa198"
        }

        onClicked: {
            busyIndicator.visible = true
            progressBar.visible = true
            videoanalyze.process()
        }
    }

    Rectangle {
        id: detectframe
        x: 66
        y: 426
        width: 1049
        height: 335
        color: "#00000000"
        border.color: "#00afaf"
        border.width: 5
        Video {
            id: detectvideo
            anchors.fill: parent
            fillMode: 0
            autoPlay: true
            source: ""
        }

    }

    Rectangle {
        id: originalframe
        x: 66
        y: 795
        width: 520
        height: 230
        color: "#00000000"
        border.color: "#00afaf"
        border.width: 5
        Video {
            id: originalvideo
            anchors.fill: parent
            fillMode: 0
            autoPlay: true
            source: ""
        }

    }

    Rectangle {
        id: mugshotframe
        x: 745
        y: 795
        width: 272
        height: 230
        color: "#00000000"
        border.color: "#00afaf"
        border.width: 5
        Frame {
            padding: 5
            anchors.fill: parent
            Image {
                id: mugshot
                anchors.fill: parent
                source: "images/proBG.png"
            }
        }
    }

    Rectangle {
        id: detailsframe
        x: 1077
        y: 795
        width: 786
        height: 230
        color: "#00000000"
        border.color: "#00afaf"
        border.width: 5
        Frame {
            padding: 5
            anchors.fill: parent
            Label {
                id: details
                text: qsTr("Label")
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        x: 1791
        y: 51
        width: 72
        height: 44
        visible: false
    }

    ProgressBar {
        id: progressBar
        x: 1440
        y: 95
        width: 423
        height: 64
        value: 0.0
        visible: false
    }

    Connections {
        target: videoanalyze

        onProcessStatus: {
            progressBar.value=val/100
        }

        onProcessCompleted: {
            busyIndicator.visible=false
            progressBar.visible=false
            detectvideo.source="cache/detect.avi"
            originalvideo.source="cache/original.avi"
        }
    }

}

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtMultimedia 5.9

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 1280
    minimumHeight: 720
    visibility: Window.FullScreen
    title: qsTr("GaitKeeper")
    color: "#212121"
//    ColumnLayout {
//        spacing: 20
//        x: 30
//        y: 20
        Rectangle {
            id: gaitframe
//            x: 66
//            y: 29
//            width: 549
//            height: 230

            implicitWidth: root.width / 2
            implicitHeight: root.height / 3
            color: "#00000000"
            border.color: "#e65100"
            border.width: 5
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 10
            Frame {
                padding: 5
                anchors.fill: parent
                Image {
                    anchors.fill: parent
                    fillMode: Image.Tile
                    source: "images/plot.png"
                }
            }
        }

        Rectangle {
            id: detectframe
//            x: 66
//            y: 289
//            width: 549
//            height: 230

            implicitWidth: root.width / 2
            implicitHeight: root.height / 3
            color: "#00000000"
            border.color: "#e65100"
            border.width: 5
            anchors.left: parent.left
            anchors.top: gaitframe.bottom
            anchors.margins: 10
            Video {
                id: detectvideo
                anchors.fill: parent
                fillMode: 0
                autoPlay: true
                source: ""
            }

        }
//    }

//    ColumnLayout {
//        spacing: 50
//        x:20
        Button {
            id: start
//            x: 1079
//            y: 29
            implicitWidth: root.width / 7
            implicitHeight: root.height / 20
            anchors.right: detailsframe.right
            anchors.top: gaitframe.top
            contentItem: Text {
                text: qsTr("START")
                font.pointSize: 12
                opacity: enabled ? 1.0 : 0.3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 223
                implicitHeight: 48
                opacity: enabled ? 1 : 0.3
                color: start.down ? "#757575" : "#9e9e9e"
            }

            onClicked: {
                progressBar.visible = true
                detectvideo.source = ""
                originalvideo.source = ""
                progressBar.value = 0.0
                start.down = true
                videoanalyze.process()
            }
        }

        Button {
            id: clearCache
//            x: 1079
//            y: 220
            implicitWidth: start.width
            implicitHeight: start.height
            anchors.right: start.right
            anchors.top: progressBar.bottom
            anchors.topMargin: 40
            contentItem: Text {
                text: qsTr("CLEAR CACHE")
                font.pointSize: 12
                opacity: enabled ? 1.0 : 0.3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 223
                implicitHeight: 48
                opacity: enabled ? 1: 0.3
                color: clearCache.down ? "#757575" : "#9e9e9e"
            }
        }
//    }


    Rectangle {
        id: originalframe
//        x: 66
//        y: 549
//        width: 320
//        height: 180
        implicitWidth: root.width / 3
        implicitHeight: root.height - detectframe.y - detectframe.height - 20
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        anchors.left: detectframe.left
        anchors.top: detectframe.bottom
        anchors.topMargin: 10
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
//        x: 445
//        y: 549
//        width: 230
//        height: 180
        implicitHeight: originalframe.height
        implicitWidth: implicitHeight
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        anchors.left: originalframe.right
        anchors.top: originalframe.top
        anchors.leftMargin: 50
        Frame {
            padding: 5
            anchors.fill: parent
            Image {
                id: mugshot
                anchors.fill: parent
                source: "images/avatar.png"
            }
        }
    }

    Rectangle {
        id: detailsframe
//        x: 697
//        y: 549
//        width: 486
//        height: 180
        implicitWidth: root.width - mugshotframe.x - mugshotframe.width - 20
        implicitHeight: originalframe.height
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        anchors.left: mugshotframe.right
        anchors.top: detectframe.bottom
        anchors.margins: 10
        Frame {
            padding: 5
            anchors.fill: parent
            Image {
                id: details
                anchors.fill: parent
                source: "images/document.png"
            }
        }
    }

    ProgressBar {
        id: progressBar
        value: 0.0
        padding: 2
//        x: 1079
//        y: 95
        implicitWidth: start.width
        anchors.right: start.right
        anchors.top: start.bottom
        anchors.topMargin: 10
        visible: false
        background: Rectangle {
            implicitWidth: 223
            implicitHeight: 9
            color: "#00000000"
            radius: 3
        }

        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 4

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                radius: 2
                color: "#e65100"
            }
        }
    }

    Connections {
        target: videoanalyze

        onProcessStatus: {
            progressBar.value=val/100
        }

        onProcessCompleted: {
            progressBar.visible=false
            start.down = false
            detectvideo.source="cache/detect.avi"
            originalvideo.source="cache/original.avi"
        }
    }

}

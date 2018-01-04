import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtMultimedia 5.9
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 1024
    minimumHeight: 576
    visibility: Window.FullScreen
    title: qsTr("GaitKeeper")
    color: "#da000000"

//    LinearGradient {
//        anchors.fill: parent
//        start: Qt.point(0, 0)
//        end: Qt.point(parent.width, parent.height)
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "#ea18cae6" }
//            GradientStop { position: 1.0; color: "#2b2a9978" }
//        }
//    }

    FontLoader {
        id: customFont
        source: "sources/Elianto-Regular.ttf"
    }

    Rectangle {
        id: skelblock
        color: "#01579b"
        implicitWidth: root.width / 90
        implicitHeight: root.height / 7
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10

        Label {
            id: skeltext
            color: "#b3e5fc"
            text: qsTr("G\nA\nI\nT")
            font.family: customFont.name
            fontSizeMode: Text.VerticalFit
            anchors.fill: parent
//            font.pointSize: 9
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: skelside
        color: "#01579b"
        implicitWidth: 5
        implicitHeight: skelvideo.height - skelblock.y - skelblock.height + 20
        anchors.right: skelblock.right
        anchors.top: skelblock.bottom
    }

    Rectangle {
        id: skeltop
        color: "#01579b"
        implicitWidth: root.width / 2 + 5
        implicitHeight: 5
        anchors.top: parent.top
        anchors.left: skelblock.right
        anchors.topMargin: 10
    }

    Video {
        id:skelvideo
        implicitWidth: root.width / 2
        implicitHeight: root.height / 3 - 10
        anchors.left: skelblock.right
        anchors.top: skelblock.top
        anchors.margins: 5
        anchors.leftMargin: 0
        fillMode: 0
        autoPlay: true
        source: ""
    }

    Label {
        id: skeldef
        anchors.fill: skelvideo
        color: "#b3e5fc"
        text: qsTr("No preview Available")
        font.family: customFont.name
        font.pointSize: 16
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: detectblock
        color: "#01579b"
        implicitWidth: root.width / 90
        implicitHeight: root.height / 7
        anchors.left: parent.left
        anchors.top: skelvideo.bottom
        anchors.margins: 10

        Label {
            id: detecttext
            color: "#b3e5fc"
            text: qsTr("D\nE\nT\nE\nC\nT")
            font.family: customFont.name
            fontSizeMode: Text.VerticalFit
            anchors.fill: parent
//            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Video {
        id: detectvideo
//        visible: false
        implicitWidth: root.width / 2
        implicitHeight: root.height / 3 - 10
        anchors.left: detectblock.right
        anchors.top: detectblock.top
        anchors.margins: 5
        anchors.leftMargin: 0
        fillMode: 0
        autoPlay: true
        source: ""
    }


    Label {
        id: detectdef
        anchors.fill: detectvideo
        color: "#b3e5fc"
        text: qsTr("No preview Available")
        font.family: customFont.name
        font.pointSize: 16
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: detectside
        color: "#01579b"
        implicitWidth: 5
        implicitHeight: detectvideo.height - detectblock.height + 10
        anchors.right: detectblock.right
        anchors.top: detectblock.bottom
    }

    Rectangle {
        id: detecttop
        color: "#01579b"
        implicitWidth: root.width / 2 + 5
        implicitHeight: 5
        anchors.top: detectblock.top
        anchors.left: detectblock.right
    }

    Rectangle {
        id: originalblock
        color: "#01579b"
        implicitWidth: root.width / 90
        implicitHeight: (root.height - detectvideo.y - detectvideo.height - 20)/2
        anchors.left: parent.left
        anchors.top: detectvideo.bottom
        anchors.margins: 10

        Label {
            id: originaltext
            color: "#b3e5fc"
            text: qsTr("O\nR\nI\nG\nI\nN\nA\nL")
            font.family: customFont.name
            fontSizeMode: Text.VerticalFit
            anchors.fill: parent
//            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Video {
        id:originalvideo
        implicitWidth: root.width / 3
        implicitHeight: root.height - detectvideo.y - detectvideo.height - 30
        anchors.left: originalblock.right
        anchors.top: originalblock.top
        anchors.margins: 5
        anchors.leftMargin: 0
        fillMode: 0
        autoPlay: true
        source: ""
    }


    Label {
        id: originaldef
        anchors.fill: originalvideo
        color: "#b3e5fc"
        text: qsTr("No preview Available")
        font.family: customFont.name
        font.pointSize: 16
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: originalside
        color: "#01579b"
        implicitWidth: 5
        implicitHeight: originalvideo.height - originalblock.height + 10
        anchors.right: originalblock.right
        anchors.top: originalblock.bottom
    }

    Rectangle {
        id: originaltop
        color: "#01579b"
        implicitWidth: originalvideo.width + 5
        implicitHeight: 5
        anchors.top: originalblock.top
        anchors.left: originalblock.right
    }

    Button {
        id: start
        implicitWidth: root.width / 7
        implicitHeight: root.height / 20
        anchors.right: detailsblock.left
//        x: root.width - 10 - start.width
        anchors.top: originalvideo.top
        anchors.rightMargin: 30
        contentItem: Text {
            text: qsTr("START")
            fontSizeMode: Text.Fit
            id: starttext
            font.family: customFont.name
            color: "#01579b"
            font.pointSize: 24
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }        
        background: Rectangle {
            implicitWidth: 223
            implicitHeight: 48
            opacity: 0
        }

        onClicked: {
            progressBar.visible = true
            detectvideo.source = ""
            originalvideo.source = ""
            skelvideo.source = ""
            progressBar.value = 0.0
            start.enabled = false
            clearCache.enabled = false
            videoanalyze.process()
        }

        Glow {
                anchors.fill: starttext
                id: startglow
                radius: 8
                samples: 17
                color: "#b3e5fc"
                source: starttext
                visible: false
            }

        onHoveredChanged: hovered ? startglow.visible=true : startglow.visible=false
    }



        Button {
            id: clearCache
            implicitWidth: start.width
            implicitHeight: start.height
            anchors.right: start.right
            anchors.top: progressBar.bottom
            anchors.topMargin: 40
            contentItem: Text {
                text: qsTr("CLEAR CACHE")
                fontSizeMode: Text.Fit
                id: cachetext
                font.family: customFont.name
                color: "#01579b"
                font.pointSize: 24
                opacity: enabled ? 1.0 : 0.3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 223
                implicitHeight: 48
                opacity: 0
            }

            onClicked: {
                clearCache.enabled = false
                start.enabled = false
                videoanalyze.clearprocess()
            }

            Glow {
                    anchors.fill: cachetext
                    id: cacheglow
                    radius: 8
                    samples: 17
                    color: "#b3e5fc"
                    source: cachetext
                    visible: false
                }

            onHoveredChanged: hovered ? cacheglow.visible=true : cacheglow.visible=false

        }

        Label {
            id: cacheText
            visible: false
            width: clearCache.width / 2
            height: clearCache.height / 4
            color: "#01579b"
            anchors.left: start.left
            anchors.top: clearCache.bottom
            anchors.topMargin: 2
            font.family: customFont.name
            text: qsTr("CACHE CLEARED!")
            font.pointSize: 9

        }

        Timer {
            id: cacheTimer
            interval: 5000
            onTriggered: cacheText.visible=false
        }

    Rectangle {
        id: mugshotblock
        implicitWidth: root.width / 90
        implicitHeight: originalblock.height
        color: "#01579b"
        anchors.right: mugshotframe.left
        anchors.top: skelblock.top
        anchors.leftMargin: 50

        Label {
            id: mugshottext
            color: "#b3e5fc"
            text: qsTr("M\nU\nG\nS\nH\nO\nT")
            font.family: customFont.name
            fontSizeMode: Text.VerticalFit
            anchors.fill: parent
//            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }
        Frame {
            id: mugshotframe
            implicitHeight: originalvideo.height - 10
            implicitWidth: implicitHeight
//            anchors.left: mugshotblock.right
            x: root.width - 10 - mugshotframe.width
            anchors.top: mugshotblock.top
            anchors.margins: 5
            anchors.leftMargin: 0
            Image {
                id: mugshot
                anchors.fill: parent
                source: ""
            }
        }


        Label {
            id: mugshotdef
            anchors.fill: mugshotframe
            color: "#b3e5fc"
            text: qsTr("No preview Available")
            font.family: customFont.name
            font.pointSize: 16
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: mugshotside
            color: "#01579b"
            implicitWidth: 5
            implicitHeight: mugshotframe.height - mugshotblock.height + 10
            anchors.right: mugshotblock.right
            anchors.top: mugshotblock.bottom
        }

        Rectangle {
            id: mugshottop
            color: "#01579b"
            implicitWidth: mugshotframe.width + 5
            implicitHeight: 5
            anchors.top: mugshotblock.top
            anchors.left: mugshotblock.right
        }

    Rectangle {
        id: detailsblock
        implicitWidth: root.width / 90
        implicitHeight: (originalblock.y - mugshotblock.y - 10) / 3
        color: "#01579b"
        anchors.left: mugshotblock.left
        anchors.top: mugshotframe.bottom
        anchors.topMargin: 10

        Label {
            id: detailstext
            color: "#b3e5fc"
            text: qsTr("D\nE\nT\nA\nI\nL\nS")
            font.family: customFont.name
            fontSizeMode: Text.VerticalFit
            anchors.fill: parent
//            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

        Frame {
            id: detailsframe
            implicitWidth: mugshotframe.width
            implicitHeight: detailsblock.height * 3 - 10
            anchors.left: detailsblock.right
            anchors.top: detailsblock.top
            anchors.margins: 5
            anchors.leftMargin: 0
            Image {
                id: details
                anchors.fill: parent
                source: ""
            }
        }


        Label {
            id: detailsdef
            anchors.fill: detailsframe
            color: "#b3e5fc"
            text: qsTr("No preview Available")
            font.family: customFont.name
            font.pointSize: 16
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: detailsside
            color: "#01579b"
            implicitWidth: 5
            implicitHeight: detailsframe.height - detailsblock.height + 10
            anchors.right: detailsblock.right
            anchors.top: detailsblock.bottom
        }

        Rectangle {
            id: detailstop
            color: "#01579b"
            implicitWidth: detailsframe.width + 5
            implicitHeight: 5
            anchors.top: detailsblock.top
            anchors.left: detailsblock.right
        }

    ProgressBar {
        id: progressBar
        value: 0.0
        padding: 2
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
                color: "#01579b"
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
            start.enabled = true
            clearCache.enabled = true
            detectvideo.source="cache/detect.avi"
            originalvideo.source="cache/original.avi"
            skelvideo.source="cache/skel.avi"
            skelvideo.z = 1
            detectvideo.z = 1
            originalvideo.z = 1
        }

        onCacheCompleted: {
            clearCache.enabled = true
            start.enabled = true
            cacheText.visible = true
            cacheTimer.start()
        }
    }

}

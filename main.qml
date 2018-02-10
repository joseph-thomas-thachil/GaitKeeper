import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 1024
    minimumHeight: 576
    visibility: Window.FullScreen
    title: qsTr("GaitKeeper")
    color: "#da000000"

    FontLoader {
        id: customFont
        source: "sources/Elianto-Regular.ttf"
    }

    SwipeView {
        id: view
        currentIndex: 1
        anchors.fill: parent

        Item {
            id: verifyPage
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
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

            }
                Frame {
                    id: mugshotframe
                    implicitHeight: originalvideo.height - 10
                    implicitWidth: implicitHeight
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

        //    ComboBox {
        //        id: userlist
        //        implicitWidth: root.width / 7
        //        implicitHeight: root.height / 20
        //        anchors.right: detailsblock.left
        ////        x: root.width - 10 - start.width
        //        anchors.top: mugshotframe.top
        //        anchors.rightMargin: 30
        //        currentIndex: 2
        //        model: [ "item 1", "item 2", "item 3" ]
        //        style: ComboBoxStyle {
        //            font: customFont.name
        //            textColor: "#01579b"
        //        }

        //        background: Rectangle {
        //            implicitWidth: 223
        //            implicitHeight: 48
        //            opacity: 0
        //        }
        //    }

            Rectangle {
                id: detailsblock
                implicitWidth: root.width / 90
                implicitHeight: (originalblock.y - mugshotblock.y - 10) / 4
                color: "#01579b"
                anchors.right: detailsframe.left
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
                    implicitWidth: root.width / 3
                    implicitHeight: detailsblock.height * 2 - 10
                    anchors.right: mugshotframe.right
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

            Button {
                id: next1
                implicitWidth: start.width
                implicitHeight: start.height * 2
                anchors.right: mugshotframe.right
                anchors.bottom: originalvideo.bottom
                anchors.bottomMargin: 50
                contentItem: Text {
                    text: qsTr(">")
                    fontSizeMode: Text.Fit
                    id: nexttext1
                    font.family: customFont.name
                    color: "#01579b"
                    font.pointSize: 48
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
                    view.currentIndex = 1
                }

                Glow {
                        anchors.fill: nexttext1
                        id: nextglow1
                        radius: 8
                        samples: 17
                        color: "#b3e5fc"
                        source: nexttext1
                        visible: false
                    }

                onHoveredChanged: hovered ? nextglow1.visible=true : nextglow1.visible=false

            }

            Text {
                id: pagetext1
                width: userid.width
                height: userid.height
                x: root.width - 10 - userid.width
                text: qsTr("Verification")
                font.family: customFont.name
                font.pointSize: 24
                color: "#b3e5fc"
                y: root.height - 10 - userid.height

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

        Item {
            id: registerPage
            Rectangle {
                id: rskelblock
                color: "#01579b"
                implicitWidth: root.width / 90
                implicitHeight: root.height / 7
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 10

                Label {
                    id: rskeltext
                    color: "#b3e5fc"
                    text: qsTr("G\nA\nI\nT")
                    font.family: customFont.name
                    fontSizeMode: Text.VerticalFit
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                id: rskelside
                color: "#01579b"
                implicitWidth: 5
                implicitHeight: rskelvideo.height - rskelblock.y - rskelblock.height + 20
                anchors.right: rskelblock.right
                anchors.top: rskelblock.bottom
            }

            Rectangle {
                id: rskeltop
                color: "#01579b"
                implicitWidth: root.width / 2 + 5
                implicitHeight: 5
                anchors.top: parent.top
                anchors.left: rskelblock.right
                anchors.topMargin: 10
            }

            Video {
                id:rskelvideo
                implicitWidth: root.width / 2
                implicitHeight: root.height / 3 - 10
                anchors.left: rskelblock.right
                anchors.top: rskelblock.top
                anchors.margins: 5
                anchors.leftMargin: 0
                fillMode: 0
                autoPlay: true
                source: ""
            }

            Label {
                id: rskeldef
                anchors.fill: rskelvideo
                color: "#b3e5fc"
                text: qsTr("No preview Available")
                font.family: customFont.name
                font.pointSize: 16
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: rdetectblock
                color: "#01579b"
                implicitWidth: root.width / 90
                implicitHeight: root.height / 7
                anchors.left: parent.left
                anchors.top: rskelvideo.bottom
                anchors.margins: 10

                Label {
                    id: rdetecttext
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
                id: rdetectvideo
        //        visible: false
                implicitWidth: root.width / 2
                implicitHeight: root.height / 3 - 10
                anchors.left: rdetectblock.right
                anchors.top: rdetectblock.top
                anchors.margins: 5
                anchors.leftMargin: 0
                fillMode: 0
                autoPlay: true
                source: ""
            }


            Label {
                id: rdetectdef
                anchors.fill: rdetectvideo
                color: "#b3e5fc"
                text: qsTr("No preview Available")
                font.family: customFont.name
                font.pointSize: 16
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: rdetectside
                color: "#01579b"
                implicitWidth: 5
                implicitHeight: rdetectvideo.height - rdetectblock.height + 10
                anchors.right: rdetectblock.right
                anchors.top: rdetectblock.bottom
            }

            Rectangle {
                id: rdetecttop
                color: "#01579b"
                implicitWidth: root.width / 2 + 5
                implicitHeight: 5
                anchors.top: rdetectblock.top
                anchors.left: rdetectblock.right
            }

            Rectangle {
                id: roriginalblock
                color: "#01579b"
                implicitWidth: root.width / 90
                implicitHeight: (root.height - rdetectvideo.y - rdetectvideo.height - 20)/2
                anchors.left: parent.left
                anchors.top: rdetectvideo.bottom
                anchors.margins: 10

                Label {
                    id: roriginaltext
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
                id:roriginalvideo
                implicitWidth: root.width / 3
                implicitHeight: root.height - rdetectvideo.y - rdetectvideo.height - 30
                anchors.left: roriginalblock.right
                anchors.top: roriginalblock.top
                anchors.margins: 5
                anchors.leftMargin: 0
                fillMode: 0
                autoPlay: true
                source: ""
            }


            Label {
                id: roriginaldef
                anchors.fill: roriginalvideo
                color: "#b3e5fc"
                text: qsTr("No preview Available")
                font.family: customFont.name
                font.pointSize: 16
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: roriginalside
                color: "#01579b"
                implicitWidth: 5
                implicitHeight: roriginalvideo.height - roriginalblock.height + 10
                anchors.right: roriginalblock.right
                anchors.top: roriginalblock.bottom
            }

            Rectangle {
                id: roriginaltop
                color: "#01579b"
                implicitWidth: roriginalvideo.width + 5
                implicitHeight: 5
                anchors.top: roriginalblock.top
                anchors.left: roriginalblock.right
            }

            Button {
                id: rstart
                implicitWidth: root.width / 7
                implicitHeight: root.height / 20
                anchors.right: imgUpload.left
                anchors.top: roriginalvideo.top
                anchors.rightMargin: 30
                contentItem: Text {
                    text: qsTr("START")
                    fontSizeMode: Text.Fit
                    id: rstarttext
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
                    if ((userid.length > 0 ) && (username.length > 0) && (userpos.length > 0) && (userclr.length > 0) && (upimg.source != "")) {
                        rprogressBar.visible = true
                        rdetectvideo.source = ""
                        roriginalvideo.source = ""
                        rskelvideo.source = ""
                        rprogressBar.value = 0.0
                        rstart.enabled = false
                        rclearCache.enabled = false
                        videoanalyze.process(true, userid.text)
                        console.log(userid.data)
                    }
                }

                Glow {
                        anchors.fill: rstarttext
                        id: rstartglow
                        radius: 8
                        samples: 17
                        color: "#b3e5fc"
                        source: rstarttext
                        visible: false
                    }

                onHoveredChanged: hovered ? rstartglow.visible=true : rstartglow.visible=false
            }



                Button {
                    id: rclearCache
                    implicitWidth: rstart.width
                    implicitHeight: rstart.height
                    anchors.right: rstart.right
                    anchors.top: rprogressBar.bottom
                    anchors.topMargin: 40
                    contentItem: Text {
                        text: qsTr("CLEAR CACHE")
                        fontSizeMode: Text.Fit
                        id: rcachetext
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
                        rclearCache.enabled = false
                        rstart.enabled = false
                        videoanalyze.clearprocess()
                    }

                    Glow {
                            anchors.fill: rcachetext
                            id: rcacheglow
                            radius: 8
                            samples: 17
                            color: "#b3e5fc"
                            source: rcachetext
                            visible: false
                        }

                    onHoveredChanged: hovered ? rcacheglow.visible=true : rcacheglow.visible=false

                }

                Label {
                    id: rcacheText
                    visible: false
                    width: rclearCache.width / 2
                    height: rclearCache.height / 4
                    color: "#01579b"
                    anchors.left: rstart.left
                    anchors.top: rclearCache.bottom
                    anchors.topMargin: 2
                    font.family: customFont.name
                    text: qsTr("CACHE CLEARED!")
                    font.pointSize: 9

                }

                Timer {
                    id: rcacheTimer
                    interval: 5000
                    onTriggered: rcacheText.visible=false
                }

                Text {
                    id: infoData
                    width: userid.width
                    height: userid.height
                    x: root.width - 10 - infoData.width
                    text: qsTr("Profile")
                    font.family: customFont.name
                    font.pointSize: 22
                    color: "#01579b"
                    anchors.top: rskelblock.top
                }

                Text {
                    id: usertext
                    anchors.right: userid.left
                    anchors.top: userid.top
                    anchors.margins: 10
                    text: qsTr("UserID")
                    font.family: customFont.name
                    font.pointSize: 14
                    color: "#01579b"
                }
                TextField {
                  id: userid
                  anchors.top: rskelblock.top
                  implicitWidth: root.width / 4
                  x: root.width - 10 - userid.width
                  anchors.topMargin: 50
                  color: "#b3e5fc"
                  background: Rectangle {
                      implicitWidth: 223
                      implicitHeight: 48
                      color: "#00000000"
                      border.width: 1
                      border.color: "#01579b"
                  }
               }

                Text {
                    id: nametext
                    anchors.right: username.left
                    anchors.top: username.top
                    anchors.margins: 10
                    text: qsTr("Name")
                    font.family: customFont.name
                    font.pointSize: 14
                    color: "#01579b"
                }
                TextField {
                  id: username
                  anchors.top: userid.bottom
                  implicitWidth: root.width / 4
                  anchors.left: userid.left
                  anchors.topMargin: 20
                  color: "#b3e5fc"
                  background: Rectangle {
                      implicitWidth: 223
                      implicitHeight: 48
                      color: "#00000000"
                      border.width: 1
                      border.color: "#01579b"
                  }
               }

                Text {
                    id: placetext
                    anchors.right: userpos.left
                    anchors.top: userpos.top
                    anchors.margins: 10
                    text: qsTr("Position")
                    font.family: customFont.name
                    font.pointSize: 14
                    color: "#01579b"
                }
                TextField {
                  id: userpos
                  anchors.top: username.bottom
                  implicitWidth: root.width / 4
                  anchors.left: username.left
                  anchors.topMargin: 20
                  color: "#b3e5fc"
                  background: Rectangle {
                      implicitWidth: 223
                      implicitHeight: 48
                      color: "#00000000"
                      border.width: 1
                      border.color: "#01579b"
                  }
               }

               Text {
                    id: cleartext
                    anchors.right: userclr.left
                    anchors.top: userclr.top
                    anchors.margins: 10
                    text: qsTr("Clearance Level")
                    font.family: customFont.name
                    font.pointSize: 14
                    color: "#01579b"
                }
                TextField {
                  id: userclr
                  anchors.top: userpos.bottom
                  implicitWidth: root.width / 4
                  anchors.left: userpos.left
                  anchors.topMargin: 20
                  color: "#b3e5fc"
                  background: Rectangle {
                      implicitWidth: 223
                      implicitHeight: 48
                      color: "#00000000"
                      border.width: 1
                      border.color: "#01579b"
                  }
               }
                Button {
                    id: imgUpload
                    implicitWidth: root.width / 8
                    implicitHeight: usertext.height * 2
                    anchors.right: imgframe.left
                    anchors.top: cleartext.bottom
                    anchors.topMargin: 90
                    contentItem: Text {
                        text: qsTr("PHOTO UPLOAD")
                        fontSizeMode: Text.Fit
                        id: imgtext
                        font.family: customFont.name
                        color: "#01579b"
                        font.pointSize: 24
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        implicitWidth: 223
                        implicitHeight: 48
                        opacity: 0
                    }

                    onClicked: {
                        rclearCache.enabled = false
                        rstart.enabled = false
                        imgUpload.enabled = false
                        fileDialog.visible = true
//                        videoanalyze.clearprocess()
                    }

                    Glow {
                            anchors.fill: imgtext
                            id: imgglow
                            radius: 8
                            samples: 17
                            color: "#b3e5fc"
                            source: imgtext
                            visible: false
                        }

                    onHoveredChanged: hovered ? imgglow.visible=true : imgglow.visible=false

                }

                Frame {
                    id: imgframe
                    implicitHeight: originalvideo.height - 10
                    implicitWidth: implicitHeight
                    x: root.width - 10 - mugshotframe.width
                    anchors.top: userclr.bottom
                    anchors.right: userclr.right
                    anchors.topMargin: 30
                    Image {
                        id: upimg
                        anchors.fill: parent
                        source: ""
                    }
                }


                Label {
                    id: imgdef
                    anchors.fill: imgframe
                    color: "#b3e5fc"
                    text: qsTr("No preview Available")
                    font.family: customFont.name
                    font.pointSize: 16
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                FileDialog {
                    id: fileDialog
                    title: "Please choose a file"
                    folder: shortcuts.home
                    nameFilters: ["Image Files (*.jpg *.png)", "All Files (*)"]
                    onAccepted: {
                        console.log("You chose: " + fileDialog.fileUrls)
                        rclearCache.enabled = true
                        rstart.enabled = true
                        imgUpload.enabled = true
                        upimg.source = fileDialog.fileUrl
                        imgdef.visible = false
                    }
                    onRejected: {
                        console.log("Canceled")
                        rclearCache.enabled = true
                        rstart.enabled = true
                        imgUpload.enabled = true
                    }
                    Component.onCompleted: visible = false
                }

                ProgressBar {
                    id: rprogressBar
                    value: 0.0
                    padding: 2
                    implicitWidth: rstart.width
                    anchors.right: rstart.right
                    anchors.top: rstart.bottom
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
                            width: rprogressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 2
                            color: "#01579b"
                        }
                    }
                }

                Button {
                    id: next2
                    implicitWidth: start.width
                    implicitHeight: start.height * 2
                    anchors.right: imgframe.right
                    anchors.bottom: roriginalvideo.bottom
                    anchors.bottomMargin: 50
                    contentItem: Text {
                        text: qsTr(">")
                        fontSizeMode: Text.Fit
                        id: nexttext2
                        font.family: customFont.name
                        color: "#01579b"
                        font.pointSize: 48
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
                        view.currentIndex = 2
                    }

                    Glow {
                            anchors.fill: nexttext2
                            id: nextglow2
                            radius: 8
                            samples: 17
                            color: "#b3e5fc"
                            source: nexttext2
                            visible: false
                        }

                    onHoveredChanged: hovered ? nextglow2.visible=true : nextglow2.visible=false

                }

                Button {
                    id: prev2
                    implicitWidth: start.width
                    implicitHeight: start.height * 2
                    padding: 0
                    anchors.right: next2.right
                    anchors.bottom: next2.top
                    contentItem: Text {
                        text: qsTr("<")
                        fontSizeMode: Text.Fit
                        id: prevtext2
                        font.family: customFont.name
                        color: "#01579b"
                        font.pointSize: 48
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
                        view.currentIndex = 0
                    }

                    Glow {
                            anchors.fill: prevtext2
                            id: prevglow2
                            radius: 8
                            samples: 17
                            color: "#b3e5fc"
                            source: prevtext2
                            visible: false
                        }

                    onHoveredChanged: hovered ? prevglow2.visible=true : prevglow2.visible=false

                }

                Text {
                    id: pagetext2
                    width: userid.width
                    height: userid.height
                    x: root.width - 10 - userid.width
                    text: qsTr("Registration")
                    font.family: customFont.name
                    font.pointSize: 24
                    color: "#b3e5fc"
                    y: root.height - 10 - userid.height

                }

            Connections {
                target: videoanalyze

                onProcessStatus: {
                    rprogressBar.value=val/100
                }

                onProcessCompleted: {
                    rprogressBar.visible=false
                    rstart.enabled = true
                    rclearCache.enabled = true
                    rdetectvideo.source="cache/detect.avi"
                    roriginalvideo.source="cache/original.avi"
                    rskelvideo.source="cache/skel.avi"
                    rskelvideo.z = 1
                    rdetectvideo.z = 1
                    roriginalvideo.z = 1
                }

                onCacheCompleted: {
                    rclearCache.enabled = true
                    rstart.enabled = true
                    rcacheText.visible = true
                    rcacheTimer.start()
                }
            }
        }

        Item {
            id: aboutPage

            Button {
                id: prev3
                implicitWidth: start.width
                implicitHeight: start.height * 2
                x: root.width - start.width - 10
                y: root.height - start.height * 2 - 50
                contentItem: Text {
                    text: qsTr("<")
                    fontSizeMode: Text.Fit
                    id: prevtext3
                    font.family: customFont.name
                    color: "#01579b"
                    font.pointSize: 48
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
                    view.currentIndex = 1
                }

                Glow {
                        anchors.fill: prevtext3
                        id: prevglow3
                        radius: 8
                        samples: 17
                        color: "#b3e5fc"
                        source: prevtext3
                        visible: false
                    }

                onHoveredChanged: hovered ? prevglow3.visible=true : prevglow3.visible=false
            }

            Text {
                id: pagetext3
                width: userid.width
                height: userid.height
                x: root.width - 10 - userid.width
                text: qsTr("About")
                font.family: customFont.name
                font.pointSize: 24
                color: "#b3e5fc"
                y: root.height - 10 - userid.height

            }

        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

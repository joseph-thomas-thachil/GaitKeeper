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
    minimumWidth: 1680
    minimumHeight: 900
    title: qsTr("GaitKeeper")

    property var bgcolor: "#2e2f31"
    property var fgcolor: "#414244"

    color: bgcolor

    FontLoader {
        id: customFont
        source: "sources/Montserrat-Regular.ttf"
    }

    FontLoader {
        id: iconFont
        source: "sources/Font Awesome 5 Free-Regular-400.otf"
    }

    Component.onCompleted : {
        videoanalyze.getRelease()
        videoanalyze.getGuide()
        videoanalyze.getAbout()
    }


    Rectangle {
        id:mainHeader
        anchors.top: root.top
        implicitHeight: root.height / 10
        implicitWidth:  root.width
        color: fgcolor
        border.color: bgcolor
        border.width: 2
        Label {
            id: mainHeaderText
            anchors.top: parent.top
            anchors.bottomMargin: root.height / 50
            text: qsTr("GaitKeeper")
            color: "silver"
            font.pointSize: 42
            fontSizeMode: Text.Fit
            font.family: customFont.name
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideLeft
        }
        Label {
            id: mainHeaderTag
            anchors.top: mainHeaderText.bottom
            anchors.bottom: parent.bottom
            text: qsTr("\"The guardian angel for your company\"")
            font.pointSize: 16
            color: "gray"
            fontSizeMode: Text.Fit
            font.family: customFont.name
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideLeft
        }
    }

    Button {
        id: quit
        implicitWidth: root.width / 14
        implicitHeight: root.height / 28
        z: 1
        visible: (view.currentIndex != 0) ? false : true
        anchors.right: mainHeader.right
        anchors.bottom: mainHeader.bottom
        anchors.bottomMargin: mainHeader.height / 2 - quit.height / 2
        anchors.rightMargin: 10
        contentItem: Text {
            text: qsTr("\uf011 Quit")
            fontSizeMode: Text.Fit
            id: quittext
            font.family: iconFont.name, customFont.name
            color: "white"
            font.pointSize: 24
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            id: quitRect
            implicitWidth: 223
            implicitHeight: 48
            color: "darkred"
            radius: 2
        }

        onClicked: {
            Qt.quit()
        }

        onHoveredChanged: hovered ? quitRect.color="crimson" : quitRect.color="darkred"
    }

    Button {
        id: home
        implicitWidth: root.width / 14
        implicitHeight: root.height / 28
        z: 1
        visible: (view.currentIndex != 0) ? true : false
        anchors.right: mainHeader.right
        anchors.bottom: mainHeader.bottom
        anchors.bottomMargin: mainHeader.height / 2 - quit.height / 2
        anchors.rightMargin: 10
        contentItem: Text {
            text: qsTr("\uf015 Home")
            fontSizeMode: Text.Fit
            id: hometext
            font.family: iconFont.name, customFont.name
            color: "white"
            font.pointSize: 24
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            id: homeRect
            implicitWidth: 223
            implicitHeight: 48
            color: "green"
            radius: 2
        }

        onClicked: {
            view.currentIndex = 0
        }

        onHoveredChanged: hovered ? homeRect.color="forestgreen" : homeRect.color="green"

    }

    Pane {
        id: work
        anchors.top: mainHeader.bottom
        anchors.left: root.left
        implicitHeight: root.height - mainHeader.height
        implicitWidth:  root.width
        contentItem: Rectangle {
            anchors.fill: parent
            color: fgcolor
            border.width: 2
            border.color: bgcolor
        }

    SwipeView {
        id: view
        currentIndex: 0
        interactive: false
        anchors.fill: parent

        Item {
            id: mainPage

            Pane {
                id: welcome
                anchors.top: parent.top
                anchors.left: parent.left
                implicitHeight: parent.height - 20
                implicitWidth: 2 * parent.width / 3 - 24
                anchors.margins: 8
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 20
                    implicitHeight: parent.height / 2 - 20
                    implicitWidth: parent.width - 40
                    color: bgcolor
                    Label {
                        anchors.fill: parent
                        fontSizeMode: Text.Fit
                        textFormat: Text.RichText
                        text: "<span style='font-size:32px'>Welcome,</span><br><br>Choose what you want to do.<br>New to GaitKeeper? Check out our comprehensive <font color='skyblue'>User Guide</font> to to get started."
                        color: "gray"
                        font.pointSize: 16
                        wrapMode: Text.WordWrap
                        font.family: customFont.name
                    }
                }

                Button {
                    id: regButton
                    implicitWidth: root.width / 5
                    implicitHeight: root.height / 20
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: welcome.height / 2 - regButton.height / 2
                    anchors.rightMargin: welcome.width / 2 - regButton.width / 2
                    contentItem: Text {
                        text: qsTr("\uf1c0 Registration")
                        fontSizeMode: Text.Fit
                        id: regButtontext
                        font.family: iconFont.name, customFont.name
                        color: "white"
                        font.pointSize: 24
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: regButtonRect
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "green"
                        radius: 2
                    }

                    ToolTip {
                        id: regTip
                        text : qsTr("Register the gait features of a new Person")
                        delay: 1000
                        timeout: 3000
                        visible: regButton.hovered
                        contentItem: Text {
                            text: regTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
                    }

                    onClicked: {
                        view.currentIndex = 1
                    }

                    onHoveredChanged: hovered ? regButtonRect.color="forestgreen" : regButtonRect.color="green"

                }

                Button {
                    id: verButton
                    implicitWidth: root.width / 5
                    implicitHeight: root.height / 20
                    anchors.right: regButton.right
                    anchors.top: regButton.bottom
                    anchors.topMargin: 10
                    contentItem: Text {
                        text: qsTr("\uf007 Verification")
                        fontSizeMode: Text.Fit
                        id: verButtontext
                        font.family: iconFont.name, customFont.name
                        color: "white"
                        font.pointSize: 24
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: verButtonRect
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "green"
                        radius: 2
                    }

                    ToolTip {
                        id: verTip
                        text : qsTr("Check Whether the person is authorized or not (from video).")
                        delay: 1000
                        timeout: 3000
                        visible: verButton.hovered
                        contentItem: Text {
                            text: verTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
                    }

                    onClicked: {
                        view.currentIndex = 2
                    }

                    onHoveredChanged: hovered ? verButtonRect.color="forestgreen" : verButtonRect.color="green"

                }

                Button {
                    id: useButton
                    implicitWidth: root.width / 5
                    implicitHeight: root.height / 20
                    anchors.right: verButton.right
                    anchors.top: verButton.bottom
                    anchors.topMargin: 10
                    contentItem: Text {
                        text: qsTr("\uf02d User Guide")
                        fontSizeMode: Text.Fit
                        id: useButtontext
                        font.family: iconFont.name, customFont.name
                        color: "white"
                        font.pointSize: 24
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: useButtonRect
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "green"
                        radius: 2
                    }

                    ToolTip {
                        id: useTip
                        text : qsTr("A comprehensive User Guide to get started.")
                        delay: 1000
                        timeout: 3000
                        visible: useButton.hovered
                        contentItem: Text {
                            text: useTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
                    }

                    onClicked: {
                        view.currentIndex = 3
                    }

                    onHoveredChanged: hovered ? useButtonRect.color="forestgreen" : useButtonRect.color="green"

                }

                Button {
                    id: aboutButton
                    implicitWidth: root.width / 5
                    implicitHeight: root.height / 20
                    anchors.right: useButton.right
                    anchors.top: useButton.bottom
                    anchors.topMargin: 10
                    contentItem: Text {
                        text: qsTr("\uf05a About")
                        fontSizeMode: Text.Fit
                        id: aboutButtontext
                        font.family: iconFont.name, customFont.name
                        color: "white"
                        font.pointSize: 24
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: aboutButtonRect
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "green"
                        radius: 2
                    }

                    ToolTip {
                        id: aboutTip
                        text : qsTr("A small desciption about the software and team behind it.")
                        delay: 1000
                        timeout: 3000
                        visible: aboutButton.hovered
                        contentItem: Text {
                            text: aboutTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
                    }

                    onClicked: {
                        view.currentIndex = 4
                        videoanalyze.getAbout()
                    }

                    onHoveredChanged: hovered ? aboutButtonRect.color="forestgreen" : aboutButtonRect.color="green"

                }

            }

            Pane {
                id: notes
                anchors.top: parent.top
                anchors.left: welcome.right
                implicitHeight: parent.height - 20
                implicitWidth: parent.width / 3
                anchors.margins: 8
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "#2e2f31"
                }

                Label {
                    id: relLabel
                    anchors.fill: parent
                    anchors.margins: 20
                    textFormat: Text.RichText
                    color: "gray"
                    font.pointSize: 16
                    font.family: customFont.name
                    wrapMode: Text.WordWrap
                }
            }

            Connections {
                target: videoanalyze

                onReleaseSignal: {
                    relLabel.text = releaseText
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
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Video {
                id: rdetectvideo
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
                    text: qsTr("REGISTER")
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

                ToolTip {
                    id: rstartTip
                    text : qsTr("Add the person to the database and save his/her gait features.")
                    delay: 1000
                    timeout: 3000
                    visible: rstart.hovered
                    contentItem: Text {
                        text: rstartTip.text
                        font.family: customFont.name
                        color: "silver"
                    }
                    background: Rectangle {
                        color: "black"
                        opacity: 0.7
                        radius: 5
                    }
                }

                onClicked: {
                    if ((userid.length > 0 ) && (username.length > 0) && (userpos.length > 0) && (userclr.length > 0) && (upimg.source != "")) {


                        videoanalyze.processDatabase(userid.text, username.text, userpos.text, userclr.text, fileDialog.fileUrl)
                        console.log(userid.text)
                    }
                    else {
                        rcacheText.text = "Fill ALL fields and then press START"
                        rcacheText.visible = true
                        rcacheTimer.start()
                    }
                    unauth.visible = false
                    mugshot.source = ""
                    mugshotdef.visible = true
                    detailsdef.text = "No Preview Available"
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

                    ToolTip {
                        id: rcacheTip
                        text : qsTr("Clear the 'cache' directory.")
                        delay: 1000
                        timeout: 3000
                        visible: rclearCache.hovered
                        contentItem: Text {
                            text: rcacheTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
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
                    color: "#ff1a00"
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
                    onTriggered: (rcacheText.visible=false) && (rcacheText.text = "CACHE CLEARED!")
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
                      id: uidFrame
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
                      id: unameFrame
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
                      id: uposFrame
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
                      id: uclrFrame
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

                    ToolTip {
                        id: upTip
                        text : qsTr("Add image of the person to be registered (PNG format).")
                        delay: 1000
                        timeout: 3000
                        visible: imgUpload.hovered
                        contentItem: Text {
                            text: upTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
                    }

                    onClicked: {
                        rclearCache.enabled = false
                        rstart.enabled = false
                        imgUpload.enabled = false
                        fileDialog.visible = true
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
                    nameFilters: ["Image Files (*.png)"]
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

                onDbError: {
                    if(errstat == 0) {
                        rprogressBar.visible = true
                        rdetectvideo.source = ""
                        roriginalvideo.source = ""
                        rskelvideo.source = ""
                        rprogressBar.value = 0.0
                        rstart.enabled = false
                        rclearCache.enabled = false
                        videoanalyze.process(true, userid.text)
                    }
                    else {
                        rcacheText.text = "UserID is already taken!"
                        rcacheText.visible = true
                        rcacheTimer.start()
                        userid.text = ""
                        username.text = ""
                        userpos.text = ""
                        userclr.text = ""
                        upimg.source = ""
                        imgdef.visible = true
                    }
                }

                onIdError: {
                    uidFrame.border.color = "#ff1a00"
                    usertext.color = "#ff1a00"
                    rcacheText.text = "ID should contain only digits"
                    rcacheText.visible = true
                    rcacheTimer.start()
                }

                onNameError: {
                    unameFrame.border.color = "#ff1a00"
                    nametext.color = "#ff1a00"
                    rcacheText.text = "Name should contain only alphabets"
                    rcacheText.visible = true
                    rcacheTimer.start()
                }

                onPosError: {
                    uposFrame.border.color = "#ff1a00"
                    placetext.color = "#ff1a00"
                    rcacheText.text = "Position should contain only alphabets"
                    rcacheText.visible = true
                    rcacheTimer.start()
                }

                onClrError: {
                    uclrFrame.border.color = "#ff1a00"
                    cleartext.color = "#ff1a00"
                    rcacheText.text = "Clearance should contain only digits"
                    rcacheText.visible = true
                    rcacheTimer.start()
                }

                onDbSuccess: {
                    uidFrame.border.color = "#01579b"
                    usertext.color = "#01579b"
                    unameFrame.border.color = "#01579b"
                    nametext.color = "#01579b"
                    uposFrame.border.color = "#01579b"
                    placetext.color = "#01579b"
                    uclrFrame.border.color = "#01579b"
                    cleartext.color = "#01579b"
                }
            }
        }

        Item {
            id: verifyPage
            Rectangle {
                id: skelblock
                color: "gray"
                implicitWidth: root.width / 90
                implicitHeight: root.height / 7
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 10

                Label {
                    id: skeltext
                    color: "black"
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
                color: "gray"
                implicitWidth: 5
                implicitHeight: skelvideo.height - skelblock.y - skelblock.height + 20
                anchors.right: skelblock.right
                anchors.top: skelblock.bottom
            }

            Rectangle {
                id: skeltop
                color: "gray"
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
                color: "black"
                text: qsTr("No preview Available")
                font.family: customFont.name
                font.pointSize: 16
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: detectblock
                color: "gray"
                implicitWidth: root.width / 90
                implicitHeight: root.height / 7
                anchors.left: parent.left
                anchors.top: skelvideo.bottom
                anchors.margins: 10

                Label {
                    id: detecttext
                    color: "black"
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
                color: "black"
                text: qsTr("No preview Available")
                font.family: customFont.name
                font.pointSize: 16
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: detectside
                color: "gray"
                implicitWidth: 5
                implicitHeight: detectvideo.height - detectblock.height + 10
                anchors.right: detectblock.right
                anchors.top: detectblock.bottom
            }

            Rectangle {
                id: detecttop
                color: "gray"
                implicitWidth: root.width / 2 + 5
                implicitHeight: 5
                anchors.top: detectblock.top
                anchors.left: detectblock.right
            }

            Rectangle {
                id: originalblock
                color: "gray"
                implicitWidth: root.width / 90
                implicitHeight: (root.height - detectvideo.y - detectvideo.height - 20)/2
                anchors.left: parent.left
                anchors.top: detectvideo.bottom
                anchors.margins: 10

                Label {
                    id: originaltext
                    color: "black"
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
                color: "black"
                text: qsTr("No preview Available")
                font.family: customFont.name
                font.pointSize: 16
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle {
                id: originalside
                color: "gray"
                implicitWidth: 5
                implicitHeight: originalvideo.height - originalblock.height + 10
                anchors.right: originalblock.right
                anchors.top: originalblock.bottom
            }

            Rectangle {
                id: originaltop
                color: "gray"
                implicitWidth: originalvideo.width + 5
                implicitHeight: 5
                anchors.top: originalblock.top
                anchors.left: originalblock.right
            }

            Button {
                id: start
                implicitWidth: root.width / 10
                implicitHeight: root.height / 20
                anchors.right: detailsblock.left
                anchors.top: originalvideo.top
                anchors.rightMargin: 30
                contentItem: Text {
                    text: qsTr("Verify")
                    fontSizeMode: Text.Fit
                    id: starttext
                    font.family: customFont.name
                    color: "white"
                    font.pointSize: 16
                    opacity: enabled ? 1.0 : 0.3
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    id: startRect
                    implicitWidth: 223
                    implicitHeight: 48
                    color: "#3476d4"
                    radius: 2
                }

                ToolTip {
                    id: startTip
                    text : qsTr("Compare Gait features of the person with database.")
                    delay: 1000
                    timeout: 3000
                    visible: start.hovered
                    contentItem: Text {
                        text: startTip.text
                        font.family: customFont.name
                        color: "silver"
                    }
                    background: Rectangle {
                        color: "black"
                        opacity: 0.7
                        radius: 5
                    }
                }

                onClicked: {
                    progressBar.visible = true
                    detectvideo.source = ""
                    originalvideo.source = ""
                    skelvideo.source = ""
                    progressBar.value = 0.0
                    start.enabled = false
                    clearCache.enabled = false
                    videoanalyze.process(false, 0)
                }

                Glow {
                        anchors.fill: starttext
                        id: startglow
                        radius: 8
                        samples: 17
                        color: "black"
                        source: starttext
                        visible: false
                    }

                onHoveredChanged: hovered ? startRect.color="#4286f4" : startRect.color="#3476d4"
            }

                Button {
                    id: clearCache
                    implicitWidth: start.width
                    implicitHeight: start.height
                    anchors.right: start.right
                    anchors.top: progressBar.bottom
                    anchors.topMargin: 40
                    contentItem: Text {
                        text: qsTr("Clear Cache")
                        fontSizeMode: Text.Fit
                        id: cachetext
                        font.family: customFont.name
                        color: "white"
                        font.pointSize: 16
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: cacheRect
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "#3476d4"
                        radius: 2
                    }

                    ToolTip {
                        id: cacheTip
                        text : qsTr("Clear the 'cache' directory.")
                        delay: 1000
                        timeout: 3000
                        visible: clearCache.hovered
                        contentItem: Text {
                            text: cacheTip.text
                            font.family: customFont.name
                            color: "silver"
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.7
                            radius: 5
                        }
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
                            color: "black"
                            source: cachetext
                            visible: false
                        }

                    onHoveredChanged: hovered ? cacheRect.color="#4286f4" : cacheRect.color="#3476d4"

                }

                Label {
                    id: cacheText
                    visible: false
                    width: clearCache.width / 2
                    height: clearCache.height / 4
                    color: "#ff1a00"
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
                color: "gray"
                anchors.right: mugshotframe.left
                anchors.top: skelblock.top
                anchors.leftMargin: 50

                Label {
                    id: mugshottext
                    color: "black"
                    text: qsTr("P\nH\nO\nT\nO")
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
                    color: "black"
                    text: qsTr("No preview Available")
                    font.family: customFont.name
                    font.pointSize: 16
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: mugshotside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: mugshotframe.height - mugshotblock.height + 10
                    anchors.right: mugshotblock.right
                    anchors.top: mugshotblock.bottom
                }

                Rectangle {
                    id: mugshottop
                    color: "gray"
                    implicitWidth: mugshotframe.width + 5
                    implicitHeight: 5
                    anchors.top: mugshotblock.top
                    anchors.left: mugshotblock.right
                }

                Label {
                    id: unauth
                    width: root.width / 4
                    height: mugshotblock.height
                    visible: false
                    anchors.right: mugshotblock.left
                    anchors.top: mugshotblock.top
                    anchors.rightMargin: 10
                    color: "#ff1a00"
                    text: qsTr("UNAUTHORIZED!")
                    font.family: customFont.name
                    font.pixelSize: 32
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

            Rectangle {
                id: detailsblock
                implicitWidth: root.width / 90
                implicitHeight: (originalblock.y - mugshotblock.y - 10) / 4
                color: "gray"
                anchors.right: detailsframe.left
                anchors.top: mugshotframe.bottom
                anchors.topMargin: 10

                Label {
                    id: detailstext
                    color: "black"
                    text: qsTr("D\nE\nT\nA\nI\nL\nS")
                    font.family: customFont.name
                    fontSizeMode: Text.VerticalFit
                    anchors.fill: parent
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
                    color: "black"
                    text: qsTr("No preview Available")
                    font.family: customFont.name
                    font.pointSize: 16
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: detailsside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: detailsframe.height - detailsblock.height + 10
                    anchors.right: detailsblock.right
                    anchors.top: detailsblock.bottom
                }

                Rectangle {
                    id: detailstop
                    color: "gray"
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
                        color: "gray"
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
                    unauth.visible = false
                    mugshot.source = ""
                    mugshotdef.visible = true
                    detailsdef.text = "No Preview Available"
                    cacheTimer.start()
                }

                onVerifyCompleted: {
                    unauth.visible = false
                    mugshot.source="cache/image.png"
                    mugshotdef.visible = false
                    detailsdef.text= "UserID: \t" + id + "\n\nName: \t" + name + "\n\nPosition: \t" + pos + "\n\nClearance Level: \t" + clr
                    detailsdef.font.pointSize= 24
                    unauth.visible = true
                    unauth.text = qsTr("AUTHORIZED")
                    unauth.color = "#00ff00"
                }

                onUnauthCheck: {
                    unauth.visible = true
                    mugshot.source = ""
                    mugshotdef.visible = true
                    detailsdef.text = "No Preview Available"
                    unauth.text = qsTr("UNAUTHORIZED")
                    unauth.color = "#ff1a00"
                }
            }
        }


        Item {
            id: guidePage

            Pane {
                id: guidePane
                anchors.fill: parent
                anchors.margins: 20
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Label {
                    id: guide
                    anchors.fill: parent
                    font.family: customFont.name
                    font.pointSize: 16
                    fontSizeMode: Text.Fit
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    color: "gray"
                }
            }

            Connections {
                target: videoanalyze

                onGuideSignal: {
                    guide.text = qsTr(guideText)
                }
            }
        }

        Item {
            id: aboutPage

            Pane {
                id: aboutPane
                anchors.fill: parent
                anchors.margins: 20
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Label {
                    id: content
                    anchors.fill: parent
                    font.family: customFont.name
                    font.pointSize: 24
                    fontSizeMode: Text.Fit
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    color: "gray"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Connections {
                    target: videoanalyze

                    onAboutSignal: {
                        content.text = qsTr(aboutText)
                    }
                }
            }
        }
      }
    }
}

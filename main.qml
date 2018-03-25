import QtQuick 2.7
import QtQuick.Controls 2.3
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
                implicitWidth: 2 * parent.width / 3 - 30
                anchors.margins: 10
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
                anchors.margins: 10
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

            Pane {
                id: regworkPane
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 10
                implicitHeight: parent.height - 20
                implicitWidth: parent.width / 3
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Text {
                    id: infoData
                    width: userid.width
                    height: userid.height
//                        x: root.width - 10 - infoData.width
                    text: qsTr("Profile")
                    font.family: customFont.name
                    font.pointSize: 22
                    color: "silver"
                    anchors.top: parent.top
                    anchors.topMargin: 20
                }

                Text {
                    id: usertext
                    anchors.right: userid.left
                    anchors.top: userid.top
                    anchors.margins: 10
                    text: qsTr("UserID")
                    font.family: customFont.name
                    font.pointSize: 14
                    color: "silver"
                }

                TextField {
                  id: userid
                  anchors.top: infoData.bottom
                  anchors.right: parent.right
                  implicitWidth: root.width / 5
//                      x: root.width - 10 - userid.width
                  anchors.rightMargin: 10
                  anchors.topMargin: 50
                  color: "silver"
                  background: Rectangle {
                      id: uidFrame
                      implicitWidth: 223
                      implicitHeight: 48
                      color: fgcolor
                      border.width: 1
                      border.color: fgcolor
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
                    color: "silver"
                }
                TextField {
                  id: username
                  anchors.top: userid.bottom
                  implicitWidth: root.width / 5
                  anchors.left: userid.left
                  anchors.topMargin: 20
                  color: "silver"
                  background: Rectangle {
                      id: unameFrame
                      implicitWidth: 223
                      implicitHeight: 48
                      color: fgcolor
                      border.width: 1
                      border.color: fgcolor
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
                    color: "silver"
                }
                TextField {
                  id: userpos
                  anchors.top: username.bottom
                  implicitWidth: root.width / 5
                  anchors.left: username.left
                  anchors.topMargin: 20
                  color: "silver"
                  background: Rectangle {
                      id: uposFrame
                      implicitWidth: 223
                      implicitHeight: 48
                      color: fgcolor
                      border.width: 1
                      border.color: fgcolor
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
                    color: "silver"
                }
                TextField {
                  id: userclr
                  anchors.top: userpos.bottom
                  implicitWidth: root.width / 5
                  anchors.left: userpos.left
                  anchors.topMargin: 20
                  color: "silver"
                  background: Rectangle {
                      id: uclrFrame
                      implicitWidth: 223
                      implicitHeight: 48
                      color: fgcolor
                      border.width: 1
                      border.color: fgcolor
                  }
               }
                Button {
                    id: imgUpload
                    implicitWidth: root.width / 10
                    implicitHeight: usertext.height * 2
                    anchors.right: imgframe.left
                    anchors.top: cleartext.bottom
                    anchors.topMargin: 90
                    anchors.rightMargin: 10
                    contentItem: Text {
                        text: qsTr("Add Photo")
                        fontSizeMode: Text.Fit
                        id: imgtext
                        font.family: customFont.name
                        color: "white"
                        font.pointSize: 16
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: imgbg
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "#3476d4"
                        radius: 2
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

                    onHoveredChanged: hovered ? imgbg.color="#4286f4" : imgbg.color="#3476d4"

                }

                Frame {
                    id: imgframe
                    implicitHeight: parent.width / 2 - 30
                    implicitWidth: implicitHeight
                    x: root.width - 10 - mugshotframe.width
                    anchors.top: userclr.bottom
                    anchors.right: userclr.right
                    anchors.topMargin: 30
                    Image {
                        id: upimg
                        anchors.fill: parent
                        source: "sources/default.png"
                    }
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


            }

            Pane {
                id: regvidPane
                visible: false
                anchors.top: parent.top
                anchors.left: regworkPane.right
                anchors.margins: 10
                implicitHeight: parent.height - 20
                implicitWidth: 2 * parent.width / 3 - 30
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Rectangle {
                    id: rskelblock
                    color: "gray"
                    implicitWidth: root.width / 90
                    implicitHeight: root.height / 7
                    anchors.left: parent.left
                    anchors.top: roriginalside.bottom
                    anchors.margins: 10

                    Label {
                        id: rskeltext
                        color: "silver"
                        text: qsTr("G\nA\nI\nT")
                        font.family: customFont.name
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 10
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Rectangle {
                    id: rskelside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: rskelvideo.height - rskelblock.height + 20
                    anchors.right: rskelblock.right
                    anchors.top: rskelblock.bottom
                }

                Rectangle {
                    id: rskeltop
                    color: "gray"
                    implicitWidth: parent.width / 2 - 35
                    implicitHeight: 5
                    anchors.top: rskelblock.top
                    anchors.left: rskelblock.right
                }

                Video {
                    id:rskelvideo
                    implicitWidth: parent.width / 2 - 40
                    implicitHeight: parent.height / 2 - 20
                    anchors.left: rskelblock.right
                    anchors.top: rskelblock.top
                    anchors.margins: 5
                    anchors.leftMargin: 0
                    fillMode: 0
                    autoPlay: true
                    source: ""
                }

                Rectangle {
                    id: rdetectblock
                    color: "gray"
                    implicitWidth: root.width / 90
                    implicitHeight: root.height / 7
                    anchors.left: rskelvideo.right
                    anchors.top: rskeltop.top
                    anchors.leftMargin: 10

                    Label {
                        id: rdetecttext
                        color: "silver"
                        text: qsTr("D\nE\nT\nE\nC\nT")
                        font.family: customFont.name
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 10
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Video {
                    id: rdetectvideo
                    implicitWidth: parent.width / 2 - 40
                    implicitHeight: parent.height / 2 - 20
                    anchors.left: rdetectblock.right
                    anchors.top: rdetectblock.top
                    anchors.margins: 5
                    anchors.leftMargin: 0
                    fillMode: 0
                    autoPlay: true
                    source: ""
                }

                Rectangle {
                    id: rdetectside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: rdetectvideo.height - rdetectblock.height + 20
                    anchors.right: rdetectblock.right
                    anchors.top: rdetectblock.bottom
                }

                Rectangle {
                    id: rdetecttop
                    color: "gray"
                    implicitWidth: parent.width / 2 - 35
                    implicitHeight: 5
                    anchors.top: rdetectblock.top
                    anchors.left: rdetectblock.right
                }

                Rectangle {
                    id: roriginalblock
                    color: "gray"
                    implicitWidth: root.width / 90
                    implicitHeight: roriginalvideo.height / 2
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.rightMargin: roriginalvideo.width + 20

                    Label {
                        id: roriginaltext
                        color: "silver"
                        text: qsTr("O\nR\nI\nG\nI\nN\nA\nL")
                        font.family: customFont.name
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 10
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Video {
                    id:roriginalvideo
                    implicitWidth: parent.width / 2 - 35
                    implicitHeight: parent.height / 2 - 40
                    anchors.left: roriginalblock.right
                    anchors.top: roriginalblock.top
                    anchors.margins: 5
                    anchors.leftMargin: 0
                    fillMode: 0
                    autoPlay: true
                    source: ""
                    onStopped: {
                        regvidPaneAlt.visible = true
                        regvidPane.visible = false
                        rstart.enabled = true
                        rclearCache.enabled = true
                        imgUpload.enabled = true
                    }
                }

                Rectangle {
                    id: roriginalside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: roriginalvideo.height - roriginalblock.height + 10
                    anchors.right: roriginalblock.right
                    anchors.top: roriginalblock.bottom
                }

                Rectangle {
                    id: roriginaltop
                    color: "gray"
                    implicitWidth: roriginalvideo.width + 5
                    implicitHeight: 5
                    anchors.top: roriginalblock.top
                    anchors.left: roriginalblock.right
                }

                Label {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 20
                    anchors.rightMargin: parent.width / 2 + 40
                    font.family: customFont.name
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    font.pointSize: 16
                    text: qsTr("<span style='font-size:32px'>Registration Page</span><br><br><ul><li>Fill the 'Profile' and press 'Register' button.</li>\
<li>Select the video to be processed and stored in the database.</li><li>UserID: [0-9]</li><li>Name: [A-Za-z]</li><li>Position: [A-Za-z]</li><li>Clearance Level: [0-9</ul>")
                    color: "gray"
                }
            }

            Pane {
                id: regvidPaneAlt
                anchors.top: parent.top
                anchors.left: regworkPane.right
                anchors.margins: 10
                implicitHeight: parent.height - 20
                implicitWidth: 2 * parent.width / 3 - 30
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Label {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 20
                    anchors.rightMargin: parent.width / 2 + 40
                    font.family: customFont.name
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    font.pointSize: 16
                    text: qsTr("<span style='font-size:32px'>Registration Page</span><br><br><ul><li>Fill the 'Profile' and press 'Register' button.</li>\
<li>Select the video to be processed and stored in the database.</li><li>UserID: [0-9]</li><li>Name: [A-Za-z]</li><li>Position: [A-Za-z]</li><li>Clearance Level: [0-9</ul>")
                    color: "gray"
                }

                Button {
                    id: rstart
                    implicitWidth: root.width / 7
                    implicitHeight: root.height / 20
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: regvidPaneAlt.width / 2 - root.width / 14
                    anchors.topMargin: regvidPaneAlt.height / 2 - root.height / 40
                    contentItem: Text {
                        text: qsTr("Register")
                        fontSizeMode: Text.Fit
                        id: rstarttext
                        font.family: customFont.name
                        color: "white"
                        font.pointSize: 16
                        opacity: enabled ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        id: rstartRect
                        implicitWidth: 223
                        implicitHeight: 48
                        color: "#3476d4"
                        radius: 2
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

                            vidDialog.visible = true
                            imgUpload.enabled = false
                        }
                        else {
                            rcacheText.text = "Fill ALL fields and then press Register"
                            rcacheText.visible = true
                            rcacheTimer.start()
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

                    onHoveredChanged: hovered ? rstartRect.color="#4286f4" : rstartRect.color="#3476d4"
                }



                    Button {
                        id: rclearCache
                        implicitWidth: rstart.width
                        implicitHeight: rstart.height
                        anchors.right: rstart.right
                        anchors.top: rprogressBar.bottom
                        anchors.topMargin: 40
                        contentItem: Text {
                            text: qsTr("Clear Cache")
                            fontSizeMode: Text.Fit
                            id: rcachetext
                            font.family: customFont.name
                            color: "white"
                            font.pointSize: 16
                            opacity: enabled ? 1.0 : 0.3
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                        background: Rectangle {
                            id: rcacheRect
                            implicitWidth: 223
                            implicitHeight: 48
                            color: "#3476d4"
                            radius: 2
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
                            imgUpload.enabled = false
                            upimg.source = "sources/default.png"
                            userid.text = ""
                            username.text = ""
                            userpos.text = ""
                            userclr.text = ""
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

                    onHoveredChanged: hovered ? rcacheRect.color="#4286f4" : rcacheRect.color="#3476d4"

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

            }


                Popup {
                    id: regConfirm
                    implicitHeight: root.height / 3
                    implicitWidth:  root.width / 4
                    x: 3 * root.width / 8
                    y: root.height / 3 - mainHeader.height - 10
                    modal: true
                    focus: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                    background: Rectangle {
                        anchors.fill: parent
                        color: "black"
                        opacity: 0.7
                        radius: 8
                    }

                    Label {
                        anchors.fill: parent
                        anchors.bottomMargin: parent.height / 3
                        wrapMode: Text.WordWrap
                        font.family: customFont.name
                        font.pointSize: 16
                        color: "silver"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("Register "+ username.text +  " with the Video from: "+ vidDialog.fileUrls+ " ?")
                    }

                    Button {
                        id: confirm
                        implicitHeight: parent.height / 4 - 20
                        implicitWidth: parent.width / 2 - 20
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        contentItem: Text {
                            text: qsTr("\uf00c Confirm")
                            color: "white"
                            font.family: iconFont.name, customFont.name
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            id: confirmRect
                            anchors.fill: parent
                            color: "green"
                            radius: 2
                        }

                        onClicked: {
                            regConfirm.close()
                            videoanalyze.processDatabase(userid.text, username.text, userpos.text, userclr.text, fileDialog.fileUrl)
                        }

                        onHoveredChanged: hovered ? confirmRect.color="forestgreen" : confirmRect.color="green"
                    }

                    Button {
                        id: cancel
                        implicitHeight: parent.height / 4 - 20
                        implicitWidth: parent.width / 2 - 20
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        contentItem: Text {
                            text: qsTr("\uf00d Cancel")
                            color: "white"
                            font.family: iconFont.name, customFont.name
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            id: cancelRect
                            anchors.fill: parent
                            color: "red"
                            radius: 2
                        }

                        onClicked: {
                            regConfirm.close()
                        }

                        onHoveredChanged: hovered ? cancelRect.color="crimson" : cancelRect.color="red"
                    }

                    FileDialog {
                        id: vidDialog
                        title: "Please choose a video file"
                        folder: shortcuts.home
                        nameFilters: ["Video Files (*.mp4)"]
                        onAccepted: {
                            console.log("You chose: " + vidDialog.fileUrls)
                            rclearCache.enabled = true
                            rstart.enabled = true
                            imgUpload.enabled = true
                            vidDialog.visible = false
                            regConfirm.open()
                        }
                        onRejected: {
                            console.log("Canceled")
                            rclearCache.enabled = true
                            rstart.enabled = true
                            imgUpload.enabled = true
                            vidDialog.visible = false
                        }
                        Component.onCompleted: visible = false
                    }
                }


                Connections {
                    target: videoanalyze

                    onTrainStatus: {
                        rprogressBar.value=val/100
                    }

                    onTrainCompleted: {
                        rprogressBar.visible=false
                        regvidPaneAlt.visible=false
                        regvidPane.visible=true
                        rclearCache.enabled=true
                        rstart.enabled=true
                        imgUpload.enabled=true
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
                        imgUpload.enabled = true
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
                            imgUpload.enabled = false
                            videoanalyze.process(true, userid.text, vidDialog.fileUrl)
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

            Pane {
                id: verworkPane
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 10
                implicitHeight: parent.height - 20
                implicitWidth: parent.width / 3
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Rectangle {
                    id: mugshotblock
                    implicitWidth: root.width / 90
                    implicitHeight: mugshotframe.height / 2
                    color: "gray"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    anchors.leftMargin: parent.width / 2 - mugshotframe.width / 2 - root.width / 90

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
                        implicitWidth: parent.width / 2 - 40
                        implicitHeight: implicitWidth
                        anchors.top: mugshotblock.top
                        anchors.left: mugshotblock.right
                        anchors.topMargin: 5
                        Image {
                            id: mugshot
                            anchors.fill: parent
                            source: "sources/default.png"
                        }
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
                        width: parent.width - 20
                        height: mugshotblock.height
                        visible: false
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 10
                        color: "#ff1a00"
                        text: qsTr("UNAUTHORIZED!")
                        font.family: customFont.name
                        font.pixelSize: 32
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Label {
                        id: veruserid
                        anchors.top: mugshotside.bottom
                        anchors.left: parent.left
                        anchors.topMargin: 20
                        anchors.leftMargin: 10
                        text: qsTr("UserID: ")
                        font.family: customFont.name
                        font.pointSize: 16
                        color: "silver"
                        fontSizeMode: Text.Fit
                    }

                    Rectangle {
                        id: vermatchuserid
                        anchors.top: veruserid.top
                        anchors.left: veruserid.right
                        anchors.leftMargin: 10
                        implicitHeight: veruserid.height
                        implicitWidth: parent.width - veruserid.width - 30
                        color: bgcolor
                        Label {
                            id: vermatchuseridText
                            anchors.fill: parent
                            font.family: customFont.name
                            font.pointSize: 16
                            color: "silver"
                            fontSizeMode: Text.Fit
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Label {
                        id: verusername
                        anchors.top: veruserid.bottom
                        anchors.left: veruserid.left
                        anchors.topMargin: 20
                        text: qsTr("Name: ")
                        font.family: customFont.name
                        font.pointSize: 16
                        color: "silver"
                        fontSizeMode: Text.Fit
                    }

                    Rectangle {
                        id: vermatchusername
                        anchors.top: verusername.top
                        anchors.left: verusername.right
                        anchors.leftMargin: 10
                        implicitHeight: verusername.height
                        implicitWidth: parent.width - verusername.width - 30
                        color: bgcolor
                        Label {
                            id: vermatchusernameText
                            anchors.fill: parent
                            font.family: customFont.name
                            font.pointSize: 16
                            color: "silver"
                            fontSizeMode: Text.Fit
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Label {
                        id: veruserpos
                        anchors.top: verusername.bottom
                        anchors.left: veruserid.left
                        anchors.topMargin: 20
                        text: qsTr("Position: ")
                        font.family: customFont.name
                        font.pointSize: 16
                        color: "silver"
                        fontSizeMode: Text.Fit
                    }

                    Rectangle {
                        id: vermatchuserpos
                        anchors.top: veruserpos.top
                        anchors.left: veruserpos.right
                        anchors.leftMargin: 10
                        implicitHeight: veruserpos.height
                        implicitWidth: parent.width - veruserpos.width - 30
                        color: bgcolor
                        Label {
                            id: vermatchuserposText
                            font.family: customFont.name
                            anchors.fill: parent
                            font.pointSize: 16
                            color: "silver"
                            fontSizeMode: Text.Fit
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Label {
                        id: veruserclr
                        anchors.top: veruserpos.bottom
                        anchors.left: veruserid.left
                        anchors.topMargin: 20
                        text: qsTr("Clearance Level: ")
                        font.family: customFont.name
                        font.pointSize: 16
                        color: "silver"
                        fontSizeMode: Text.Fit
                    }

                    Rectangle {
                        id: vermatchuserclr
                        anchors.top: veruserclr.top
                        anchors.left: veruserclr.right
                        anchors.leftMargin: 10
                        implicitHeight: veruserclr.height
                        implicitWidth: parent.width - veruserclr.width - 30
                        color: bgcolor
                        Label {
                            id: vermatchuserclrText
                            font.family: customFont.name
                            anchors.fill: parent
                            font.pointSize: 16
                            color: "silver"
                            fontSizeMode: Text.Fit
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                   }
            }

            Pane {
                id: vervidPane
                visible: false
                anchors.top: parent.top
                anchors.left: verworkPane.right
                anchors.margins: 10
                implicitHeight: parent.height - 20
                implicitWidth: 2 * parent.width / 3 - 30
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Rectangle {
                    id: skelblock
                    color: "gray"
                    implicitWidth: root.width / 90
                    implicitHeight: root.height / 7
                    anchors.left: parent.left
                    anchors.top: originalside.bottom
                    anchors.margins: 10

                    Label {
                        id: skeltext
                        color: "silver"
                        text: qsTr("G\nA\nI\nT")
                        font.family: customFont.name
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 10
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Rectangle {
                    id: skelside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: skelvideo.height - skelblock.height + 20
                    anchors.right: skelblock.right
                    anchors.top: skelblock.bottom
                }

                Rectangle {
                    id: skeltop
                    color: "gray"
                    implicitWidth: parent.width / 2 - 35
                    implicitHeight: 5
                    anchors.top: skelblock.top
                    anchors.left: skelblock.right
                }

                Video {
                    id:skelvideo
                    implicitWidth: parent.width / 2 - 40
                    implicitHeight: parent.height / 2 - 20
                    anchors.left: skelblock.right
                    anchors.top: skelblock.top
                    anchors.margins: 5
                    anchors.leftMargin: 0
                    fillMode: 0
                    autoPlay: true
                    source: ""
                }

                Rectangle {
                    id: detectblock
                    color: "gray"
                    implicitWidth: root.width / 90
                    implicitHeight: root.height / 7
                    anchors.left: skelvideo.right
                    anchors.top: skeltop.top
                    anchors.leftMargin: 10

                    Label {
                        id: detecttext
                        color: "silver"
                        text: qsTr("D\nE\nT\nE\nC\nT")
                        font.family: customFont.name
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 10
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Video {
                    id: detectvideo
                    implicitWidth: parent.width / 2 - 40
                    implicitHeight: parent.height / 2 - 20
                    anchors.left: detectblock.right
                    anchors.top: detectblock.top
                    anchors.margins: 5
                    anchors.leftMargin: 0
                    fillMode: 0
                    autoPlay: true
                    source: ""
                }

                Rectangle {
                    id: detectside
                    color: "gray"
                    implicitWidth: 5
                    implicitHeight: detectvideo.height - detectblock.height + 20
                    anchors.right: detectblock.right
                    anchors.top: detectblock.bottom
                }

                Rectangle {
                    id: detecttop
                    color: "gray"
                    implicitWidth: parent.width / 2 - 35
                    implicitHeight: 5
                    anchors.top: detectblock.top
                    anchors.left: detectblock.right
                }

                Rectangle {
                    id: originalblock
                    color: "gray"
                    implicitWidth: root.width / 90
                    implicitHeight: originalvideo.height / 2
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.rightMargin: originalvideo.width + 20

                    Label {
                        id: originaltext
                        color: "silver"
                        text: qsTr("O\nR\nI\nG\nI\nN\nA\nL")
                        font.family: customFont.name
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 10
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Video {
                    id:originalvideo
                    implicitWidth: parent.width / 2 - 35
                    implicitHeight: parent.height / 2 - 40
                    anchors.left: originalblock.right
                    anchors.top: originalblock.top
                    anchors.margins: 5
                    anchors.leftMargin: 0
                    fillMode: 0
                    autoPlay: true
                    source: ""
                    onStopped: {
                        vervidPaneAlt.visible = true
                        vervidPane.visible = false
                        start.enabled = true
                        clearCache.enabled = true
                    }
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

                Label {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 20
                    anchors.rightMargin: parent.width / 2 + 40
                    font.family: customFont.name
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    font.pointSize: 16
                    text: qsTr("<span style='font-size:32px'>Verification Page</span><br><br><ul><li>Click on the 'Verify' button to get started.</li>\
<li>Select the video to be processed and compared with the data in the database.</li><li>If a match is found, the details will be showed on the left pane.</li></ul>")
                    color: "gray"
                }
            }

            Pane {
                id: vervidPaneAlt
                anchors.top: parent.top
                anchors.left: verworkPane.right
                anchors.margins: 10
                implicitHeight: parent.height - 20
                implicitWidth: 2 * parent.width / 3 - 30
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: bgcolor
                }

                Label {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 20
                    anchors.rightMargin: parent.width / 2 + 40
                    font.family: customFont.name
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    font.pointSize: 16
                    text: qsTr("<span style='font-size:32px'>Verification Page</span><br><br><ul><li>Click on the 'Verify' button to get started.</li>\
<li>Select the video to be processed and compared with the data in the database.</li><li>If a match is found, the details will be showed on the left pane.</li></ul>")
                    color: "gray"
                }

                Button {
                    id: start
                    implicitWidth: root.width / 7
                    implicitHeight: root.height / 20
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: vervidPaneAlt.width / 2 - root.width / 14
                    anchors.topMargin: vervidPaneAlt.height / 2 - root.height / 40
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
                        vervidDialog.visible = true
                        start.enabled = false
                        clearCache.enabled = false
                        unauth.visible = false
                        mugshot.source = "sources/default.png"
//                        mugshotdef.visible = true
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
                                color: "#b3e5fc"
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
                        onTriggered: (cacheText.visible=false) && (cacheText.text = "CACHE CLEARED!")
                    }

                    ProgressBar {
                        id: progressBar
                        value: 0.0
                        padding: 2
                        implicitWidth: start.width
                        anchors.right: start.right
                        anchors.top: start.bottom
                        anchors.topMargin: 10
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

            }


                Popup {
                    id: verConfirm
                    implicitHeight: root.height / 3
                    implicitWidth:  root.width / 4
                    x: 3 * root.width / 8
                    y: root.height / 3 - mainHeader.height - 10
                    modal: true
                    focus: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                    background: Rectangle {
                        anchors.fill: parent
                        color: "black"
                        opacity: 0.7
                        radius: 8
                    }

                    Label {
                        anchors.fill: parent
                        anchors.bottomMargin: parent.height / 3
                        wrapMode: Text.WordWrap
                        font.family: customFont.name
                        font.pointSize: 16
                        color: "silver"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("Verify the person from Video :"+ vervidDialog.fileUrls+ " ?")
                    }

                    Button {
                        id: vconfirm
                        implicitHeight: parent.height / 4 - 20
                        implicitWidth: parent.width / 2 - 20
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        contentItem: Text {
                            text: qsTr("\uf00c Confirm")
                            color: "white"
                            font.family: iconFont.name, customFont.name
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            id: vconfirmRect
                            anchors.fill: parent
                            color: "green"
                            radius: 2
                        }

                        onClicked: {
                            verConfirm.close()
                            start.enabled=false
                            clearCache.enabled=false
                            videoanalyze.process(false, 0, vervidDialog.fileUrl)
                        }

                        onHoveredChanged: hovered ? vconfirmRect.color="forestgreen" : vconfirmRect.color="green"
                    }

                    Button {
                        id: vcancel
                        implicitHeight: parent.height / 4 - 20
                        implicitWidth: parent.width / 2 - 20
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        contentItem: Text {
                            text: qsTr("\uf00d Cancel")
                            color: "white"
                            font.family: iconFont.name, customFont.name
                            font.pointSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            id: vcancelRect
                            anchors.fill: parent
                            color: "red"
                            radius: 2
                        }

                        onClicked: {
                            verConfirm.close()
                        }

                        onHoveredChanged: hovered ? vcancelRect.color="crimson" : vcancelRect.color="red"
                    }

                    FileDialog {
                        id: vervidDialog
                        title: "Please choose a video file"
                        folder: shortcuts.home
                        nameFilters: ["Video Files (*.mp4)"]
                        onAccepted: {
                            console.log("You chose: " + vervidDialog.fileUrls)
                            clearCache.enabled = true
                            start.enabled = true
                            vervidDialog.visible = false
                            verConfirm.open()
                        }
                        onRejected: {
                            console.log("Canceled")
                            clearCache.enabled = true
                            start.enabled = true
                            vervidDialog.visible = false
                        }
                        Component.onCompleted: visible = false
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
                    vervidPane.visible = true
                    vervidPaneAlt.visible = false
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
                    mugshot.source = "sources/default.png"
                    vermatchuseridText.text = ""
                    vermatchusernameText.text = ""
                    vermatchuserposText.text = ""
                    vermatchuserclrText.text = ""
                    cacheTimer.start()
                }

                onVerifyCompleted: {
                    unauth.visible = false
                    mugshot.source="cache/image.png"
                    vermatchuseridText.text = id
                    vermatchusernameText.text = name
                    vermatchuserposText.text = pos
                    vermatchuserclrText.text = clr
                    unauth.visible = true
                    unauth.text = qsTr("AUTHORIZED")
                    unauth.color = "#00ff00"
                }

                onUnauthCheck: {
                    unauth.visible = true
                    mugshot.source = ""
                    vermatchuseridText.text = ""
                    vermatchusernameText.text = ""
                    vermatchuserposText.text = ""
                    vermatchuserclrText.text = ""
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

                Flickable {
                    id: flickable
                    anchors.fill: parent
                    TextArea.flickable: TextArea {
                        id: guide
                        font.family: customFont.name
                        font.pointSize: 16
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        color: "gray"
                        readOnly: true
                    }
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }
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

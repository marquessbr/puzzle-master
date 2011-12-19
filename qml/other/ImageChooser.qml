
// This file is part of Puzzle Master, a fun and addictive jigsaw puzzle game.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
// Copyright (C) 2010-2011, Timur Kristóf <venemo@fedoraproject.org>

import QtQuick 1.0
import "./components"

Panel {
    property string selectedImageUrl: ""
    property int columnNumber: 3

    signal accepted

    id: imageChooser
    color: "#000000"

    Rectangle {
        id: imageChooserTop
        height: 60
        color: "#7DB72F"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        radius: 15

        Rectangle {
            color: "#7DB72F"
            height: imageChooserTop.radius + 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        TextEdit {
            text: qsTr("Welcome! Select an image.")
            anchors.centerIn: parent
            font.pixelSize: 30
            color: "#ffffff"
            activeFocusOnPress: false
        }
    }
    Rectangle {
        property Rectangle selectedItemBorder: null

        id: imageChooserMiddle
        color: "#ffffff"
        anchors.top: imageChooserTop.bottom
        anchors.bottom: imageChooserBottom.top
        anchors.left: parent.left
        anchors.right: parent.right

        Flickable {
            enabled: true
            clip: true
            contentHeight: imageSelectorGrid.height
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5

            Grid {
                id: imageSelectorGrid
                spacing: 5
                columns: imageChooser.columnNumber
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: ListModel {
                        id: imagesModel
                        ListElement { imageUrl: ":/pics/image1.jpg" }
                        ListElement { imageUrl: ":/pics/image2.jpg" }
                        ListElement { imageUrl: ":/pics/image3.jpg" }
                        ListElement { imageUrl: ":/pics/image4.jpg" }
                        ListElement { imageUrl: ":/pics/image5.jpg" }
                    }
                    delegate: Rectangle {
                        id: imageBorder
                        width: imageItem.width + 10
                        height: imageItem.height + 10
                        color: imageBorder === imageChooserMiddle.selectedItemBorder ? "#538312" : "white"

                        Image {
                            function selectItem() {
                                imageChooserMiddle.selectedItemBorder = imageBorder;
                                imageChooser.selectedImageUrl = imageUrl;
                            }

                            id: imageItem
                            asynchronous: false
                            fillMode: Image.PreserveAspectCrop
                            width: imageChooser.width / imageChooser.columnNumber - 20
                            height: width / 16.0 * 9.0
                            clip: true
                            anchors.centerIn: parent
                            source: imageUrl
                            sourceSize.width: imageChooser.width / imageChooser.columnNumber - 20

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (imageBorder === imageChooserMiddle.selectedItemBorder)
                                        imageChooser.accepted();
                                    else
                                        imageItem.selectItem();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: imageChooserBottom
        height: imageChooserTop.height
        color: "#7DB72F"
        radius: 15
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            color: "#7DB72F"
            height: imageChooserBottom.radius + 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
        }
        Button {
            text: qsTr("Start game")
            height: 48
            anchors.centerIn: parent
            onClicked: {
                if (imageChooser.selectedImageUrl != "")
                    imageChooser.accepted();
                else
                    youMustChooseDialog.open();
            }
        }
        Button {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 6
            width: 70
            height: 48
            text: qsTr("...")
            onClicked: {
                menuDialog.open();
            }
        }
    }
    Dialog {
        id: youMustChooseDialog
        title: qsTr("Please choose")
        text: qsTr("You must choose an image before continuing.")
        acceptButtonText: qsTr("Ok")
    }
    Dialog {
        id: menuDialog
        title: qsTr("Puzzle Master")
        contentHeight: menuDialogColumn.height
        contentWidth: menuDialogColumn.width
        content: Column {
            id: menuDialogColumn
            spacing: 10

            Button {
                width: 500
                text: qsTr("About")
                onClicked: {
                    menuDialog.close();
                    aboutDialog.open();
                }
            }
            Button {
                width: 500
                text: qsTr("Add own image")
                onClicked: {
                    menuDialog.close();
                    fileSelectorDialog.open();
                }
            }
            Button {
                width: 500
                text: qsTr("Quit")
                normalGradient: Gradient {
                    GradientStop { position: 0; color: "#ED1C24"; }
                    GradientStop { position: 1; color: "#AA1317"; }
                }
                pressedGradient: Gradient {
                    GradientStop { position: 0; color: "#AA1317"; }
                    GradientStop { position: 1; color: "#AA1317"; }
                }
                borderColor: "#980C10"
                onClicked: {
                    menuDialog.close();
                    areYouSureToQuitDialog.open();
                }
            }
        }
    }
    FileSelectorDialog {
        id: fileSelectorDialog
        onAccepted: imagesModel.append({ imageUrl: fileSelectorDialog.selectedImageUrl })
    }
}

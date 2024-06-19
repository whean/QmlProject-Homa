import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Controls 1.4

Item {
    id:settingRoot
    width: 400
    height: 400

    Rectangle{
        id:settingRect
        color: "#424242"
        anchors.fill: parent

        ColumnLayout{
            spacing:5
            Rectangle{
                id:musicSetting
                width: 400
                height: 25
                color: "transparent"
                Text{
                    id:musicPathLabel
                    anchors{
                        left:parent.left
                        leftMargin:5
                        verticalCenter: parent.verticalCenter
                    }
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color: "white"
                    font.family: "Comic Sans MS"
                    text:qsTr("音乐文件夹:")
                }


                FileDialog {
                    id: fileDialog
                    title: "请选择一个文件夹"
                    folder: shortcuts.home
                    selectFolder: true
                    onAccepted: {
                        var url = fileUrl.toString().slice(8)
                        console.log("You chose: " + url)
                        $settingController.musicPath = url
                    }
                    onRejected: {
                        console.log("Canceled")
                    }
                }

                Text{
                    id:musicPathInput
                    width: 250
                    anchors{
                        right:parent.right
                        rightMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                    font.family: "Comic Sans MS"
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignRight
                    color: "white"
                    elide: Text.ElideMiddle

                    text:$settingController.musicPath
                    MouseArea{
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered: {
                            //console.log("mouse enter")
                            musicFolderDetail.visible = true
                        }

                        onExited: {
                            //console.log("mouse exited")
                            musicFolderDetail.visible = false
                        }

                        onClicked: {
                            fileDialog.open()
                        }
                    }
                }


            }
            Rectangle{
                id:musicFolderDetail
                visible: false
                width: 400
                height: 30
                color: "transparent"
                Text{
                    anchors{
                        top:parent.top
                        topMargin: 2
                        right: parent.right
                        rightMargin:2
                    }
                    text:"封面路径:"+$settingController.musicPath+"/Covers"
                    font.pointSize: 10
                    color: "#e2dddd"
                }
                Text{

                    anchors{
                        bottom: parent.bottom
                        bottomMargin: 2
                        right: parent.right
                        rightMargin:2
                    }
                    text:"音乐路径:"+$settingController.musicPath+"/Musics"
                    font.pointSize: 10
                    color: "#e2dddd"
                }
            }

            Rectangle{
                id:homaTypeConfig
                width: 400
                height: 25
                color: "transparent"
                Text{
                    id:monaTypeLabel
                    anchors{
                        left:parent.left
                        leftMargin:5
                        verticalCenter: parent.verticalCenter
                    }
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color: "white"
                    font.family: "Comic Sans MS"
                    text:qsTr("更改类型:")
                }
                ComboBox{
                    id:homaTypeComboBox
                    currentIndex:  $settingController.homaType
                    anchors{
                        right: parent.right
                        rightMargin: 5
                        verticalCenter: parent.verticalCenter
                    }

                    width: 200
                    model: ["Wild","Nerd","Cool"]

                    onCurrentIndexChanged: {
                        $settingController.homaType = currentIndex
                    }
                }
            }
        }

    }
}

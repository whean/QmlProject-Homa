import QtQuick 2.0
import QtQuick.Layouts 1.3
import SW.PageController.enums 1.0
import "../Components"

Item {
    id:homeRoot
    width: 400
    height: 400

    Rectangle{
        id:homeRect
        anchors.fill:parent
        color: "#424242"
        GridLayout{
            anchors{
                top:homeRect.top
                left:homeRect.left
                topMargin: 30
                leftMargin:40
            }
            columns: 3
            rows:3
            rowSpacing:30
            columnSpacing: 40


            AppBtn{
                id:musicBtn
                icon:"qrc:/Resourse/Image/buttons/musicBtn.png"
                pressedIcon: "qrc:/Resourse/Image/buttons/musicBtn_clicked.png"
                target:"MusicSelect"
            }

            AppBtn{
                id:clockBtn
                icon:"qrc:/Resourse/Image/buttons/clockBtn.png"
                pressedIcon: "qrc:/Resourse/Image/buttons/clockBtn_clicked.png"
                target:"Clock"
            }

            AppBtn{
                id:settingBtn
                icon:"qrc:/Resourse/Image/buttons/settingBtn.png"
                pressedIcon: "qrc:/Resourse/Image/buttons/settingBtn_clicked.png"
                target: "Setting"
            }
            AppBtn{
                id:monaChatBtn
                icon:"qrc:/Resourse/Image/buttons/monachatBtn.png"
                pressedIcon: "qrc:/Resourse/Image/buttons/monachatBtn_clicked.png"
                target: "MonaChatLogin"
            }
            AppBtn{
                id:calculator
                icon: "qrc:/Resourse/Image/buttons/calculatorBtn.png"
                pressedIcon:"qrc:/Resourse/Image/buttons/calculatorBtn_clicked.png"
                target:"Calculator"
            }


        }


    }
}

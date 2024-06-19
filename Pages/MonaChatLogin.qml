import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import SW.PageController.enums 1.0
//import QtQuick.VirtualKeyboard 2.2

Item {
    id:loginRoot
    width: 400
    height: 400

    property bool isRegister:false

    Button{
        anchors.top:parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        text:qsTr("测试")
        font.pixelSize: 10
        width: 40
        height: 20
        z:1

        onClicked: {
            $pageController.currentPage = PageController.MonaChatList
        }
    }

    Rectangle{
        id:loginRect
        anchors.fill: parent
        visible: !isRegister

        color: "#9FF781"

        Text{
            text:qsTr("登录")
            font.bold: true
            font.pixelSize: 50
            anchors{
                top:parent.top
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
        }

        //        InputPanel{
        //            visible: false
        //        }

        Item{
            id:loginArea
            width: 350
            height: 100

            anchors{
                top:parent.top
                topMargin: 100
                horizontalCenter: parent.horizontalCenter
            }

            GridLayout{
                columns: 2
                anchors.fill: parent
                columnSpacing: 10
                rowSpacing: 10
                Text{
                    id:useridLabel
                    text:qsTr("用户名")
                    font.bold: true
                    font.pixelSize: 30
                }

                Rectangle{
                    id:useridRect
                    width:useridInput.width
                    height: 30
                    radius: 5
                    TextInput{
                        id:useridInput

                        width: 250
                        anchors.centerIn: parent
                        font.pixelSize: 20
                        validator: RegExpValidator{
                            regExp: /[\S]{6,10}/
                        }
                    }
                }

                Text{
                    id:passwordLabel
                    text:qsTr("密码")
                    font.bold: true
                    font.pixelSize: 30

                }
                Rectangle{
                    id:passwordRect
                    width:passwordInput.width
                    height: 30
                    color: "white"
                    radius: 5
                    TextInput{
                        id:passwordInput
                        width: 200
                        anchors.centerIn: parent
                        font.pixelSize: 20
                        echoMode: passwordInput_check.checkState===Qt.Checked?TextInput.Normal:TextInput.Password
                        clip:true
                        validator: RegExpValidator{
                            regExp: /[\S]{8,15}/
                        }

                    }

                    CheckBox{
                        id:passwordInput_check
                        anchors{
                            left:passwordInput.right
                            leftMargin: 5
                            verticalCenter: passwordInput.verticalCenter
                        }
                        checked:false
                    }

                }

            }

            Button{
                id:signUpBtn
                width: 80
                height: 30
                text:qsTr("注册")
                font.pixelSize: 20
                font.bold:true
                anchors{
                    top:loginArea.bottom
                    topMargin: 10
                    left: loginArea.left
                }

                onClicked: {
                    isRegister = true
                }

            }

            Button{
                id:signInBtn
                width: 80
                height: 30
                text:qsTr("登录")
                font.pixelSize: 20
                font.bold:true
                anchors{
                    top:loginArea.bottom
                    topMargin: 10
                    right: loginArea.right
                }

                onClicked: {

                    if(useridInput.acceptableInput)
                    {
                        $monaChatController.showDialog("用户名不合法","须包含6-10位数字、字母或下划线")
                        return
                    }
                    if(passwordInput.acceptableInput)
                    {
                        $monaChatController.showDialog("密码不合法","须包含8-15位非空白字符")
                        return
                    }
                    $monaChatController.login(useridInput.text,passwordInput.text)
                    //$pageController.currentPage = PageController.MonaChatList
                }
            }

            CheckBox{
                id:autoLoginCkBox
                checked:false
                text:qsTr("自动登录")
                font.pixelSize: 15
                anchors{
                    top:signUpBtn.bottom
                    topMargin: 5
                    left: signUpBtn.left
                    leftMargin: 50
                }

                onCheckStateChanged: {
                    console.log("autoLoginCkBox: checkState:"+checkState)
                    if(checkState === Qt.Checked)
                    {
                        rememberCkBox.checked = true
                        rememberCkBox.checkable = false
                        $monaChatController.autoLogin = true
                    }
                    else if(checkState === Qt.Unchecked)
                    {
                        rememberCkBox.checked = false
                        rememberCkBox.checkable = true
                        $monaChatController.autoLogin = false

                    }
                }
            }

            CheckBox{
                id:rememberCkBox
                checked: false
                text:qsTr("记住密码")
                font.pixelSize: 15
                anchors{
                    top:signInBtn.bottom
                    topMargin: 5
                    right: signInBtn.right
                    rightMargin: 50
                }

                onCheckStateChanged: {
                    console.log("rememberCkBox: checkState:"+checkState)
                }
            }
        }
    }


    Rectangle{
        id:registerRect
        anchors.fill: parent
        visible: isRegister
        color: "#9FF781"

        Text{
            text:qsTr("注册")
            font.bold: true
            font.pixelSize: 50
            anchors{
                top:parent.top
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
        }

        Item{
            id:registerArea
            width: 350
            height: 150

            anchors{
                top:parent.top
                topMargin: 100
                horizontalCenter: parent.horizontalCenter
            }

            GridLayout{
                columns: 2
                anchors.fill: parent
                columnSpacing: 10
                rowSpacing: 10

                Text{
                    id:r_useridLabel
                    text:qsTr("用户名")
                    font.bold: true
                    font.pixelSize: 25
                }

                Rectangle{
                    id:r_useridRect
                    width:useridInput.width
                    height: 25
                    color: "white"
                    radius: 5
                    TextInput{
                        id:r_useridInput

                        width: 250
                        anchors.centerIn: parent
                        font.pixelSize:20
                        validator: RegExpValidator{
                            regExp: /[\w]{6,10}/
                        }
                    }
                }

                Text{
                    id:r_emailLabel
                    text:qsTr("邮箱")
                    font.bold: true
                    font.pixelSize: 25
                }

                Rectangle{
                    id:r_emailRect
                    width:useridInput.width
                    height: 25
                    color: "white"
                    radius: 5
                    TextInput{
                        id:r_emailInput

                        width: 250
                        anchors.centerIn: parent
                        font.pixelSize:20
                    }
                }

                Text{
                    id:r_passwordLabel
                    text:qsTr("密码")
                    font.bold: true
                    font.pixelSize: 25
                }
                Rectangle{
                    id:r_passwordRect
                    width:passwordInput.width
                    height: 25
                    color: "white"
                    radius: 5
                    TextInput{
                        id:r_passwordInput
                        width: 200
                        anchors.centerIn: parent
                        font.pixelSize:20
                        echoMode: r_passwordInput_check.checkState===Qt.Checked?TextInput.Normal:TextInput.Password
                        clip:true
                        validator: RegExpValidator{
                            regExp: /[\S]{8,15}/
                        }

                    }

                    CheckBox{
                        id:r_passwordInput_check
                        anchors{
                            left:r_passwordInput.right
                            leftMargin: 5
                            verticalCenter: r_passwordInput.verticalCenter
                        }
                        checked:false
                    }

                }
                Text{
                    id:r_passwordLabel_r
                    text:qsTr("重复密码")
                    font.bold: true
                    font.pixelSize:25

                }
                Rectangle{
                    id:r_passwordRect_r
                    width:passwordInput.width
                    height: 25
                    color: "white"
                    radius: 5
                    TextInput{
                        id:r_passwordInput_r
                        width: 200
                        anchors.centerIn: parent
                        font.pixelSize:20
                        echoMode: r_passwordInput_check.checkState===Qt.Checked?TextInput.Normal:TextInput.Password
                        clip: true
                        validator: RegExpValidator{
                            regExp: /[\S]{8,15}/
                        }
                    }


                }

            }



        }

        Button{
            id:r_cancelBtn
            width: 80
            height: 30
            text:qsTr("取消")
            font.pixelSize: 20
            font.bold:true
            anchors{
                top:registerArea.bottom
                topMargin: 10
                left: registerArea.left
            }

            onClicked: {
                isRegister = false
            }

        }

        Button{
            id:r_signUpBtn
            width: 80
            height: 30
            text:qsTr("注册")
            font.pixelSize: 20
            font.bold:true
            anchors{
                top:registerArea.bottom
                topMargin: 10
                right: registerArea.right
            }

            onClicked: {
                if(r_useridInput.acceptableInput)
                {
                    $monaChatController.showDialog("用户名不合法","须包含6-10位数字、字母或下划线")
                    return
                }
                if(r_passwordInput.acceptableInput)
                {
                    $monaChatController.showDialog("密码不合法","须包含8-15位非空白字符")
                    return
                }
                if(r_passwordInput.text ===r_passwordInput_r.text)
                {
                    $monaChatController.showDialog("两次输入的密码不同")
                    return
                }
                $monaChatController.setup(r_useridInput,r_passwordInput)
            }
        }



    }
    onVisibleChanged: {
        if(loginRoot.visible)
            isRegister = false
    }
}

import QtQuick 2.0

Item {
    id:customButton

    property bool isPressed:false
    property string pressedIcon
    property string icon
    property  int mirror: CustomButton.Mirror.NoMirror

    signal sigReleased()
    signal sigClicked()

    enum Mirror{
        NoMirror = 0,
        Horizontal,
        Vertical
    }

    Image {
        id:btImage


        anchors.fill: parent
        fillMode: Image.Stretch
        source: isPressed?pressedIcon:icon



        Scale{
            id:v_mirror
            yScale: -1
            origin.y:btImage.height/2
            origin.x:btImage.width/2
        }

        Scale{
            id:h_mirror
            xScale: -1
            origin.y:btImage.height/2
            origin.x:btImage.width/2
        }
    }

    MouseArea{
        id:btMouseArea
        anchors.fill: parent
        onPressed:  {
            isPressed = true;
        }
        onReleased: {
            isPressed = false;
            sigReleased();
        }
        onClicked: {
            sigClicked();
        }

    }

    onMirrorChanged: {
        switch(customButton.mirror)
                    {
                    case CustomButton.Mirror.NoMirror:btImage.transform = new Scale();break
                    case CustomButton.Mirror.Horizontal:btImage.transform = h_mirror;break
                    case CustomButton.Mirror.Vertical:btImage.transform = v_mirror;break
                    }
    }



}

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 2.0

Item {
    property alias grooveColor: grooveRect.color
    property alias fillColor: fillRect.color
    property alias handle: valuew
    property alias maximumValue: slider.maximumValue
    property alias minimumValue: slider.minimumValue
    property alias stepSize: slider.stepSize
    property alias orientation: slider.orientation

    Rectangle{
        id:grooveRect


        Rectangle{
            id:fillRect
        }
    }

    ProgressBar{

    }

}

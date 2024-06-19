import QtQuick 2.0
import SW.PageController.enums 1.0
import "./Popups"

Item {
    VolumePopup{
        id:valumePopup
        visible: checkPopupVisible(PageController.VolumePopup)

        x:50
        y:30
        width:300
        height: 30
    }

    MusicPopup{
        id:musicPopup
        visible: checkPopupVisible(PageController.MusicPopup)

        x:0
        y:300
    }

    LoadingPopup{
        id:loadingPopup
        visible: checkPopupVisible(PageController.LoadingPopup)

        x:0
        y:0
    }

    function checkPopupVisible(popup){
        console.log(popup)
        console.log($pageController.showPopups)
        console.log($pageController.showPopups&popup)
        return $pageController.showPopups&popup === popup
    }
}

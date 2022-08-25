import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Page {
	ListView {
		anchors.fill: parent
		clip: true
		SwitchDelegate {
			text: qsTr("深色模式")
			width: parent.width
			checked: mainWindow.Material.theme === Material.Dark ? true : false
			onCheckedChanged: {
				if(checked){
					mainWindow.Material.theme = Material.Dark
				}else{
					mainWindow.Material.theme = Material.Light
				}
			}
		}
	}
}

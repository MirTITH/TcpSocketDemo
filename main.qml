import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {
	width: 360
	height: 640
	minimumWidth: 300
	minimumHeight: 240
	visible: true
	title: qsTr("TCP Socket Test")
	id: mainWindow

//	Material.accent: Material.BlueGrey

//	Material.theme: Material.Dark

	ListModel {
		id: tabBarModel
		ListElement { buttonText: "服务器"; pageUrl:"qrc:/ServerPage.qml" }
		ListElement { buttonText: "客户端"; pageUrl:"qrc:/ClientPage.qml" }
		ListElement { buttonText: "设置"; pageUrl:"qrc:/SettingPage.qml" }
	}

	header: TabBar {
		id: bar
		width: parent.width
		currentIndex: view.currentIndex

		Repeater {
			model: tabBarModel
			TabButton {
				height: bar.height
				text: buttonText
			}
		}
	}

	SwipeView {
		id: view
		currentIndex: bar.currentIndex
		anchors.fill: parent
		anchors.topMargin: 10

		Repeater {
			model: tabBarModel
			Loader {
//				active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
				active: true
				source: pageUrl
			}
		}
	}

	// ServerPage{
	// 	anchors.fill: parent
	// }
}

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import CppNetWork 1.0

Window {
	width: 360
	height: 640
	visible: true
	title: qsTr("TCP Socket Test")
	id: mainWindow

	NetWork {
		id: network
	}

	Column {
		anchors.fill: parent
		anchors.leftMargin: 20
		anchors.rightMargin: 20
		Item {
			anchors.left: parent.left
			anchors.right: parent.right
			height: 53

//			Rectangle {
//				anchors.fill: parent
//				color: "transparent"
//				border.width: 1
//			}

			Row {
				anchors.left: parent.left
				height: parent.height

				spacing: 10

				MTextField {
					id: serverIP
					placeholderText: "错误：无法获取"
					height: parent.height
					width: 150
					label: qsTr("服务器IP")
//					text: "127.0.0.1"
					textField.readOnly: true
//					textField.enabled: false
					Component.onCompleted: {
						serverIP.text = network.getHostIPAddress();
					}
				}

				MTextField {
					id: serverPort
					height: parent.height
					width: 60
					label: qsTr("端口")
//					placeholderText: "10088"
				}

			}

			Button {
//				height: parent.height
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: parent.right
				text: qsTr("开始监听")
			}
		}
	}
}

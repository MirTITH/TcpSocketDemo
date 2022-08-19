import QtQuick 2.15
import QtQuick.Controls 2.15
import CppNetWork 1.0
import "qrc:/resource/Icon.js" as MdiFont

Page {
	NetWork {id: network}

	header:	Item {
		id: head
		height: 53

		MTextField {
			id: serverIP
			height: parent.height
			anchors.left: parent.left
			anchors.right: serverPort.left
			anchors.leftMargin: 10
			anchors.rightMargin: 10

			label: qsTr("目标服务器的IP")
			textField.readOnly: false
		}

		MTextField {
			id: serverPort
			height: parent.height
			width: 60
			anchors.right: connectSwitchCol.left
			anchors.rightMargin: 20

			label: qsTr("端口")
			placeholderText: "10088"
		}

		Item {
			id: connectSwitchCol
			height: parent.height
			width: 80
			anchors.right: parent.right
			anchors.rightMargin: 10

			Text {
				anchors.horizontalCenter: parent.horizontalCenter
				text: connectSwitch.checked ? qsTr("已连接") : qsTr("未连接")
				color: connectSwitch.checked ? Material.accentColor : Material.secondaryTextColor
			}

			Switch {
				id: connectSwitch
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				anchors.topMargin: 10
			}
		}
	}

	// 消息框
	Item {
		anchors.fill: parent
		anchors.margins: 10
		Text {
			id: msgBlockTitle
			text: qsTr("消息记录")
			color: Material.accentColor
		}

		ScrollView {
			anchors.top: msgBlockTitle.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: parent.bottom

			TextArea {
				text: ""
				placeholderText: "这里没有消息"
				selectByMouse: true
				readOnly: true
				background: Rectangle {
					color: "transparent"
					border.width: 1
					radius: 5
					border.color: Material.primaryColor
					opacity: 0.5
				}
			}
		}

	}

	footer: Item {
		height: 53
		MTextField {
			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.rightMargin: 10
			label: qsTr("待发送的消息")

			Button {
				id: sendMsgBtn
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: -5
				anchors.rightMargin: 0
				text: MdiFont.Icon.send
				//				radius: 24
				//				width: 36
				//				height: 36
				font.pixelSize: 20
				opacity: 0.75
				onClicked: {

				}
			}

		}
	}
}

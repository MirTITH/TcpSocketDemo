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
			anchors.left: parent.left
			anchors.right: serverPort.left
			anchors.rightMargin: 20
			anchors.leftMargin: 10
			height: parent.height

			label: qsTr("目标服务器的IP")
			textField.readOnly: false
		}

		MTextField {
			id: serverPort
			anchors.right: startConnect.left
			anchors.rightMargin: 10
			height: parent.height
			width: 60
			label: qsTr("端口")
			placeholderText: "10088"
		}

		Button {
			id: startConnect
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.rightMargin: 10
			text: qsTr("连接")
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
					radius: 3
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

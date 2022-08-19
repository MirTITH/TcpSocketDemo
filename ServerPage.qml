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
			id: hostIP
			anchors.left: parent.left
			anchors.right: serverPort.left
			anchors.rightMargin: 20
			anchors.leftMargin: 10
			height: parent.height

			label: qsTr("主机IP")
			placeholderText: "错误：无法获取"
			textField.readOnly: true

			Component.onCompleted: {
				hostIP.text = network.getHostIPAddress();
			}

			RoundButton {
				id: refreshHostIP
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: -5
				anchors.rightMargin: 0
				text: MdiFont.Icon.refresh
				radius: 24
				width: 2 * radius
				height: 2 * radius
				font.pixelSize: 20
				opacity: 0.75
				onClicked: {
					rotAni.restart()
					hostIP.text = network.getHostIPAddress()
				}

				RotationAnimation {
					id: rotAni
					target: refreshHostIP
					property: "rotation"
					from: 0
					to: 360
					easing {
						type: Easing.OutBack
						overshoot: 4
					}
					duration: 1000
				}
			}
		}

		MTextField {
			id: serverPort
			anchors.right: startListen.left
			anchors.rightMargin: 10
			height: parent.height
			width: 60
			label: qsTr("端口")
			placeholderText: "10088"
		}

		Button {
			id: startListen
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.rightMargin: 10
			text: qsTr("开始监听")
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
				text: "TextArea\n...\n...\n...\n...\n...\n...\n"
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
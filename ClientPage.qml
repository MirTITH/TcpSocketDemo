import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "qrc:/resource/Icon.js" as MdiFont

Page {
	header:	Item {
		id: head
		height: 45

		MTextField {
			id: serverIP
			height: parent.height
			anchors.left: parent.left
			anchors.right: serverPort.left
			anchors.leftMargin: 10
			anchors.rightMargin: 10

			label: qsTr("目标服务器的IP")
			placeholderText: "localhost"
			readOnly: false
			selectByMouse: true
		}

		MTextField {
			id: serverPort
			height: parent.height
			width: 60
			anchors.right: connectSwitchCol.left
			anchors.rightMargin: 20

			label: qsTr("端口")
			placeholderText: "10088"
			selectByMouse: true
		}

		Item {
			id: connectSwitchCol
			height: parent.height
			width: 80
			anchors.right: parent.right
			anchors.rightMargin: 10

			Connections {
				target: _tcpClient
				function onConnected(){
					textConnectState.state = "connected"
				}

				function onDisconnected(){
					textConnectState.state = "disconnected"
					connectSwitch.checked = false
				}

				function onNewMessage(message){
					clientTextArea.text += "From host: " + message + "\n"
				}

				function onErrorOccurred(socketError) {
					textConnectState.state = "error"
					connectSwitch.checked = false
				}
			}

			Text {
				id: textConnectState
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: 14
				state: "disconnected"
				states: [
					State {
						name: "disconnected"
						PropertyChanges {
							target: textConnectState
							text: qsTr("未连接")
							color: Material.secondaryTextColor
						}
					},
					State {
						name: "connecting"
						PropertyChanges {
							target: textConnectState
							text: qsTr("连接中")
							color: Material.secondaryTextColor
						}
					},
					State {
						name: "connected"
						PropertyChanges {
							target: textConnectState
							text: qsTr("已连接")
							color: Material.accentColor
						}
					},
					State {
						name: "error"
						PropertyChanges {
							target: textConnectState
							text: qsTr("连接出错")
							color: "red"
						}
					}
				]
			}

			Switch {
				id: connectSwitch
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				anchors.topMargin: 10

				onCheckedChanged: {
					if(checked)
					{
						_tcpClient.connectToHost(serverIP.text ? serverIP.text : serverIP.placeholderText, Number(serverPort.text ? serverPort.text : serverPort.placeholderText));
						textConnectState.state = "connecting"
					}
					else
					{
						_tcpClient.disconnectFromHost()
					}
				}
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

			contentWidth: availableWidth // 只允许垂直滚动

			TextArea {
				id: clientTextArea
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
		height: 45
		MTextField {
			id: textMsgToSend
			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.rightMargin: 10
			label: qsTr("待发送的消息")
			selectByMouse: true

			onAccepted:{
				sendMsgBtn.clicked()
			}

			Button {
				id: sendMsgBtn
				height: parent.height
				width: 40
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: -5
				anchors.rightMargin: 0

				contentItem: Text {
					text: parent.text
					font: parent.font
					color: parent.down ? Material.accentColor : Material.primaryTextColor
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					//							elide: Text.ElideRight
				}

				text: MdiFont.Icon.send
				font.pixelSize: 24
				opacity: 0.75
				background: null

				onClicked: {
					_tcpClient.sendMessageToHost(textMsgToSend.text)
					clientTextArea.text += "To host: " + textMsgToSend.text + "\n"
					textMsgToSend.text = null
				}
			}

		}
	}
}

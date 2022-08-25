import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import "qrc:/resource/Icon.js" as MdiFont

Page {
	header:	Item {
		id: head
		height: 45

		Connections {
			target: _tcpServer
			function onNewMessage(name, message){
				serverTextArea.text += "From " + name + ": " + message + "\n"
			}
			function onClientConnected(key){
				listModelClients.append({text: key})
			}
			function onClientDisconnected(key){
				for(var i = 0;;i++){
					var obj = listModelClients.get(i)
					if(obj === null)
					{
						break;
					}

					if(obj.text === key)
					{
						listModelClients.remove(i)
						break;
					}
				}
			}
		}

		MTextField {
			id: hostIP
			anchors.left: parent.left
			anchors.right: serverPort.left
			anchors.rightMargin: 20
			anchors.leftMargin: 10
			height: parent.height

			label: qsTr("主机IP")
			placeholderText: "错误：无法获取"
			readOnly: true
			selectByMouse: true

			Component.onCompleted: {
				hostIP.text = _network.getHostIPAddress();
			}

			RoundButton {
				id: refreshHostIP
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: -6
				anchors.rightMargin: 0
				background: null
				Text {
					id: refreshIcon
					anchors.fill: parent
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					text: MdiFont.Icon.refresh
					font.pixelSize: 24
					color: parent.down ? Material.accentColor : Material.primaryTextColor
				}
				radius: 20
				width: 2 * radius
				height: 2 * radius
				opacity: 0.75

				onClicked: {
					rotAni.restart()
					hostIP.text = _network.getHostIPAddress()
				}

				RotationAnimation {
					id: rotAni
					target: refreshIcon
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
			anchors.right: listenSwitchCol.left
			anchors.rightMargin: 20
			height: parent.height
			width: 60
			label: qsTr("端口")
			placeholderText: "10088"
			selectByMouse: true
		}

		Item {
			id: listenSwitchCol
			height: parent.height
			width: 70
			anchors.right: parent.right
			anchors.rightMargin: 10
			Text {
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: 14
				text: listenSwitch.checked ? qsTr("正在监听") : qsTr("未监听")
				color: listenSwitch.checked ? Material.accentColor : Material.secondaryTextColor
			}

			Switch {
				id: listenSwitch
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				anchors.topMargin: 10
				onCheckedChanged: {
					if(checked)
					{
						var result = _tcpServer.listen(Number(serverPort.text ? serverPort.text : serverPort.placeholderText))
						console.log(result)
					}
					else
					{
						_tcpServer.close()
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

			TextArea {
				id: serverTextArea
				placeholderText: qsTr("还没有消息哦")
				selectByMouse: true
				readOnly: true

				wrapMode: TextEdit.WordWrap

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
		height: 90

		ColumnLayout {
			anchors.fill: parent
			anchors.leftMargin: 10
			anchors.rightMargin: 10
			RowLayout {
				Layout.fillWidth: true

				Layout.preferredHeight: 40
				Layout.fillHeight: true
				Text {
					text: qsTr("发送消息的对象：")
					color: Material.primaryTextColor
					Layout.fillHeight: true
					font.pixelSize: 14
					verticalAlignment: Text.AlignVCenter
				}
				ComboBox {
					id: comboBoxClientSelecter
					opacity: 0.75
					Layout.fillHeight: true
					Layout.fillWidth: true
					model: ListModel {
						id: listModelClients
					}
				}
			}

			MTextField {
				id: textMsgToSend
				Layout.preferredHeight: 45
				Layout.fillWidth: true
				selectByMouse: true

				label: qsTr("待发送的消息")

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
						_tcpServer.sendMessageToClient(comboBoxClientSelecter.currentText, textMsgToSend.text)
						serverTextArea.text += "To " + comboBoxClientSelecter.currentText + ": " + textMsgToSend.text + "\n"
						textMsgToSend.text = null
					}
				}

			}
		}
	}
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
	id: root
	property string label
	property string text
	property string placeholderText
	property alias textField: innerTextField

	width: 100
	height: 45 + 8

	function getLabelTextDownY()
	{
		return innerTextField.y + innerTextField.height / 2 - labelText.height / 2 - 6
	}

	QtObject {
		id: attr
		property int topLabelHeight: 16
		property int labelTextDownY
	}

	Text {
		id: labelText
		anchors.left: root.left
		height: attr.topLabelHeight

		text: root.label
		fontSizeMode: Text.Fit
		minimumPointSize: 6
		font.pointSize: 20
		color: Material.accent
		state: (innerTextField.placeholderText || innerTextField.text) ? "up" : "down"
		states: [
			State {
				name: "up"
				PropertyChanges {
					target: labelText
					color: Material.accentColor
					height: attr.topLabelHeight
					y: 0
				}
			},
			State {
				name: "down"
				PropertyChanges {
					target: labelText
					color: innerTextField.placeholderTextColor
					height: innerTextField.contentHeight
					y: attr.labelTextDownY
				}
			}
		]

		transitions: [
			Transition {
				from: "up"
				to: "down"
				PropertyAnimation {properties: "height,y";duration: 100}
				ColorAnimation {properties: "color";duration: 100}
			},
			Transition {
				from: "down"
				to: "up"
				PropertyAnimation {properties: "height,y";duration: 100}
				PropertyAnimation {properties: "color";duration: 100}
			}
		]
	}

	TextField {
		id: innerTextField
		anchors.fill: root
		anchors.topMargin: attr.topLabelHeight - 8

		text: root.text
		placeholderText: parent.placeholderText
		selectByMouse: true

		onFocusChanged: {
			if(focus){
				labelText.state = "up"
			}else if(!(placeholderText || text)){
				labelText.state = "down"
			}
		}

		Component.onCompleted: {
			attr.labelTextDownY = getLabelTextDownY()
		}

		onHeightChanged: {
			attr.labelTextDownY = getLabelTextDownY()
		}

		onYChanged: {
			attr.labelTextDownY = getLabelTextDownY()
		}
	}
}

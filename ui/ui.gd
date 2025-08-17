extends CanvasLayer

@onready var control: Control = $Control

var os_name: String:
	get:
		var aux := OS.get_name()
		if aux == "Android" || aux == "iOS": 
			aux = "Mobile"
		elif aux == "Web":
			var agent = JavaScriptBridge.eval("navigator.userAgent")
			if agent != null and typeof(agent) == TYPE_STRING:
				var ua = agent.to_lower()
				if "android" in ua or "iphone" in ua or "ios":
					aux = "Mobile"
		return aux


func _ready() -> void:
	control.visible = (os_name == "Mobile")



func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_close_pressed() -> void:
	get_tree().quit()

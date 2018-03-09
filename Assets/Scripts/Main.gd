extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var fps_label = null
var var_label = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.set_window_fullscreen(true)
	fps_label = get_node("Panel/FPS")
	
func _process(delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
extends TextureRect
var can_grab = false
var grabbed_offset = Vector2()
var initial_pos := position
var placeholder = null

func _gui_input(event):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_grab:
		if placeholder:
			placeholder.position = get_global_mouse_position() - get_viewport_rect().size / 2
		else:
			position = get_global_mouse_position() + grabbed_offset
	if Input.is_action_just_released("LeftClick") and placeholder:
		check_can_drop()

func _get_drag_data(at_position):
	visible = false
	create_placeholder()
	print(at_position)

func check_can_drop():
	position = initial_pos
	can_grab = false
	visible = true
	if placeholder.can_place:
		build()
		placeholder = null
		return
	failed_drop()

func build():
	placeholder.build()

func failed_drop():
	if placeholder:
		placeholder.queue_free()
		placeholder = null
	
func create_placeholder():
	var turretScene := preload("res://Scenes/turrets/turret.tscn")
	var turret = turretScene.instantiate()
	Configs.turretsNode.add_child(turret)
	placeholder = turret
	placeholder.set_placeholder()

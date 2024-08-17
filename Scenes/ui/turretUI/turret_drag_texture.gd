extends TextureRect

var turretType := ""

var can_grab = false
var grabbed_offset = Vector2()
var initial_pos := position
var placeholder = null

func _ready():
	Globals.goldChanged.connect(check_can_purchase)

func _gui_input(event):
	if event is InputEventMouseButton and check_can_purchase(Globals.currentMap.gold):
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

func _get_drag_data(_at_position):
	if check_can_purchase(Globals.currentMap.gold):
		visible = false
		create_placeholder()

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
	Globals.currentMap.gold -= Data.turrets[turretType]["cost"]
	placeholder.build()

func failed_drop():
	if placeholder:
		placeholder.queue_free()
		placeholder = null

func create_placeholder():
	var turretScene := load(Data.turrets[turretType]["scene"])
	var turret = turretScene.instantiate()
	turret.turret_type = turretType
	Globals.turretsNode.add_child(turret)
	placeholder = turret
	placeholder.set_placeholder()

func check_can_purchase(newGold):
	if turretType:
		if newGold >= Data.turrets[turretType]["cost"]:
			get_parent().can_purchase = true
			return true
		get_parent().can_purchase = false
		return false

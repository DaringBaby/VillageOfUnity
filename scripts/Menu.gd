extends TextureRect
var menu_open = false
signal close_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_labels()
	if menu_open:
		if Input.is_action_just_pressed("ui_cancel"):
			await get_tree().create_timer(0.1).timeout
			emit_signal("close_menu")
			hide()
			menu_open = false
			set_process(false)
	pass


func set_labels():
	if !Items.woman_flag:
		$Woman.text = "Help her!"
	else:
		$Woman.text = "Completed"
	if !Items.orc_flag:
		$Orc.text = "Help him!"
	else:
		$Orc.text = "Completed"
	if !Items.giant_flag:
		$Giant.text = "Help him!"
	else:
		$Giant.text = "Completed"
	if !Items.goblin_flag:
		$Goblin.text = "Help him!"
	else:
		$Goblin.text = "Completed"
	
	$Bronze.text = "x" + str(Items.get_quantities("Bronze"))
	$Iron.text = "x" + str(Items.get_quantities("Iron"))
	$Gold.text = "x" + str(Items.get_quantities("Gold"))
	$Flower.text = "x" + str(Items.get_quantities("Flower"))
	$Sword.text = "x" + str(Items.get_quantities("Sword"))
	$Money.text = str(Items.gold)
pass


func _on_player_open_menu():
	set_process(true)
	show()
	await get_tree().create_timer(0.1).timeout
	menu_open = true
	pass # Replace with function body.

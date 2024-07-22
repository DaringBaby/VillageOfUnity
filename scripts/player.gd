extends CharacterBody2D
var dir
signal open_text
signal open_menu
var input_direction

var music_village = preload("res://8_bit_ice_cave_lofi.mp3")
var music_spooky = preload("res://Memoraphile - Spooky Dungeon.wav")


func _ready():
	$Camera2D.limit_bottom = 224
	$Camera2D.limit_top = 0
	$Camera2D.limit_left = -384
	$Camera2D.limit_right = 0
 
func _process(_delta):
	print(dir)
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	$GridMovement.move(input_direction)
	interact()
	balloon()
	if Items.orc_flag and Items.goblin_flag and Items.woman_flag and Items.giant_flag:
		get_tree().change_scene_to_file("res://outro.tscn")
		pass
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("open_menu")
		set_process(false)
	
 
func vector2Direction(vec: Vector2) -> String:
	var direction = "down"
	if vec.y > 0:
		direction = "down"
	elif vec.y < 0:
		direction = "up"
	elif vec.x > 0:
		direction = "right"
	elif vec.x < 0:
		direction = "right"
		
	return direction
	
func vector2Direction2(vec: Vector2) -> String:
	var direction
	if vec.y > 0:
		direction = "down"
	elif vec.y < 0:
		direction = "up"
	elif vec.x > 0:
		direction = "right"
	elif vec.x < 0:
		direction = "left"
	return direction
	

func balloon():
	if $GridMovement/RayCast2D.is_colliding():
		if "Rock" in $GridMovement/RayCast2D.get_collider().name:
			$Balloon.play("pickaxe")
			$Balloon.show()
		elif "NPC" in $GridMovement/RayCast2D.get_collider().name or "Flower" in $GridMovement/RayCast2D.get_collider().name or "Chest" in $GridMovement/RayCast2D.get_collider().name:
			$Balloon.play("dialogue")
			$Balloon.show()
		else:
			$Balloon.hide()
	else:
			$Balloon.hide()
	pass

func interact():
	if $GridMovement/RayCast2D.is_colliding() and Input.is_action_just_pressed("ui_accept"):
		if "Rock" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Rock")
			if $GridMovement/RayCast2D.get_collider().name == "Rock12":
				$GridMovement/RayCast2D.get_collider().queue_free()
			set_process(false)
		elif "Orc" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Orc")
			set_process(false)
		elif "Woman" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Woman")
			set_process(false)
		elif "Giant" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Giant")
			set_process(false)
		elif "Shop" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Shop")
			set_process(false)
		elif "Chest" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Chest")
			$GridMovement/RayCast2D.get_collider().queue_free()
			set_process(false)
		elif "Goblin" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Goblin")
			set_process(false)
		elif "Flowers" in $GridMovement/RayCast2D.get_collider().name:
			emit_signal("open_text", "Flowers")
			$GridMovement/RayCast2D.get_collider().queue_free()
			set_process(false)
		elif $GridMovement/RayCast2D.get_collider().name == "NPC_Sign":
			emit_signal("open_text", "NPC_Sign")
			set_process(false)
		elif $GridMovement/RayCast2D.get_collider().name == "NPC_Sign2":
			emit_signal("open_text", "NPC_Sign2")
			set_process(false)
		elif $GridMovement/RayCast2D.get_collider().name == "NPC_Sign3":
			emit_signal("open_text", "NPC_Sign3")
			set_process(false)
		elif $GridMovement/RayCast2D.get_collider().name == "NPC_Sign4":
			emit_signal("open_text", "NPC_Sign4")
			set_process(false)
	pass


func _on_textbox_close_text():
	set_process(true)
	pass # Replace with function body.


func _on_area_area_entered(area):
	dir = vector2Direction2(input_direction)
	if area.name =="CS1" or area.name =="CS3":
		if  "left" in dir:
			$Camera2D.limit_left -= 384
			$Camera2D.limit_right -= 384
			get_node("../AudioStreamPlayer").stream = music_village
			get_node("../AudioStreamPlayer").play()
		else:
			$Camera2D.limit_left += 384
			$Camera2D.limit_right += 384
			get_node("../AudioStreamPlayer").stream = music_spooky
			get_node("../AudioStreamPlayer").play()
	elif area.name == "CS2":
		if "up" in dir:
			$Camera2D.limit_top -= 224
			$Camera2D.limit_bottom -= 224
		else:
			$Camera2D.limit_top += 224
			$Camera2D.limit_bottom += 224
	pass # Replace with function body.


func _on_sprite_close_menu():
	set_process(true)
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	get_node("../AudioStreamPlayer").play()
	pass # Replace with function body.

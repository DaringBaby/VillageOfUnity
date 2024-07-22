extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Label.visible_characters < $Label.get_total_character_count():
		$Label.visible_characters += 1
	if Input.is_action_just_pressed("ui_accept") && $Label.visible_characters == $Label.get_total_character_count():
		get_tree().change_scene_to_file("res://world.tscn")
	pass

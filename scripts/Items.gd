extends Node

var inventory = []
var quantities = []

var orc_flag = false
var woman_flag = false
var giant_flag = false
var goblin_flag = false

var shop_flag = false

var gold = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_item(item):
	var pos = inventory.find(item)
	if pos == -1:
		inventory.append(item)
		quantities.append(1)
	else:
		quantities[pos]+= 1
	pass
	
func remove_item(item):
	var pos = inventory.find(item)
	if quantities[pos] == 1:
		inventory.remove_at(pos)
		quantities.remove_at(pos)
	else:
		quantities[pos]-=1
	pass
	
func remove_all_quantities(item):
	var pos = inventory.find(item)
	inventory.remove_at(pos)
	quantities.remove_at(pos)

func check_item(item):
	var pos = inventory.find(item)
	if pos == -1:
		return false
	else:
		return true

func get_quantities(item):
	var pos = inventory.find(item)
	if pos == -1:
		return 0
	else:
		return quantities[pos]

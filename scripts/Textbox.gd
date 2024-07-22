extends TextureRect
signal close_text
signal next

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Label.visible_characters < $Label.get_total_character_count():
		$Label.visible_characters += 1
	if Input.is_action_just_pressed("ui_accept") && $Label.visible_characters == $Label.get_total_character_count():
		$Ting.play()
		emit_signal("next")
	pass


func _on_player_open_text(obj_name):
	reset()
	show()
	await get_tree().create_timer(0.1).timeout
	set_process(true)
	$Ting.play()
	match obj_name:
		"Rock":
			$Label.text = "You mined: "
			var rock = generate_rock()
			$Label.text += rock
			Items.add_item(rock)
			await next
			end_dialogue()
		"Orc":
			if !Items.orc_flag:
				if Items.check_item("Gold"):
					set_text("UHR!!! YOU HAVE SHINY ROCK!! GIVE ME!")
					await next
					Items.remove_item("Gold")
					set_text("THANK YOU!!! VERY MUCH!!! WE FRIENDS NOW!!")
					await next
					Items.orc_flag = true
					end_dialogue()
				else:
					set_text("UHR.. ME WANT SHINY ROCK BUT YOU NO HAVE SHINY ROCK..")
					await  next
					end_dialogue()
			else:
				set_text("ME AND YOU ARE FRIENDS NOW!!")
				await next
				end_dialogue()
		"Flowers":
			set_text("You picked up some flowers.")
			await next
			Items.add_item("Flower")
			end_dialogue()
		"Woman":
			if !Items.woman_flag:
				set_text("I would really love some flowers right now...")
				await next
				if Items.check_item("Flower"):
					set_text("Did you really pick these flowers for me? Thank you!")
					Items.remove_item("Flower")
					Items.woman_flag = true
					await next
					end_dialogue()
				else:
					set_text("They usually grow somewhere along the river.")
					await next
					end_dialogue()
			else:
				set_text("Thank you for the flowers! I really like them.")
				await next
				end_dialogue()
		"Chest":
			set_text("You found a sword.")
			Items.add_item("Sword")
			await next
			end_dialogue()
		"Giant":
			if !Items.giant_flag:
				set_text("HELLO HUMAN! I NEED A TOOTHPICK. CAN YOU GIVE ME ONE?")
				await next
				if !Items.check_item("Sword"):
					set_text("OH, BUT YOU DON'T HAVE ONE... WHATEVER.")
					await next
					end_dialogue()
				else:
					set_text("THANKS HUMAN! I APPRECIATE YOUR HELP.")
					await next
					Items.giant_flag = true
					end_dialogue()
			else:
				set_text("YOU'RE A REALLY KIND HUMAN.")
				await next
				end_dialogue()
		"Shop":
			if !Items.shop_flag:
				set_text("HEH HEH HEH!!! I WILL BUY YOUR PRECIOUS MINERALS!!")
				await next
				set_text("10G FOR BRONZE, 25G FOR IRON AND 100G FOR GOLD!!")
				await next
				set_text("COME BACK NEXT TIME IF YOU NEED SOME MONEY.")
				Items.shop_flag = true
				await next
				end_dialogue()
			else:
				var bronze
				var iron 
				var gold
				var money
				set_text("YOU BROUGHT ME: ")
				if Items.check_item("Bronze"):
					bronze = Items.quantities[Items.inventory.find("Bronze")]
				else:
					bronze = 0
				if Items.check_item("Iron"):
					iron = Items.quantities[Items.inventory.find("Iron")]
				else:
					iron = 0
				if Items.check_item("Gold"):
					gold = Items.quantities[Items.inventory.find("Gold")]
				else:
					gold = 0
				await next
				set_text(str(bronze) + " BRONZE, " + str(iron) + " IRON AND " + str(gold) + " GOLD.")
				money = (10*bronze) + (25*iron) + (100*gold)
				Items.remove_all_quantities("Bronze")
				Items.remove_all_quantities("Iron")
				Items.remove_all_quantities("Gold")
				await next
				if money > 0:
					set_text("I WILL GIVE YOU " + str(money) + " MONEY.")
					await next
					Items.gold += money
					set_text("YOU GOT " + str(money) + " MONEY.")
					await next
				else:
					set_text("COME BACK WHEN YOU HAVE MORE PRECIOUS MINERALS.")
					await next
				end_dialogue()
		"Goblin":
			if !Items.goblin_flag:
				set_text("YOU MONEY OR YOUR LIFE!!!! Give me 500 money!!")
				await next
				if Items.gold >=  500:
					set_text("You're a really smart man! ")
					await next
					Items.gold -= 500
					Items.goblin_flag = true
					end_dialogue()
				else:
					set_text("Heh, it's worthless to me anyway...")
					await next
					end_dialogue()
			else:
				set_text("Maybe we can be friends now...")
				await next
				end_dialogue()
					
		"NPC_Sign":
			set_text("Trimone Village")
			await next
			end_dialogue()
		"NPC_Sign2":
			set_text("Graveyard")
			await next
			end_dialogue()
		"NPC_Sign3":
			set_text("Wild Outskirts")
			await next
			end_dialogue()
		"NPC_Sign4":
			set_text("Giant's den / Shopkeeper")
			
	pass # Replace with function body.


func generate_rock():
	randomize()
	var rng = randi_range(1, 100)
	var rock
	if rng > 25:
		rock = "Bronze"
	elif rng > 6:
		rock = "Iron"
	else:
		rock = "Gold"
	return rock

func end_dialogue():
	hide()
	emit_signal("close_text")
	set_process(false)

func reset():
	$Label.visible_characters = 0
	pass

func set_text(msg):
	reset()
	$Label.text = msg

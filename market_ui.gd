extends VBoxContainer

func start():
	Player.country.get_parent().market_update.connect(_on_market_update)

func _on_market_update(market:Market):
	var children:Array = get_children()
	if children != null:
		for child in children:
			child.queue_free()
		
	for key: String in market.commodities:
		var com:Commodity = market.commodities[key]
		var hbox: HBoxContainer = HBoxContainer.new()
		add_child(hbox)
		
		var name_label: Label = Label.new()
		hbox.add_child(name_label)
		name_label.text = com.comodity_name.to_pascal_case()
		
		var separator_label: Label = Label.new()
		hbox.add_child(separator_label)
		separator_label.text = "|Prize:"
		
		var prize_label: Label = Label.new()
		hbox.add_child(prize_label)
		prize_label.text = str(com.prize)
		

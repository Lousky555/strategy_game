extends GridContainer

#Optimalizovat pokud budou problémy s výkonem

func start():
	Player.country.get_parent().market_update.connect(_on_market_update)
	_on_market_update(Player.country.get_parent())

func _on_market_update(market:Market):
	var children:Array = get_children()
	if children != null:
		for child in children:
			child.queue_free()
		
	add_child(UiMake.make_label("Commodity"))
	add_child(UiMake.make_label("Price"))
	
	for key: String in market.commodities:
		var com:Commodity = market.commodities[key]
		
		add_child(UiMake.make_label(com.comodity_name.to_pascal_case()))
		add_child(UiMake.make_label(str(round(com.prize))))

		

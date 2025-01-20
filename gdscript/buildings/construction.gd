class_name Construction extends Building

var building:Variant
var progress:float
var difficulty:int = 100 #říká jak moc těžké je postavit budovu ,do toho se počítá i velikost budovy
var effectivness:int = 5
var expansion:bool

func _init(is_expansion:bool, target_or_new_building:Variant) -> void:
	inventory = {"crop": 0, "food":0, "clothes":0, "furniture":0, "electronics":0, "steel":0, "wood":0}
	level = 1
	expansion = is_expansion
	building = target_or_new_building
	population_per_level = 200

func _on_tick() -> void:
	if money > 0:
		buy_needs(money/2)
		if !inventory["steel"] >= (1 - progress) * 100 * difficulty:
			make_demand.emit(self, "steel", ((money / 2) / market.get_commodity("steel").prize))
		if !inventory["woood"] >= (1 - progress) * 100 * difficulty:
			make_demand.emit(self, "wood", (money / market.get_commodity("wood").prize))
	_work()
	if progress >= 1:
		if expansion:
			building.level += 1
		else:
			get_parent().add_child(building)

func _work():
	if (inventory["wood"] < inventory["steel"] and inventory["wood"] == effectivness * difficulty) or (inventory["wood"] > inventory["steel"] and inventory["steel"] == effectivness * difficulty):
		progress += effectivness / difficulty
		inventory["wood"] -= effectivness * difficulty
		inventory["steel"] -= effectivness * difficulty
	elif inventory["wood"] < inventory["steel"]:
		progress += inventory["wood"] / difficulty / 100
		inventory["steel"] -= inventory["wood"]
		inventory["wood"] = 0
	elif inventory["wood"] > inventory["steel"]:
		progress += inventory["steel"] / difficulty / 100
		inventory["wood"] -= inventory["steel"]
		inventory["steel"] = 0

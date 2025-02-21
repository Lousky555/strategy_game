class_name Relation extends Node

var country_a:Country 
var country_b:Country

var opinion:float = 0: 
	set(value):
		if value > 250:
			opinion = 250
			improv_countries.clear()
			return
		
		if value < -250:
			opinion = -250
			dam_countries.clear()
			return
		
		opinion = value

var alliance:bool = false
var in_war:bool = false

var improv_countries:Array[Country] = []
var dam_countries:Array[Country] = []

var subject_is:Country = null

signal war_declared

func _ready() -> void:
	TimeManager.tick.connect(_on_tick)

func _on_tick() -> void:
	if improv_countries != []:
		for country:Country in improv_countries:
			opinion += 1 * country.dip_mult 
	
	if dam_countries != []: 
		for country:Country in improv_countries:
			opinion -= 1 * country.dip_mult 

func declare_war() -> String:
	if opinion >= 100 and (Player.country == country_a or Player.country == country_b):
		return("Can't declare war because of high relations")
	elif alliance:
		return("You are trying to declare war on your allies. Are you mad?")
	elif in_war:
		return("You are already in a war.")
	
	war_declared.emit()
	in_war = true
	return("War declared!")

func establish_alliance() -> String:
	if opinion >= 150 and not in_war:
		alliance = true
		return("Alliance established.")
	elif in_war:
		return("Trying to befriend your enemies is nice, but you are in literal war with them!")
	else:
		return("They have low opinion of them.")

func break_alliance() -> String:
	if opinion <= 100:
		alliance = false
		return("Alliance broken.")
	else: 
		return("Too high opinion.")

func start_rel_improv(country:Country):
	if country in improv_countries:
		return("Already improving.")
	elif opinion == 250:
		return("Opinion already at maximum value")
	else:
		dam_countries.pop_at(dam_countries.find(country))
		improv_countries.append(country)

func stop_rel_improv(country:Country):
	if not country in improv_countries:
		return("You are not improving relations.")
	else:
		improv_countries.pop_at(improv_countries.find(country))

func start_dam_improv(country:Country):
	if country in dam_countries:
		return("Already damaging.")
	elif opinion == -250:
		return("Opinion already at minimum value")
	else:
		improv_countries.pop_at(improv_countries.find(country))
		dam_countries.append(country)

func stop_dam_improv(country:Country):
	if not country in dam_countries:
		return("You are not improving relations.")
	else:
		dam_countries.pop_at(dam_countries.find(country))

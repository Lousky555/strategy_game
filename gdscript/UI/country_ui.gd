extends VBoxContainer

@onready var country_name_label = $CountryName
@onready var qualification_label = $QualificationsLabel/Qualifications
@onready var money_label = $Money/Value

var mouse_inside:bool = false

func start():
	country_name_label.text = Player.country.name
	qualification_label.text = str(Player.country.qualifications)
	
	TimeManager.tick.connect(on_tick)

func on_tick():
	money_label.text = str(Player.country.money)

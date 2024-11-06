extends VBoxContainer

@onready var country_name_label = $CountryName
@onready var qualification_label = $QualificationsLabel/Qualifications

func _ready() -> void:
	
	country_name_label.text = Player.country.name
	qualification_label.text = Player.country.qualifications

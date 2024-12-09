extends VBoxContainer

@onready var country_name_label = $CountryName
@onready var qualification_label = $QualificationsLabel/Qualifications
@onready var money_label = $Money/Value
@onready var income_tax_surp = $IncomeTaxSurplus/Value
@onready var consuption_tax_surp = $ConsuptionTaxSurplus/Value
@onready var propery_tax_surp = $PropertyTaxSurplus/Value

var mouse_inside:bool = false

func start():
	country_name_label.text = Player.country.name
	qualification_label.text = str(Player.country.qualifications)
	
	TimeManager.tick.connect(_on_tick)
	TimeManager.longer_tick.connect(_on_longer_tick)

func _on_tick():
	money_label.text = str(Player.country.money)

func _on_longer_tick():
	income_tax_surp.text = str(Player.country.monthly_income_tax_surplus)
	consuption_tax_surp.text = str(Player.country.monthly_consuption_tax_surplus)
	propery_tax_surp.text = str(Player.country.monthly_propetry_tax_surplus)
	
	Player.country.monthly_consuption_tax_surplus = 0
	Player.country.monthly_income_tax_surplus = 0
	Player.country.monthly_propetry_tax_surplus = 0

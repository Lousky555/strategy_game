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
	Player.country.consuption_tax_sup_change.connect(_consuption_tax_sup_change)
	Player.country.income_tax_sup_change.connect(_income_tax_sup_change)
	Player.country.propery_tax_sup_change.connect(_propery_tax_sup_change)

func _on_tick():
	money_label.text = str(round(Player.country.money))

func _consuption_tax_sup_change(value:float):
	consuption_tax_surp.text = str(round(value))

func _income_tax_sup_change(value:float):
	income_tax_surp.text = str(round(value))

func _propery_tax_sup_change(value:float):
	propery_tax_surp.text = str(round(value))

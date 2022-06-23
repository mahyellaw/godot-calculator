extends Node

var equation_display = ""

func _ready():
	for number_button in $Numbers.get_children():
		number_button.connect("pressed", self, "_number_pressed", [number_button.name])
	
	for operator_button in $Operators.get_children():
		operator_button.connect("pressed", self, "_operator_pressed", [operator_button.name])

func _number_pressed(value):
	equation_display += value
	_display_value(equation_display)

func _operator_pressed(operator):
	match operator:
		"Add":
			equation_display += " + "
		"Subtract":
			equation_display += " - "
		"Divide":
			equation_display += " / "
		"Multiply":
			equation_display += " * "
		"Equate":
			equation_display = _execute(equation_display)
			_display_value(equation_display)
		"Clear":
			equation_display = ""
	_display_value(equation_display)

func _display_value(value):
	$InputField.text = value

func _execute(equation):
	var eq_parser = Expression.new()
	eq_parser.parse(equation)
	return str(eq_parser.execute())

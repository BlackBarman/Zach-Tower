@tool
extends Control

@export var rows: int = 3
@export var columns: int = 3
@export var boolean_array: Array[bool] = []

var grid_container: GridContainer

func _ready() -> void:
	if not Engine.is_editor_hint():
		return

	grid_container = GridContainer.new()
	grid_container.columns = columns
	add_child(grid_container)
	update_grid()

	var vbox = VBoxContainer.new()
	add_child(vbox)

	var add_row_button = Button.new()
	add_row_button.text = "Add Row"
	add_row_button.pressed.connect(self.add_row)
	vbox.add_child(add_row_button)

	var remove_row_button = Button.new()
	remove_row_button.text = "Remove Row"
	remove_row_button.pressed.connect(self.remove_row)
	vbox.add_child(remove_row_button)

	var add_column_button = Button.new()
	add_column_button.text = "Add Column"
	add_column_button.pressed.connect(self.add_column)
	vbox.add_child(add_column_button)

	var remove_column_button = Button.new()
	remove_column_button.text = "Remove Column"
	remove_column_button.pressed.connect(self.remove_column)
	vbox.add_child(remove_column_button)

func update_grid() -> void:
	if not Engine.is_editor_hint():
		return

	grid_container.columns = columns

	# Clear existing checkboxes
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.queue_free()

	# Create new checkboxes
	for row in range(rows):
		for col in range(columns):
			var checkbox = CheckBox.new()
			checkbox.text = "Row %d, Col %d" % [row, col]
			grid_container.add_child(checkbox)

# Function to add a row
func add_row() -> void:
	rows += 1
	update_grid()

# Function to remove a row
func remove_row() -> void:
	if rows > 0:
		rows -= 1
		update_grid()

# Function to add a column
func add_column() -> void:
	columns += 1
	update_grid()

# Function to remove a column
func remove_column() -> void:
	if columns > 0:
		columns -= 1
		update_grid()

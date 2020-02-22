extends Control

enum {FRONT, LEFT, RIGHT, BACK}
enum {SHIRT, PANTS, HAT, SHOES, RAINCOAT}
onready var character = $Character
onready var clothes = $Window/ClothesPanel/PanelContainer/ClothesMenu
onready var color_menu = $ColorMenu
var selected_cloth

func _ready() -> void:
	set_visibility()
	connect_signals()

func set_visibility():
	color_menu.visible = !color_menu.visible
	clothes.visible = !clothes.visible
	$Overlay.visible = !$Overlay.visible

func connect_signals():
	# Toggle the clothes
	clothes.shirt_button.connect("toggled", self, "update_clothes", [SHIRT])
	clothes.pants_button.connect("toggled", self, "update_clothes", [PANTS])
	clothes.shoes_button.connect("toggled", self, "update_clothes", [SHOES])
	clothes.hat_button.connect("toggled", self, "update_clothes", [HAT])
	clothes.raincoat_button.connect("toggled", self, "update_clothes", [RAINCOAT])
	
	# Color Picker Signals
	clothes.shirt_color_button.connect("pressed", self, "show_color_menu", [SHIRT])
	clothes.pants_color_button.connect("pressed", self, "show_color_menu", [PANTS])
	clothes.shoes_color_button.connect("pressed", self, "show_color_menu", [SHOES])
	clothes.hat_color_button.connect("pressed", self, "show_color_menu", [HAT])
	clothes.raincoat_color_button.connect("pressed", self, "show_color_menu", [RAINCOAT])

	# Color Changed
	color_menu.color_picker.connect("color_changed", self, "update_color")
	
func update_color(color):
	match selected_cloth:
		SHIRT:
			clothes.shirt_color.color = color
			character.shirt.modulate = color
		PANTS:
			clothes.pants_color.color = color
			character.pants.modulate = color
		SHOES:
			clothes.shoes_color.color = color
			character.shoes.modulate = color
		HAT:
			clothes.hat_color.color = color
			character.hat.modulate = color
		RAINCOAT:
			clothes.raincoat_color.color = color
			character.raincoat.modulate = color
	
func show_color_menu(cloth):
	selected_cloth = cloth
	color_menu.visible = !color_menu.visible
	$Overlay.visible = !$Overlay.visible

func update_clothes(enabled, cloth):
	match cloth:
		SHIRT:
			character.shirt.visible = enabled
		PANTS:
			character.pants.visible = enabled
		SHOES:
			character.shoes.visible = enabled
		HAT:
			character.hat.visible = enabled
		RAINCOAT:
			character.raincoat.visible = enabled

func _on_Cancel_pressed() -> void:
	get_tree().change_scene("res://Main/Main.tscn")


func _on_Right_pressed() -> void:
	for sprite in character.get_children():
		match sprite.frame:
			FRONT:
				sprite.frame = RIGHT
			RIGHT:
				sprite.frame = BACK
			BACK:
				sprite.frame = LEFT
			LEFT:
				sprite.frame = FRONT


func _on_Left_pressed() -> void:
	for sprite in character.get_children():
		match sprite.frame:
			FRONT:
				sprite.frame = LEFT
			LEFT:
				sprite.frame = BACK
			BACK:
				sprite.frame = RIGHT
			RIGHT:
				sprite.frame = FRONT


func _on_Appearance_pressed() -> void:
	clothes.visible = !clothes.visible


func _on_TextureButton_pressed() -> void:
	color_menu.visible = !color_menu.visible
	$Overlay.visible = !$Overlay.visible

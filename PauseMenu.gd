extends Control

func _ready():
	var ResumeButton = $Control/ResumeButton
	var HomeButton = $Control/HomeButton
	var ExitButton = $Control/ExitButton
	
	ResumeButton.connect("pressed", _on_resume_button_pressed)
	HomeButton.connect("pressed", _on_menu_button_pressed)
	ExitButton.connect("pressed", _on_exit_button_pressed)
	get_tree().paused = false
	self.hide()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not self.is_visible_in_tree():
			# Pause the game when the pause menu is not visible
			get_tree().paused = true
			show()
		elif self.is_visible_in_tree():
			# Unpause the game when the pause menu is already visible
			get_tree().paused = false
			hide()

func _on_resume_button_pressed():
	# Hide the pause menu and resume the game
	self.hide()
	get_tree().paused = false

func _on_menu_button_pressed():
	get_tree().paused = false
	# Return to the main menu
	preload("res://MainMenu.tscn")
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_exit_button_pressed():
	# Quit the game
	get_tree().quit()

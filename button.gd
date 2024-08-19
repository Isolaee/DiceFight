extends Control

func _ready():
	var playButton = $PlayButton
	var exitButton = $ExitButton
	playButton.connect("pressed", _on_PlayButton_pressed)
	exitButton.connect("pressed", _on_ExitButton_pressed)

func _on_ExitButton_pressed():
	# Quit the game
	get_tree().quit()

func _on_PlayButton_pressed():	
	# Transition to the game scene
	get_tree().change_scene_to_file("res://Map.tscn")
	

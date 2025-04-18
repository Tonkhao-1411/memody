extends Node

@onready var score_label = %Score_Label

var points = 0

func add_point():
	points += 1
	print (points)
	score_label.text = "SCORE : " + str(points)

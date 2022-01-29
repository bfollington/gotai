extends Control

@onready var button_a = $_container/button_a
@onready var button_b = $_container/button_b
@onready var container = $_container
@onready var timer: TimerState = $"../_timer"

@onready var counterA = Atom.new(0) 
@onready var counterB = Atom.new(0)
@onready var counterSum = Atom.compose(counterA, timer.timer, func(a, b): return a + b)

@onready var bigSum = Atom.composeN(
	[counterA, counterB, timer.timer],
	func(values: Array):
		return values.reduce(func(a, b): return a + b))

# Called when the node enters the scene tree for the first time.
func _ready():
	bigSum.bind(render)
	render(bigSum.get())

func _exit_tree():
	bigSum.unbind(render)
	
func render(c):	
	$Label.text = "Value is %f." % c
	View.showWhen(c < 10, button_a, container)
	View.showWhen(c < 10, button_b, container)

func inc(v):
	return v + 1

func _on_button_a_pressed():
	counterA.swap(inc)

func _on_button_b_pressed():
	counterB.swap(inc)

func _on_button_c_pressed():
	counterA.reset(0)
	counterB.reset(0)
	timer.timer.reset(0)

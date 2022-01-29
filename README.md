# gotai
reactive atomic state for `godot`, inspired by `jotai`

`gotai` enables somewhat performant reactive UIs using functional programming concepts in `godot`. This project requires `godot 4` as it makes use of lambas extensively.

It works via the `Atom` type which acts as an `Observable` and can be composed with or derived from to create new `Atoms`. Visit [`Atom.gd`](https://github.com/bfollington/gotai/blob/master/Atom.gd) for the full interface.

Here's a short example of a counter rendering its value to a `Label`.

```gdscript
extends Control

@onready var counter = Atom.new(0)
@onready var doubleCounter = Atom.derive(counter, func(v): return v * 2)

# bind our render function to our state
# counter changes -> doubleCounter changes -> render is called
func _ready():
	doubleCounter.bind(render)
	render(doubleCounter.get())

# remove the listener if this node is inactive
func _exit_tree():
	bigSum.unbind(render)
  
# apply state to view (side effects)
func render(c):	
	$Label.text = "Value is %f." % c
  
func inc(v):
	return v + 1

# update counter by clicking button
func _on_button_pressed():
	counter.swap(inc)

```

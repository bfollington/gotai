class_name Atom

var data
var sinks = []

func _init(initial):
	data = initial
	
func bind(f):
	sinks.append(f)

func unbind(f):
	var idx = sinks.find(f)
	if idx >= 0:
		sinks.remove_at(idx)

func get():
	return data
	
func reset(value: Variant):
	data = value
	for sink in sinks:
		sink.call(data)
	
func swap(f: Callable):
	data = f.call(data)
	for sink in sinks:
		sink.call(data)
	
static func derive(from: Atom, f: Callable):
	var d = Atom.new(f.call(from.data))
	from.bind(func(v): d.reset(f.call(v)))
	return d

static func compose(a: Atom, b: Atom, f: Callable):
	var d = Atom.new(f.call(a.data, b.data))
	a.bind(func(v): d.reset(f.call(v, b.data)))
	b.bind(func(v): d.reset(f.call(a.data, v)))
	return d

static func composeN(atoms: Array, f: Callable):
	var initial = f.call(atoms.map(func(a): return a.data))
	var d = Atom.new(initial)
	for a in atoms:
		a.bind(func(v): d.reset(f.call(atoms.map(func(a): return a.data))))
	return d

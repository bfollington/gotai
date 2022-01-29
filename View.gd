class_name View

static func showWhen(cond: bool, node: Node, container: Node):
	if node == null:
		return
		
	if cond:	
		if node.get_parent() == null:
			container.add_child(node)
	else:
		if node.get_parent() != null:
			container.remove_child(node)

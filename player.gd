extends Sprite2D
var img_width = 30
var img_height = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	var cally = Callable(self, "_on_viewport_size_changed")
	get_viewport().connect("size_changed", cally)
	_on_viewport_size_changed()
	DisplayServer.window_set_size(Vector2i(1000, 300) )

func _on_viewport_size_changed():
	var size = DisplayServer.window_get_size()
	self.position = size / 2
	
	var left = 200
	var right = 2000
	var up = 200
	var down = 2000
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(self.position + Vector2(0, 0), self.position + Vector2(0, 1000))
	var result = space_state.intersect_ray(query)
	if result:
		down = result.position.y*2 - img_height
	query = PhysicsRayQueryParameters2D.create(self.position + Vector2(0, 0), self.position + Vector2(1000, 0))
	result = space_state.intersect_ray(query)
	if result:
		right = result.position.x*2 - img_width
	query = PhysicsRayQueryParameters2D.create(self.position + Vector2(0, 0), self.position + Vector2(0, -1000))
	result = space_state.intersect_ray(query)
	if result:
		up = result.position.y*2 + img_height
	query = PhysicsRayQueryParameters2D.create(self.position + Vector2(0, 0), self.position + Vector2(-1000, 0))
	result = space_state.intersect_ray(query)
	if result:
		left = result.position.x*2 + img_width
	print([left,right,down,up])
	DisplayServer.window_set_min_size(Vector2i(left, up) )
	DisplayServer.window_set_max_size(Vector2i(right, down) )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

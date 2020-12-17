extends Node

onready var items = $order_items.get_children()

var order = null


func _ready() -> void:
	self.add_to_group( "order_area" )
	self.visible = false


func _process( delta ) -> void:
	if self.order:
		$waiting_progress.value = self.order.waiting_progress()


func fulfill_order( item: Resource ) -> void:
	self.order.fulfill_order( item )


func has_point( point: Vector2 ) -> bool:
	var rect = Rect2(
		self.rect_global_position,
		self.rect_size
	)
	return rect.has_point( point )


func is_waiting() -> bool:
	return self.order != null
	

func set_order( order = null ) -> void:
	self.order = order
	self.visible = !!order
	
	self.update_display()


func update_display() -> void:
	if !self.order:
		return
	
	for i in self.items.size():
		if i < self.order.size():
			self.items[ i ].texture = self.order.texture_at( i )
			self.items[ i ].visible = true
		else:
			self.items[ i ].visible = false
extends CPUParticles2D
var index_on_board = Vector2(0,0)

func _ready():
	emitting = true

func _process(delta):
	position = index_on_board * 64
	position.x += 32
	position.y += 32


func _on_Timer_timeout():
	queue_free()

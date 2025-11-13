extends ProgressBar

@onready var player = $"../../../Player"

func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	value = player.currentHealth / player.maxHealth

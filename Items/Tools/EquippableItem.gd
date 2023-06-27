extends Resource
 
class_name EquippableItem

@export var texture : Texture2D
@export var dispalyName : String

var player : Player
func _load_owner(owner: Player):
	player = owner

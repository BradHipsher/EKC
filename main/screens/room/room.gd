extends Node2D

const tilemapPF = preload("res://engine/objects/TileMap/TileMap.tscn")
const staticPF = preload("res://engine/objects/Statics/Static.tscn")
const shooterPF = preload("res://engine/objects/Shooter/Shooter.tscn")
#const stepperPF = preload("res://engine/objects/Stepper/Stepper.tscn")
const playerPF = preload("res://engine/objects/Player/Player.tscn")
const tintPF = preload("res://engine/objects/Pulsing_Tint/PulsingTint.tscn")


var sMap 
var shooterMap

var tileMap
var statics
var entities
#var stepper
var player
var tint

func init():
	var roomLayout = Global.rlMap[str(Global.rlMapIndex)].instance()
	sMap=roomLayout.get_node("patternStatic").get_used_cells()
	shooterMap=roomLayout.get_node("patternShooter").get_used_cells()

func _ready():
	tileMap = tilemapPF.instance()
	add_child(tileMap)
	
	statics = Node2D.new()
	add_child(statics)
	loadStatics()
	
	entities = Node2D.new()
	add_child(entities)
	loadEntities()
	
#	stepper = stepperPF.instance()
#	add_child(stepper)
	
	player = playerPF.instance()
	player.position = Vector2(9*64+32,6*64+32)
	add_child(player)
	
	tint = tintPF.instance()
	add_child(tint)
	
func loadStatics():
	for s in sMap:
		var i = staticPF.instance()
		i.position.x = s[0]*64 + 32
		i.position.y = s[1]*64 + 32
		statics.add_child(i)

func loadEntities():
	for s in shooterMap:
		var i = shooterPF.instance()
		i.position.x = s[0]*64 + 32
		i.position.y = s[1]*64 + 32
		entities.add_child(i)

func pulse(beat_send, time_send):
#	stepper.pulse(beat_send, time_send)
	tint.pulse()
	for s in get_tree().get_nodes_in_group("shooter"):
		s.pulse(beat_send, time_send)

func tick(beat_send, time_send):
#	stepper.tick(beat_send, time_send)
	for t in get_tree().get_nodes_in_group("tickable"):
		t.tick(beat_send, time_send)

func track_signal(song_name, mspb, off, sm):
	pass
#	stepper.set_song(song_name, mspb, off, sm)

func _on_bullet_collide(contacted):
	if contacted == player:
		print("ouch")


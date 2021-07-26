extends Node2D

const roomPF = preload("res://main/screens/Room/Room.tscn")

var sound 
var sound_direct = preload("res://engine/objects/OGGPlayer/OGGPlayer.tscn")

var song_name : String = "JazzLoop"

var room

func _ready():
	room = roomPF.instance()
	add_child(room)
	
	sound = sound_direct.instance()
	sound.init(song_name)
	sound.connect("pulse", self, "_on_OGGPlayer_pulse")
	sound.connect("tick",self, "_on_OGGPlayer_tick")
	sound.connect("track_info", self, "_on_OGGPlayer_track_signal")
	add_child(sound)
	print("sound.bpm: " + str(sound.bpm))

func nextRoom(dir):
	room.queue_free()
	room = roomPF.instance()
	add_child(room)
	if dir == "Left":
		room.player.position = Vector2(18*64+32, 6*64+32)
	if dir == "Right":
		room.player.position = Vector2(0*64+32, 6*64+32)
	if dir == "Down":
		room.player.position = Vector2(9*64+32, 0*64+32)
	if dir == "Up":
		room.player.position = Vector2(9*64+32, 12*64+32)
	room.player.tarPos = room.player.position

func _on_OGGPlayer_pulse(beat_send, time_send):
	room.pulse(beat_send, time_send)

func _on_OGGPlayer_tick(beat_send, time_send):
	room.tick(beat_send, time_send)

func _on_OGGPlayer_track_signal(song_name, mspb, off, sm):
	Global.mspb = mspb
	room.track_signal(song_name, mspb, off, sm)


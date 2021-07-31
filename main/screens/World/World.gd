extends Node2D

const roomPF = preload("res://main/screens/Room/Room.tscn")

var level_1
var level_2
var level_3
var level_4
var level_5
var sound_direct = preload("res://engine/objects/OGGPlayer/OGGPlayer.tscn")

var song_name : String = "level_1"

var level_name_map
var next_level_name_map = {
	"level_1" : "level_2",
	"level_2" : "level_3",
	"level_3" : "level_4",
	"level_4" : "level_5",
}

var curr_level_name

var key_change = false

var room

func _ready():
	Global.key_change = 0
	
	room = roomPF.instance()
	room.init()
	add_child(room)
	
	level_1 = sound_direct.instance()
	level_1.init("level_1")
	level_1.connect("pulse", self, "_on_OGGPlayer_pulse")
	level_1.connect("tick",self, "_on_OGGPlayer_tick")
	level_1.connect("track_info", self, "_on_OGGPlayer_track_signal")
	add_child(level_1)
	level_1.play_sound()
	curr_level_name = "level_1"
	print("sound.bpm: " + str(level_1.bpm))
	
	level_2 = sound_direct.instance()
	level_3 = sound_direct.instance()	
	level_4 = sound_direct.instance()
	level_5 = sound_direct.instance()
	
	level_name_map = {
		"level_1" : level_1,
		"level_2" : level_2,
		"level_3" : level_3,
		"level_4" : level_4,
		"level_5" : level_5,
	}


func nextRoom(dir):
	var roomVec
	if dir == "Left": roomVec = Vector2.LEFT
	if dir == "Right": roomVec = Vector2.RIGHT
	if dir == "Down": roomVec = Vector2.DOWN
	if dir == "Up": roomVec = Vector2.UP
	Global.rlMapIndex = Global.rlMapIndex + roomVec
	
	room.queue_free()
	room = roomPF.instance()
	room.init()
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

func key_change():
	Global.key_change = min(Global.key_change + 1, Global.key_change_tint.size() - 1)
	
	var level = level_name_map[curr_level_name]
	var progress = level.get_playback_position()
	#id new level
	var new_level = level_name_map[next_level_name_map[curr_level_name]]
	#stop playing level
	level.stop()
	#start playing new level
	new_level.init(
		next_level_name_map[curr_level_name],
		progress * Global.music_preloads[curr_level_name]["bpm"] / Global.music_preloads[next_level_name_map[curr_level_name]]["bpm"] 
	)
	new_level.connect("pulse", self, "_on_OGGPlayer_pulse")
	new_level.connect("tick",self, "_on_OGGPlayer_tick")
	new_level.connect("track_info", self, "_on_OGGPlayer_track_signal")
	add_child(new_level)
	new_level.play_sound()
	#kill level
	#level.queue_free()
	#assign curr_level_name to new level name
	curr_level_name = next_level_name_map[curr_level_name]

func _on_OGGPlayer_pulse(beat_send, time_send):
	room.pulse(beat_send, time_send)
	print(str([beat_send,time_send]))
	if (key_change):
		key_change()
		key_change = false

func _on_OGGPlayer_tick(beat_send, time_send):
	room.tick(beat_send, time_send)

func _on_OGGPlayer_track_signal(song_name, mspb, off, sm):
	Global.mspb = mspb
	room.track_signal(song_name, mspb, off, sm)

func _unhandled_key_input(event):
	if event.is_action_pressed("dev1"):
		key_change = true


func _on_exitToMenu_pressed():
	Global.change_screen_immediate("Menu")

extends Node

## Room Layout Preloads
var rlDefault = preload("res://main/RoomLayouts/rlDefault.tscn")
var rlDKeyRoom = preload("res://main/RoomLayouts/rlDKeyRoom.tscn")
var rlDRCorner = preload("res://main/RoomLayouts/rlDRCorner.tscn")
var rlEnter = preload("res://main/RoomLayouts/rlEnter.tscn")
var rlExit = preload("res://main/RoomLayouts/rlExit.tscn")
var rlKnight = preload("res://main/RoomLayouts/rlKnight.tscn")
var rlLDCorner = preload("res://main/RoomLayouts/rlLDCorner.tscn")
var rlLFunnel = preload("res://main/RoomLayouts/rlLFunnel.tscn")
var rlLKeyRoom = preload("res://main/RoomLayouts/rlLKeyRoom.tscn")
var rlLRGauntlet = preload("res://main/RoomLayouts/rlLRGauntlet.tscn")
var rlLRZigZag = preload("res://main/RoomLayouts/rlLRZigZag.tscn")
var rlLTCorner = preload("res://main/RoomLayouts/rlLTCorner.tscn")
var rlRFunnel = preload("res://main/RoomLayouts/rlRFunnel.tscn")
var rlRKeyRoom = preload("res://main/RoomLayouts/rlRKeyRoom.tscn")
var rlTDGauntlet = preload("res://main/RoomLayouts/rlTDGauntlet.tscn")
var rlTDZigZag = preload("res://main/RoomLayouts/rlTDZigZag.tscn")
var rlTKeyRoom = preload("res://main/RoomLayouts/rlTKeyRoom.tscn")
var rlTRCorner = preload("res://main/RoomLayouts/rlTRCorner.tscn")

var rlMapIndex : Vector2 = Vector2(0,0)

var rlMap = {
	'(0, 0)' : rlEnter,
	"(0, 1)" : rlTRCorner,
	"(0, 2)" : rlRKeyRoom,
	"(1, 1)" : rlLRGauntlet,
	"(1, 2)" : rlLRZigZag,
	"(2, 1)" : rlLDCorner,
	"(2, 2)" : rlDefault,
	"(2, 3)" : rlRFunnel,
	"(2, 4)" : rlExit,
	"(3, 0)" : rlDRCorner,
	"(3, 1)" : rlTDZigZag,
	"(3, 2)" : rlLFunnel,
	"(3, 3)" : rlKnight,
	"(3, 4)" : rlTDGauntlet,
	"(3, 5)" : rlTKeyRoom,
	"(4, 0)" : rlLKeyRoom,
	"(4, 2)" : rlDKeyRoom,
	"(4, 3)" : rlLTCorner
	
	
}

## Music Preloads
var music_preloads = {
	
	"JazzLoop" : {
		"file" : load(add_mus_pth("JazzLoop")),
		"bpm" : 112.0,
		"offset" : 0.00,
		#"offset" : 0.22,
		"step_map" : {}
	},
	
	"level_1" : {
		"file" : load(add_mus_pth("level_1")),
		"bpm" : 100.0,
		"offset" : 0.1,
		#"offset" : 0.22,
		"step_map" : {}
	},
	
	"level_2" : {
		"file" : load(add_mus_pth("level_2")),
		"bpm" : 120.0,
		"offset" : 0.0,
		#"offset" : 0.22,
		"step_map" : {}
	},
	
	"level_3" : {
		"file" : load(add_mus_pth("level_3")),
		"bpm" : 140.0,
		"offset" : 0.0,
		#"offset" : 0.22,
		"step_map" : {}
	},
	
	"level_4" : {
		"file" : load(add_mus_pth("level_4")),
		"bpm" : 160.0,
		"offset" : 0.0,
		#"offset" : 0.22,
		"step_map" : {}
	},
	
	"level_5" : {
		"file" : load(add_mus_pth("level_5")),
		"bpm" : 180.0,
		"offset" : 0.0,
		#"offset" : 0.22,
		"step_map" : {}
	},
}

var mspb

## Key Change
var key_change = 0

var key_change_tint = [
	"13000aff",
	"1300ffc3",
	"13e5ff00",
	"13ff9500",
	"13ff0000"
]

## Functionality
func change_screen(scn, delay = 1.5):
	var sd = load(add_obj_pth("Sound_Direct")).instance()
	add_child(sd)
	var sfx = load(add_sfx_pth("seventh"))
	sd.play_sound(sfx)
	yield(get_tree().create_timer(delay), "timeout")
	sd.queue_free()
	change_screen_immediate(scn)

func change_screen_immediate(scn):
	get_tree().change_scene(add_scn_pth(scn))

## I/O
func add_obj_pth(obj):
	return "res://engine/objects/"+obj+"/"+obj+".tscn"

func add_sfx_pth(sfx):
	return "res://engine/sfx/"+sfx+".ogg"

func add_scn_pth(scn) :
	return "res://main/screens/"+scn+"/"+scn+".tscn"

func add_mus_pth(mus):
	return "res://main/music/"+mus+"/"+mus+".mp3"

func add_mus_dat_pth(dat):
	return "res://main/music/"+dat+"/"+dat+".dat"

#func save_cali(song_nm : String, linest : Vector2):
#	var file = File.new()
#	file.open("res://main/music/"+song_nm+"/"+song_nm+".dat", File.WRITE)
#	file.store_string(var2str(linest))
#	file.close()
#
func load_mus_dat(dat : String):
	var file = File.new()
	file.open(add_mus_dat_pth(dat), File.READ)
	var content = {}
	for i in file.get_as_text().count(":"):
		var line = file.get_line()
		var key = float(line.split(":")[0])
		var value = int(line.split(":")[1])
#		if value.is_valid_integer():
#			value = int(value)
#		elif value.is_valid_float():
#			value = float(value)
#		elif value.begins_with("["):
#			value = value.trim_prefix("[")
#			value = value.trim_suffix("]")
#			value = value.split(",")
		content[key] = value
	file.close()
	print(content)
	return content

## STEPS
func step_time_to_pos(time : float, pxps_speed : float, y_target : float) -> float:
	return (y_target + (pxps_speed * time))

func steps_time_to_pos(times : Array, pxps_speed : float, y_target : float) -> Array:
	var poses : Array = []
	for time in times:
		poses.append(step_time_to_pos(time, pxps_speed, y_target))
	return poses

func split_steps(beats):
	var dict = { 1 : null, 2 : null, 3 : null, 4 : null}
	for dir in dict.keys():
		var beat_nums : Array = []
		for beat in beats.keys():
			if str(dir) in str(beats[beat]):
				beat_nums.append(beat)
		dict[dir] = beat_nums
	return dict

## MATHS
func range0(s : int):
	return range(s).pop_back()

func sum(arr : Array):
	var sum : float = 0.0
	for e in arr:
		sum += e
	return sum

func avg(arr : Array):
	return sum(arr) / arr.size()
	
func sumprod(arr0 : Array, arr1 : Array):
	var arr : Array = []
	var sumprod : float = 0.0
	if arr0.size() == arr1.size():
		for i in range(arr0.size()):
			arr.append(arr0[i]*arr1[i])
		sumprod = sum(arr)
	return sumprod 

func addscalar(arr0 : Array, scalar : float):
	var arr : Array = []
	for e in arr0:
		arr.append(e+scalar)
	return arr

func linest(ys : Array):
	var xs : Array = range(ys.size())
	
	var xbar : float = avg(xs)
	var ybar : float = avg(ys)
	
	var xdif : Array = addscalar(xs, -xbar)
	var ydif : Array = addscalar(ys, -ybar)
	
	var numer : float = sumprod(xdif, ydif) 
	var denom : float = sumprod(xdif, xdif)
	
	var m : float = numer / denom
	var b : float = ybar - (m * xbar)
	
	var b0 : float = b
	while (abs(b0) > abs(b0-m)):
		b0 -= m
	
	return Vector2(m, b0)

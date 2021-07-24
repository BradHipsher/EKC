extends Area2D

const bulletPF = preload("res://engine/objects/Bullet/Bullet.tscn")

func pulse(beat, time):
	if beat % 4 == 1:
		spawnBullet(Vector2(0,1),time)
	if beat % 4 == 2:
		spawnBullet(Vector2(-1,0),time)
	if beat % 4 == 3:
		spawnBullet(Vector2(0,-1),time)
	if beat % 4 == 0:
		spawnBullet(Vector2(1,0),time)

func spawnBullet(dir,time):
	var bullet = bulletPF.instance()
	bullet.position = position
	get_parent().add_child(bullet)
	bullet.connect("area_entered",get_parent().get_parent(),"_on_bullet_collide")
	bullet.startTime = time
	bullet.dir = dir

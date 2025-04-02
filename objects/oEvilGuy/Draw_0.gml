draw_self();

//gun

var _yscale = 1;
if oPlayer.x < x
_yscale = -1; 

aim_dir = point_direction(x, y, oPlayer.x, oPlayer.y);
draw_sprite_ext(sEvilGun, 0, x + lengthdir_x(8, aim_dir), y + lengthdir_y(8, aim_dir), 1, _yscale, aim_dir, c_white, 1); 

shoot += 1;
if shoot >= fire_rate and !collision_line(x, y, oPlayer.x, oPlayer.y, oWall, false, true) {
	
	with instance_create_depth(x + lengthdir_x(8, aim_dir), y + lengthdir_y(8, aim_dir), depth+1, oEvilBullet) {
		direction = other.aim_dir;
		speed = other.shot_speed;
	}
	
	shoot = 0;
	
}

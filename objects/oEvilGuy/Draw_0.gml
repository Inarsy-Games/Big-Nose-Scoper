//draw self duh
draw_self();

//face player
if oPlayer.x < x
image_xscale = -1;
else
image_xscale = 1;

//gun
var _yscale = 1;
if oPlayer.x < x
_yscale = -1; 

var _has_los = !collision_line(x, y, oPlayer.x, oPlayer.y, oWall, false, true);

if _has_los {
	var _target = point_direction(x, y, oPlayer.x, oPlayer.y);
	var _diff = angle_difference(aim_dir, _target+180);
	aim_dir += clamp(_diff, -aim_spd, aim_spd);
}

draw_sprite_ext(sEvilGun, 0, x + lengthdir_x(8, aim_dir), y + lengthdir_y(8, aim_dir), 1, _yscale, aim_dir, c_white, 1); 

shoot += 1*game_speed;
if shoot >= fire_rate and _has_los {
	
	with instance_create_depth(x + lengthdir_x(8, aim_dir), y + lengthdir_y(8, aim_dir), depth+1, oEvilBullet) {
		direction = other.aim_dir;
		shot_speed = other.shot_speed;
	}
	
	shoot = 0;
	
}

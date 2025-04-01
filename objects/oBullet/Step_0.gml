speed = 5*game_speed;
image_angle = direction;

if bounces > 0 {
	if position_meeting(x+hspeed, y, oWall) {
		hspeed *= -1;
		bounces -= 1;
	}
	if position_meeting(x, y+vspeed, oWall) {
		vspeed *= -1;
		bounces -= 1;
	}
}
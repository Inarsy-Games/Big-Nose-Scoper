if position_meeting(mouse_x, mouse_y, id) {
	with oGuySniper {
	
	var _target = point_direction(x, y, other.x, other.y)+170;
	image_angle = approach(image_angle, _target, 5);
	
	}
}
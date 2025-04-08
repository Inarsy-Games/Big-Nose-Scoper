if !instance_exists(oEvilGuy) {
	image_angle += rot_spd;
	image_alpha = 1;
	
	if place_meeting(x, y, oPlayer) {
		if room == room_last
		room_goto(main_menu);
		else
		room_goto_next();
	}
	
}
else {

	image_alpha = 0.25;	
	
}
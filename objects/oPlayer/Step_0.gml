//inputs
right = gamepad_axis_value(0, gp_axislh) > 0 or keyboard_check(vk_right) or keyboard_check(ord("D"));
left = gamepad_axis_value(0, gp_axislh) < 0 or keyboard_check(vk_left) or keyboard_check(ord("A"));
jump_held = gamepad_button_check(0, gp_face1) or keyboard_check(vk_up) or keyboard_check(vk_space);
jump_pressed = gamepad_button_check_pressed(0, gp_face1) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(vk_space);
slowmo_held = keyboard_check(ord("Z")) or gamepad_button_check(0, gp_shoulderlb) or mouse_check_button(mb_right);
shoot = keyboard_check_pressed(ord("X")) or gamepad_button_check_pressed(0, gp_shoulderrb) or mouse_check_button_pressed(mb_left);
special_shoot = keyboard_check_pressed(ord("C")) or gamepad_button_check_pressed(0, gp_shoulderr);

hdir = right-left;

if hdir != 0
spin_dir = hdir;

//slowmo stuff
if slowmo_held and slowmo > 0 {
	
	slowmo = approach(slowmo, 0, slowmo_usage);
	
	spin_spd = slowmo_spin_spd;
	game_speed = 0.1;
}
else {
	
	slowmo = approach(slowmo, max_slowmo, slowmo_rate);
	
	spin_spd = normal_spin_spd;
	game_speed = 1;
}

//move
hsp = approach(hsp, hdir*walk_spd, acc*game_speed);

//gravity
if vsp < max_vsp
vsp += grv*game_speed;

//spin and shiiii
if !place_meeting(x, y+1, oWall) {
	draw_angle += spin_spd*-hdir*game_speed;
}
else if draw_angle != 0 {
	
	if draw_angle > 180 {
		draw_angle = approach(draw_angle, 360, spin_spd*game_speed);
		
		if draw_angle == 360
		draw_angle = 0;
	}
	else
	draw_angle = approach(draw_angle, 0, spin_spd*game_speed);
	
}

//keep angle between 0 and 360
if draw_angle < 0
draw_angle = 360;
if draw_angle > 360
draw_angle = 0;

//jump
grounded -= 1*game_speed;
walled -= 1*game_speed;
jump -= 1*game_speed;

if place_meeting(x, y+1, oWall) 
grounded = coyote_buffer;
if jump_pressed
jump = jump_buffer;

if grounded > 0 and jump > 0 {
	vsp = jump_force;
	grounded = 0;
	jump = 0;
	jumped = true;
	
} 
else if walled > 0 and jump > 0 and grounded <= 0 {
	vsp = jump_force;
	
	var _jumpdir = place_meeting(x+1, y, oWall)-place_meeting(x-1, y, oWall);
	
	hsp = jump_force*_jumpdir;
	walled = 0;
	grounded = 0;
	jump = 0;
}

if !jump_held and jumped and vsp < 0 
vsp *= varjumpmod;

if vsp > 0
jumped = false;

//shooting
can_shoot -= 1*game_speed;
if shoot and can_shoot <= 0 {
	
	var _angle = draw_angle;
	if image_xscale == -1
	_angle += 180;
	with instance_create_depth(x+lengthdir_x(sprite_get_width(sSniper)/2, _angle), y+lengthdir_y(sprite_get_width(sSniper)/2, _angle), depth+1, oBullet) { 
		direction = _angle;
		image_angle = _angle;
	}
	
	can_shoot = fire_rate;
	
	//set shot flash duration
	if game_speed == 1
	shot_flash = sprite_get_number(sShotFlashFast);
	else
	shot_flash = sprite_get_number(sShotFlashSlow);

}

if special_shoot and special == "ricoshot" and special_ammo > 0 {
	
	var _offset = 0;
	if image_xscale == -1
	_offset = 180;
	with instance_create_depth(x, y, depth+1, oBullet) { 
		direction = other.draw_angle+_offset;
		image_angle = other.draw_angle+_offset;
		
		bounces = 1;
	}
	
	special_ammo -= 1;
	can_shoot = fire_rate;
	 
	if special_ammo <= 0
	special = "poopy doopy doesnt matter";
}

//collision
if place_meeting(x+hsp, y, oWall) {
	while !place_meeting(x+sign(hsp), y, oWall) {
		x += sign(hsp);	
	}
	hsp = 0;
}
x += hsp*game_speed;

if game_speed == 1
x = round(x);

//wall jump junk
if place_meeting(x+1, y, oWall) or place_meeting(x-1, y, oWall)
walled = coyote_buffer;

if place_meeting(x, y+vsp, oWall) {
	while !place_meeting(x, y+sign(vsp), oWall) {
		y += sign(vsp);	
	}
	vsp = 0;
}
y += vsp*game_speed;

if game_speed == 1
y = round(y);

//perish
if hp <= 0
instance_destroy(id);

//animations
if hsp != 0 and place_meeting(x, y+1, oWall) and draw_angle == 0 {
	image_xscale = sign(hsp);
	image_speed = 1*game_speed;
}
else {
	image_speed = 0;
	image_index = 0;
}
//inputs
right = gamepad_axis_value(0, gp_axislh) > 0 or keyboard_check(vk_right);
left = gamepad_axis_value(0, gp_axislh) < 0 or keyboard_check(vk_left);
jump_held = gamepad_button_check(0, gp_face1) or keyboard_check(ord("Z"));
jump_pressed = gamepad_button_check_pressed(0, gp_face1) or keyboard_check_pressed(ord("Z"));
slowmo = keyboard_check(ord("X")) or gamepad_button_check(0, gp_shoulderlb);
charge_shot = keyboard_check(ord("C")) or gamepad_button_check(0, gp_shoulderrb);
shoot = keyboard_check_released(ord("C")) or gamepad_button_check_released(0, gp_shoulderrb);


hdir = right-left;

if hdir != 0
spin_dir = hdir;

//slowmo stuff
if slowmo
game_speed = 0.1;
else
game_speed = 1;

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
else if walled > 0 and jump > 0 {
	vsp = jump_force;
	
	var _jumpdir = place_meeting(x+1, y, oWall)-place_meeting(x-1, y, oWall);
	
	hsp = jump_force*_jumpdir;
	walled = 0;
	jump = 0;
}

if !jump_held and jumped and vsp < 0 
vsp *= varjumpmod;

if vsp > 0
jumped = false;

//shooting

if charge_shot and charge < 100
charge += charge_rate*game_speed;
else if charge > 0
charge -= charge_rate*game_speed;

if shoot and charge > 0 {
	
	var _offset = 0;
	if image_xscale == -1
	_offset = 180;
	with instance_create_depth(x, y, depth+1, oBullet) { 
		direction = other.draw_angle+_offset;
		image_angle = other.draw_angle+_offset;
	}
	
	if charge >= 1 {
		hsp = lengthdir_x(blast_force, draw_angle+180+_offset);
		vsp = lengthdir_y(blast_force, draw_angle+180+_offset);
		jumped = false;
	}
	
	
	charge = 0;
}

//collision
if place_meeting(x+hsp, y, oWall) {
	while !place_meeting(x+sign(hsp), y, oWall) {
		x += sign(hsp);	
	}
	hsp = 0;
	
	//wall jump junk
	walled = coyote_buffer;
}
x += hsp*game_speed;

if game_speed == 1
x = round(x);

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
//inputs
right = gamepad_axis_value(0, gp_axislh) > 0 or keyboard_check(vk_right);
left = gamepad_axis_value(0, gp_axislh) < 0 or keyboard_check(vk_left);
jump_held = gamepad_button_check(0, gp_face1) or keyboard_check(vk_space);
jump_pressed = gamepad_button_check_pressed(0, gp_face1) or keyboard_check_pressed(vk_space);

hdir = right-left;


//move
hsp = approach(hsp, hdir*walk_spd, acc);

//gravity
if vsp < max_vsp
vsp += grv;

//spin and shiiii
if !place_meeting(x, y+1, oWall) {
	draw_angle += spin_spd*-image_xscale;
	
	if draw_angle < 0
	draw_angle = 360;
	if draw_angle > 360
	draw_angle = 0;
	
}
else
draw_angle = approach(draw_angle, 0, spin_spd);

//jump
grounded -= 1;
jump -= 1;

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

if !jump_held and jumped and vsp < 0 
vsp *= varjumpmod;

if vsp > 0
jumped = false;

//collision
if place_meeting(x+hsp, y, oWall) {
	while !place_meeting(x+sign(hsp), y, oWall) {
		x += sign(hsp);	
	}
	hsp = 0;
}
x += hsp;
x = round(x);

if place_meeting(x, y+vsp, oWall) {
	while !place_meeting(x, y+sign(vsp), oWall) {
		y += sign(vsp);	
	}
	vsp = 0;
}
y += vsp;
y = round(y);

//perish
if hp <= 0
instance_destroy(id);

//animations
if hsp != 0 {
	image_xscale = sign(hsp);
	image_speed = 1;
}
else {
	image_speed = 0;
	image_index = 0;
}
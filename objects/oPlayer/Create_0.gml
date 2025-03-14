//make a platformer character speedrun world record

//inputs
hdir = 0;
vdir = 0;
jump_held = 0;
jump_pressed = 0;

//movement
hsp = 0;
vsp = 0;
walk_spd = 2.5;
acc = 0.2;
jump_force = -3;
grv = 0.2;
max_vsp = 6;
varjumpmod = 0.7;
jump = 0;
grounded = 0;
walled = 0;
coyote_buffer = 7;
jump_buffer = 8;
jumped = false;

//shooting
spin_spd = 10;
draw_angle = 0;
charge = 0;
charge_rate = 1/75;
charge_spin = 0;

//health-
hp = 10;
hit_flash = 0;

gamepad_set_axis_deadzone(0, 0.5);
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
slowmo_spin_spd = 7; //this is still effected by game_speed, its just so you can be more precise
normal_spin_spd = 8.5;
spin_spd = normal_spin_spd;

draw_angle = 0;

can_shoot = 0;
fire_rate = 15;

special = "none";
special_ammo = 0;

//shotflash
shotFlash = 0;

//health-
hp = 10;
hit_flash = 0;

gamepad_set_axis_deadzone(0, 0.5);
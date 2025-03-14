//laser
var _offset = 0;
if image_xscale == -1
_offset = 180;

var _index = 0;
while !position_meeting(x+lengthdir_x(_index, draw_angle+_offset), y+lengthdir_y(_index, draw_angle+_offset), oWall) {
	_index += 1;		
}

var _col = c_red;
draw_line_colour(x, y, x+lengthdir_x(_index, draw_angle+_offset), y+lengthdir_y(_index, draw_angle+_offset), _col, _col);

//player
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, draw_angle, image_blend, image_alpha);

//sniper
draw_sprite_ext(sSniper, image_index, x, y, image_xscale, image_yscale, draw_angle, image_blend, image_alpha); 

if charge > 0 {
	
	var _index = 0;
	
	if charge >= 1
	_index = 2;
	else if charge > 0.5
	_index = 1;
	
	charge_spin += charge*15*game_speed;
	
	draw_sprite_ext(sCharge, _index, x+lengthdir_x(sprite_get_width(sSniper)/2, draw_angle+_offset), y+lengthdir_y(sprite_get_width(sSniper)/2, draw_angle+_offset), image_xscale, image_yscale, charge_spin, image_blend, image_alpha); 
}
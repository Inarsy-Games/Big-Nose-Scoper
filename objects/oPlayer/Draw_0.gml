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
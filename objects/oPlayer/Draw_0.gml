var _offset = 0;
if image_xscale == -1
_offset = 180;

var _start = draw_laser(x, y, draw_angle+_offset, c_red, 1);

if special == "ricoshot" {
    // Calculate the proper bounce angle
    var _hit_x = _start[0];
    var _hit_y = _start[1];

    // Check collision at the bounce point
    var _normal_x = 0;
    var _normal_y = 0;

    if position_meeting(_hit_x + 1, _hit_y, oWall) or position_meeting(_hit_x - 1, _hit_y, oWall) {
        _normal_x = 1; // Vertical wall normal
    }
    if position_meeting(_hit_x, _hit_y + 1, oWall) or position_meeting(_hit_x, _hit_y - 1, oWall) {
        _normal_y = 1; // Horizontal wall normal
    }

    // If it hit a vertical wall, invert horizontal direction
    var _bounce_angle = draw_angle + _offset;
    if _normal_x == 1 {
        _bounce_angle = 180 - _bounce_angle;
    }
    // If it hit a horizontal wall, invert vertical direction
    else if _normal_y == 1 {
        _bounce_angle = -_bounce_angle;
    }

    // Draw the bounced laser with the correct angle
    draw_laser(_hit_x, _hit_y, _bounce_angle, c_red, 0.5);
}


//player
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, draw_angle, image_blend, image_alpha);

//slowmo bar
if slowmo < max_slowmo
draw_sprite_ext(sSlowmoBar, 0, x, bbox_top-1, slowmo/8, 1, 0, c_white, 1);

//sniper
draw_sprite_ext(sSniper, image_index, x, y, image_xscale, image_yscale, draw_angle, image_blend, image_alpha); 

//shot flash
if shot_flash >= 0 {
	
	var _angle = draw_angle;
	if image_xscale == -1
	_angle += 180;
	
	var _sprite = sShotFlashSlow;
	if game_speed == 1
	_sprite = sShotFlashFast;
	
	draw_sprite_ext(_sprite, shot_flash, x+lengthdir_x(sprite_get_width(sSniper)/2, _angle), y+lengthdir_y(sprite_get_width(sSniper)/2, _angle), 1, 1, _angle, c_white, 1);	
	shot_flash -= shot_flash_spd*game_speed;
}
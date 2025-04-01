
//draws a line that stops when hitting a collision
function draw_laser(_startx, _starty, _angle, _colour, _alpha) {
	
	var _index = 0;
	while !position_meeting(_startx+lengthdir_x(_index, _angle), _starty+lengthdir_y(_index, _angle), oWall) and _index < oCamera.view_width {
		_index += 1;		
	}
	
	draw_set_alpha(_alpha);
	draw_line_colour(_startx, _starty, _startx+lengthdir_x(_index, _angle), _starty+lengthdir_y(_index, _angle), _colour, _colour);
	draw_set_alpha(1);
	
	var _end_point = [_startx+lengthdir_x(_index-1, _angle), y+lengthdir_y(_index-1, _angle)];
	return _end_point;
	
}
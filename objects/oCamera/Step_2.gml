/// @desc
#macro view view_camera[0]
camera_set_view_size(view, view_width, view_height);

var _x = clamp(target.x-view_width/2, 0, room_width-view_width);
var _y = clamp(target.y-view_height/2, 0, room_height-view_height);
camera_set_view_pos(view, _x, _y);
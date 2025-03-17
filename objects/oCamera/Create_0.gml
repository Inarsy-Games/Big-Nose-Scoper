/// @desc
view_width = 256;
view_height = 144;
globalvar window_scale; window_scale = 1;

target = oPlayer;

window_set_size(view_width*window_scale, view_height*window_scale);
alarm[0] = 1;

surface_resize(application_surface, view_width*window_scale, view_height*window_scale);
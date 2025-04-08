draw_set_halign(fa_center);
draw_set_font(fScramble);
draw_text(x, y, "Space to start");

if keyboard_check_pressed(vk_space)
room_goto_next();
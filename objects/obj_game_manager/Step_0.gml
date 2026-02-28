global.DELTA_TIME = delta_time/16666

global.ACCEPT_KEY = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("Z"));
global.BACK_KEY = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("X"));
global.MENU_KEY = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(ord("C"));
global.UP_KEY = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
global.DOWN_KEY = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
global.LEFT_KEY = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
global.RIGHT_KEY = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));

global.ACCEPT_KEY_HOLD = keyboard_check(vk_enter) or keyboard_check(ord("Z"));
global.BACK_KEY_HOLD = keyboard_check(vk_shift) or keyboard_check(ord("X"));
global.MENU_KEY_HOLD = keyboard_check(vk_escape) or keyboard_check(ord("C"));
global.UP_KEY_HOLD = keyboard_check(vk_up) or keyboard_check(ord("W"));
global.DOWN_KEY_HOLD = keyboard_check(vk_down) or keyboard_check(ord("S"));
global.LEFT_KEY_HOLD = keyboard_check(vk_left) or keyboard_check(ord("A"));
global.RIGHT_KEY_HOLD = keyboard_check(vk_right) or keyboard_check(ord("D"));

if (keyboard_check_pressed(vk_f11)){
	window_set_fullscreen(true);
}

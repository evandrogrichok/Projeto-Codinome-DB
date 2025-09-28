var inventory_length = array_length(inventory);
var cam_x = obj_camera.x;
var cam_y = obj_camera.y;
var padding = 0


for (var i = 0; i < inventory_length; i++){
	draw_sprite_stretched(asset_get_index(global.ITEMS_DATA.item_001.sprite), 0, cam_x- 50 + padding, cam_y+50, 16, 16);
	draw_text_transformed(cam_x - 50 + padding, cam_y+50 + 20,string(global.ITEMS_DATA.item_001.name),0.5,0.5,1);
	padding += 16;
}
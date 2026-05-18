enum WAITING_TYPES{
	frames,
	textbox,
	page,
	animation,
	moving
}


var data = load_json_file("cutscenes.json");
cutscene_id = "cutscene_01";
cutscene = data[$ cutscene_id];

index = 0;
waiting = false;
wait_timer = 0;
current_wait_type = undefined;
object = undefined;

last_textbox_page = undefined;

global.cutscene_active = true; //se há uma cutscene acontecendo/nao está em estado de espera

function start_cutscene(_data) {
    cutscene = _data;
    index = 0;
    active = true;
}

function set_waiting_event(_type){
	waiting = true;
	current_wait_type = _type;
}
function reset_waiting_event(){
	waiting = false;
	current_wait_type = undefined;
}
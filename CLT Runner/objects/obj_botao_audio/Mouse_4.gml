if(global.audio_on) {
	audio_pause_all();
	global.audio_on = false;
	image_index = 1;
	exit;
}
audio_resume_all();
global.audio_on = true;
image_index = 0;
if(image_index == 3) {
	room_goto(rm_jogo);
	return;
}
image_index++;

//Após passar uma página, terá que esperar um tempo
//para passar de novo
alarm[0] = 90;
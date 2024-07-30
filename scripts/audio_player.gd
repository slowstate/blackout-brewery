extends AudioStreamPlayer

const title_music =preload("res://assets/music/BB_titlev1_OwenGrey.wav")
const shop_music = preload("res://assets/music/BB_gameplayv1_OwenGrey.wav")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level(audio):
	_play_music(audio)
		

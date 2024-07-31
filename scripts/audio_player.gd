extends AudioStreamPlayer

const title_music =preload("res://assets/music/BB_titlev1_OwenGrey.wav")
const shop_music = preload("res://assets/music/BB_gameplayv1_OwenGrey.wav")
const door_fx = preload("res://assets/music/squeaky.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level(audio):
	_play_music(audio)

func play_FX(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()

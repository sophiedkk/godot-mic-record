extends Control

enum MixRates {MIN=11025, LOW=16000, MEDIUM=22050, HIGH=32000, VERY_HIGH=44100, MAX=48000}

@export var stereo := true
@export var mix_rate := MixRates.VERY_HIGH  # This is the default mix rate on recordings
@export var format := AudioStreamWAV.FORMAT_16_BITS  # This equals to the default format: 16 bits

var effect: AudioEffectRecord  # See AudioEffect in docs
var recording: AudioStreamWAV  # See AudioStreamSample in docs

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var record_button: Button = $RecordButton


func _ready():
	effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)


func _on_record_button_down():
	effect.set_recording_active(true)
	record_button.text = "Stop"


func _on_record_button_up():
	recording = effect.get_recording()
	effect.set_recording_active(false)
	recording.set_mix_rate(mix_rate)
	recording.set_format(format)
	recording.set_stereo(stereo)
	record_button.text = "Record"

	audio_stream_player.stream = recording
	audio_stream_player.play()

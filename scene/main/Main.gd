extends Node

var _share_singleton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AdMob.load_rewarded_video()

	if Engine.has_singleton("GodotShare"):
		_share_singleton = Engine.get_singleton("GodotShare")


func _on_ShareButton_pressed() -> void:
	var _img_path = OS.get_user_data_dir() + "/tmp.png"
	get_viewport().get_texture().get_data().save_png(_img_path)
	_share_singleton.sharePic(_img_path, "title", "subject", "sharing viewport")


func _on_WatchAdButton_pressed() -> void:
	$AdMob.show_rewarded_video()
	$VBoxContainer/WatchAdButton.disabled = false
	$AdMob.load_rewarded_video()


func _on_AdMob_rewarded_video_loaded() -> void:
	$VBoxContainer/WatchAdButton.disabled = false


func _on_AdMob_rewarded(a_currency: String, a_amount: int) -> void:
	$VBoxContainer/OutputLabel.text += "  rewarded %d %s" % [a_amount, a_currency]

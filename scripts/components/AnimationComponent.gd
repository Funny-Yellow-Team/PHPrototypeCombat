extends AnimationPlayer
class_name AnimationComponent

func play_death_animation():
	play("CharacterAnimLib/DeathAnim")

func play_revive_animation():
	play_backwards("CharacterAnimLib/DeathAnim")

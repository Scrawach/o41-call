class_name PlayerIdleState
extends State

@export var interact_state: PlayerInteractState

func enter() -> void:
	switch_to(interact_state)

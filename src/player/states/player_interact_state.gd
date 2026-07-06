class_name PlayerInteractState
extends State

@export var player_camera: Camera3D
@export var interactor: MouseInteractor
@export var idle_state: PlayerIdleState

var device_state: InteractionState

func state_handle_input(event: InputEvent) -> void:
	if device_state and device_state.is_busy():
		return
	
	if event.is_action_pressed("back") and device_state:
		_on_end_device_state(device_state)

func is_busy() -> bool:
	return device_state and device_state.is_busy()

func enter() -> void:
	interactor.clicked.connect(_on_area_clicked)

func exit() -> void:
	interactor.clicked.disconnect(_on_area_clicked)

func _on_area_clicked(area: InteractionArea3D) -> void:
	var state := area.get_interaction_state()
	if not state:
		return
	_on_start_device_state(state)

func _on_start_device_state(state: State) -> void:
	if device_state:
		_on_end_device_state(device_state)
	
	device_state = state
	device_state.main_camera = player_camera
	device_state.enter()

func _on_end_device_state(state: State) -> void:
	state.exit()
	device_state = null

class_name CharacterResource
extends Resource

signal status_changed(old_status: CharacterStatus, new_status: CharacterStatus)

enum CharacterStatus {
	UNKNOWN = 0,
	IDLE = 1,
	BUSY = 2
}

@export var id: String
@export var name: String
@export var portrait: Texture2D
@export var status: CharacterStatus

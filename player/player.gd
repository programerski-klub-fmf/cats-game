class_name Player
extends CharacterBody3D


@export var walk_speed = 5.0
@export var run_speed = 20.0
@export var jump_velocity = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


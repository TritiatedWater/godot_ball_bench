"""
Copyright 2018 Supatier
  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/."""
extends Node

var fps_label = null
var time_start = 0
var time_now = 0
var fps = 0
var frame_time = float()

var start_tick = 0
var cur_tick = 0
var prev_tick
var elapsed_tick = 0
var tick_arr = []
var fps_arr = []

var avg_fps = float()
var prev_fps

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.set_window_fullscreen(true)
	fps_label = get_node("Panel/FPS")
	
	time_start = OS.get_unix_time()
	start_tick = OS.get_ticks_msec()
	prev_tick = start_tick
	set_process(true)
	
func _process(delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
	fps += 1
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	
	if ((elapsed - prev_tick) != 0):
		fps_arr.append(Engine.get_frames_per_second())
		
	prev_fps = elapsed
	cur_tick = OS.get_ticks_msec()
	tick_arr.append(cur_tick - prev_tick)
	prev_tick = cur_tick
	
	if (elapsed > 180):
		avg_fps = (fps / elapsed)
		elapsed_tick = cur_tick - start_tick
		frame_time = elapsed_tick / fps
		tick_arr.sort()
		fps_arr.sort()
		print("Elapsed Time: ", elapsed, " seconds")
		print("AVG FPS: ", fps / elapsed)
		print("AVG Frame Time: ", frame_time , " milliseconds per FPS")
		print("0.1 % Low FPS: ", fps_arr[(0.01 * fps)])
		
		get_tree().quit()
		
		

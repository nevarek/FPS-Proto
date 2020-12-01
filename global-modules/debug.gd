extends Node

var log_level = 1

func printd(message : String) -> void:
    if log_level > 0:
        print(message)

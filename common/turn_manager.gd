extends Node

const CARD_EFFECT_SCENE = preload("res://cards/scenes/card_effect_scene.tscn")
enum StepState {
	WAIT,
	UPKEEP,
	DRAW,
	PLAYING,
	DISCARD,
	CLARIFY,
	END
}

enum EffectState {
	WAIT,
	STAY,
	NEXT,
}

var step_state : StepState = StepState.WAIT

var hand_effects : Array[StringName]
var playfield_effects : Array[StringName]


func step() -> StepState:
	step_state = wrapi(step_state + 1, 0, StepState.size() - 1)
	match step_state:
		StepState.UPKEEP:
			hand_effects = Cards.hand.map(func(c): return c.in_hand)
			
			return StepState.DRAW
		StepState.DRAW:
			return StepState.PLAYING
		StepState.PLAYING:
			return StepState.DISCARD
		StepState.DISCARD:
			return StepState.CLARIFY
		StepState.CLARIFY:
			return StepState.END
		
	return step_state

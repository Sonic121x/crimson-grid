/obj/structure/bonfire/torch
	name = "火把"
	desc = "一根着火的棍子。真是划时代的发明。"
	icon = 'modular_darkpack/modules/decor/icons/torch.dmi'
	icon_state = "torch"
	base_icon_state = "torch"
	density = TRUE
	pass_flags_self = LETPASSTHROW
	burn_icon = "_lit"

/obj/structure/bonfire/torch/unlit
	burning = FALSE

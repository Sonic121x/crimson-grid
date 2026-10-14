/obj/item/coin/iron/obolus
	name = "冥币"
	desc = "一枚灰白泛淡蓝的硬币，散发着暮色般柔和的光。触碰它时，似乎能听见低低的痛苦呻吟与悲切哀号……"
	pickup_sound = 'modular_darkpack/modules/toys/sounds/femurbreaker.ogg'

/obj/item/coin/iron/obolus/Initialize(mapload)
	. = ..()
	pickup_sound = pick(list('modular_darkpack/modules/toys/sounds/femurbreaker.ogg', 'sound/effects/curse/curse1.ogg', 'sound/effects/curse/curse4.ogg', 'sound/effects/curse/curse5.ogg', 'sound/effects/curse/curse6.ogg', 'sound/effects/hallucinations/behind_you1.ogg', 'sound/effects/ghost.ogg'))
	AddComponent(/datum/component/selling, 700, "artifact", FALSE, 0, 10, TRUE)

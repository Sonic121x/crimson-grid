/area/vtm/outside/penumbra
	name = "Penumbra"
	icon_state = "church"
	sound_environment = SOUND_AREA_SPACE
	ambience_index = AMBIENCE_NATURE
	zone_type = ZONE_NO_MASQUERADE
	musictracks = list('modular_darkpack/modules/ambience/sounds/music/penumbra.ogg')
	fire_controled = FALSE
/area/vtm/outside/penumbra/Initialize(mapload) { GLOB.localized_darkpack_area_names[initial(name)] = "半影界"; return ..(); }
/area/vtm/interior/penumbra/enoch
	name = "???"

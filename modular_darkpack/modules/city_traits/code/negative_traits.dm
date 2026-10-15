/datum/station_trait/thunder_storm
	name = "Thunder Storm"
	trait_type = STATION_TRAIT_NEGATIVE
	can_revert = FALSE

	darkpack_allowed = TRUE
	newspaper_message = "预计今晚将有一场猛烈的风暴。"
	newspaper_chance = 75

/datum/station_trait/thunder_storm/on_round_start()
	. = ..()
	SSweather.run_weather(/datum/weather/particle/rain_storm/endless)

/datum/weather/particle/rain_storm/endless
	name = "endless rain"
	probability = 0
	target_trait = ZTRAIT_STATION
	turf_weather_chance = 0.0001
	turf_thunder_chance = THUNDER_CHANCE_VERY_RARE
	weather_flags = parent_type::weather_flags | WEATHER_ENDLESS

/datum/station_trait/foggy_night
	name = "Foggy Night"
	trait_type = STATION_TRAIT_NEGATIVE

	darkpack_allowed = TRUE
	newspaper_message = "天气预报称行车时将遇到浓雾，请务必打开远光灯。"
	newspaper_chance = 60

/datum/station_trait/foggy_night/on_round_start()
	. = ..()
	set_starlight(null, GLOB.starlight_range*0.8, GLOB.starlight_power*0.5)

/datum/station_trait/faulty_power_grid
	name = "Faulty power grid"
	trait_type = STATION_TRAIT_NEGATIVE
	can_revert = FALSE
	darkpack_allowed = TRUE
	trait_to_give = STATION_TRAIT_BLACKOUT
	newspaper_message = "市政府官员仍在一再推迟公布全市预计恢复供电的时间。"
	newspaper_chance = 60

/datum/station_trait/faulty_power_grid/on_round_start()
	. = ..()
	for(var/obj/fusebox/F as anything in GLOB.fuseboxes)
		if(prob(75))
			continue
		F.take_damage(rand(50,200))

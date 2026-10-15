/datum/round_event_control/darkpack/szlachta
	name = "Szlachta Attack"
	typepath = /datum/round_event/szlachta
	weight = 3
	min_players = 10
	max_occurrences = 1
	earliest_start = 90 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "Roving, loose szlachta have found their way into the city."
	darkpack_allowed = TRUE

/datum/round_event_control/darkpack/szlachta/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!locate(/obj/effect/landmark/event_spawn/szlachta) in GLOB.generic_event_spawns)
		return FALSE

/datum/round_event/szlachta
	start_when = 1
	announce_when = 5
	announce_chance = 75

/datum/round_event/szlachta/announce(fake)
	var/endpost_szlachta_author = pick("超自然老哥71", "M海莉71", "水管工而已92", "光明会真相者777", "撒旦观察进行时")
	var/endpost_szlachta_post = pick("看到了个超——级古怪的东西…… :) 新视频很快就会发到我的频道", "刚经历了这辈子最恐怖的一刻。看到了一种怪物。", "行吧，不管那是什么，老子现在就回家。", "（帖子附着一张极其模糊的照片，看起来像是某种怪物。是修图造假的吗？）")
	endpost_announce(endpost_szlachta_post, endpost_szlachta_author)

/datum/round_event/szlachta/start()
	for(var/obj/effect/landmark/event_spawn/szlachta/landmark in GLOB.generic_event_spawns)
		if(!prob(20))
			continue
		var/turf/spawn_turf = get_turf(landmark)
		if(!spawn_turf)
			continue

		// dont spawn if a player is nearby we don't need them popping in unrealistically
		var/player_nearby = FALSE
		for(var/mob/living/nearby_mob in view(DEFAULT_SIGHT_DISTANCE, spawn_turf))
			if(nearby_mob.client)
				player_nearby = TRUE
				break
		if(player_nearby)
			continue

		new /mob/living/basic/szlachta(spawn_turf)
		new /mob/living/basic/szlachta/fister(spawn_turf)
		if(prob(40))
			new /mob/living/basic/szlachta(spawn_turf)

		var/vozhd_type = (rand(1, 100) <= 80) ? /mob/living/basic/szlachta/tanker : /mob/living/basic/szlachta/otherthing
		new vozhd_type(spawn_turf)

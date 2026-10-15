/datum/round_event_control/darkpack/sarcophagus
	name = "Sarcophagus"
	typepath = /datum/round_event/sarcophagus
	weight = 1
	min_players = 20
	max_occurrences = 1
	earliest_start = 70 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "A strange sarcophagus has appeared in the city..."
	darkpack_allowed = TRUE

/datum/round_event_control/darkpack/sarcophagus/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!.)
		return FALSE
	var/list/valid_landmarks = list()
	for(var/obj/effect/landmark/event_spawn/sarcophagus/L in GLOB.generic_event_spawns)
		var/player_nearby = FALSE
		for(var/mob/living/nearby_mob in view(DEFAULT_SIGHT_DISTANCE, L.loc))
			if(nearby_mob.client)
				player_nearby = TRUE
				break
		if(!player_nearby)
			valid_landmarks += L

	return length(valid_landmarks) >= 2

/datum/round_event/sarcophagus
	start_when = 1
	announce_when = 5
	announce_chance = 20

/datum/round_event/sarcophagus/announce(fake)
	var/endpost_author = pick("超自然老哥71", "M海莉71", "水管工而已92", "光明会真相者777", "撒旦观察进行时")
	var/endpost_post = pick("看到了个超——级古怪的东西…… :) 新视频很快就会发到我的频道", "（帖子附着一张极其模糊的照片，看起来像是某种奇怪的陵墓。）")
	endpost_announce(endpost_post, endpost_author)

/datum/round_event/sarcophagus/start()
	var/list/landmarks = list()
	for(var/obj/effect/landmark/event_spawn/sarcophagus/L in GLOB.generic_event_spawns)
		// dont spawn if a player is nearby we don't need them popping in unrealistically
		var/player_nearby = FALSE
		for(var/mob/living/nearby_mob in view(DEFAULT_SIGHT_DISTANCE, L.loc))
			if(nearby_mob.client)
				player_nearby = TRUE
				break
		if(player_nearby)
			continue
		landmarks += L

	if(length(landmarks) < 2)
		return

	var/obj/effect/landmark/event_spawn/sarcophagus/sarcophagus_landmark = pick(landmarks)
	landmarks -= sarcophagus_landmark
	var/obj/effect/landmark/event_spawn/sarcophagus/key_landmark = pick(landmarks)

	var/sarcophagus_type = pick(list(/obj/sarcophagus/bomb, /obj/sarcophagus, /obj/sarcophagus/empty))
	new sarcophagus_type(sarcophagus_landmark.loc)
	new /obj/item/sarcophagus_key(key_landmark.loc)

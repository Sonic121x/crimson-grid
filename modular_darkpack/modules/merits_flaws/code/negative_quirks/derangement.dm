GLOBAL_LIST_INIT(localized_derangement_phrases, list("Evil crouches" = "邪恶正蹲伏着", "Death" = "死亡", "DIE!" = "去死！", "I smell a rancid grave" = "我闻到一座腐臭坟墓的气息", "Rustling robes of the Reaper" = "死神的长袍沙沙作响", "All are blind whose eyes are closed" = "闭上双眼的人，全都看不见", "The drove is a terrible mistress" = "群兽是可怕的女主人", "Wishes and words sprout from the same seed" = "心愿与话语从同一颗种子萌发", "A dark light from your death" = "你的死亡透出一道幽暗的光", "Hemlock for the deceivers" = "给欺骗者献上毒芹", "It has two mouths to lick from" = "它有两张嘴可以舔舐", "Deep of the Atlantic, dark, dreaming, sleeping" = "大西洋深处，黑暗，梦境，沉眠", "Can't see, can't see! Where have my eyes gone to?" = "看不见，看不见！我的眼睛去哪儿了？", "Heloise said you. Cranberry sauce. Hotel foxtrot" = "爱洛伊丝说了你。蔓越莓酱。旅馆狐步舞", "Stop doing that. Mother shan't be too pleased. None too pleased" = "别再那样了。母亲会不高兴的。非常不高兴", "Those lips bleed a putrid poison" = "那双唇淌着腐臭的毒液", "Rat tails, cat tails, coat tails, all tales" = "鼠尾，猫尾，燕尾，全是谎话的尾巴", "It's not fair! I wanted to" = "这不公平！我也想要", "Pennies for your eyes in its pockets" = "它口袋里的铜板，是用来盖住你双眼的", "Why is it troubled?" = "它为什么烦恼？", "Ask about the free arsenic" = "问问那免费送的砒霜", "Blood brings the vicious beast" = "鲜血引来了凶恶的心兽", "I see daggers hang on his breath" = "我看见匕首悬在他的吐息上", "Bone round in melody and word layed in rain" = "白骨在旋律里打转，话语被搁在雨中", "Cemetery runoff congealing at the door" = "墓地流出的污水凝结在门边", "Maggots love you. Trust me" = "蛆虫爱你。相信我", "Mast lay shrouded and the moon is melting" = "桅杆裹着裹尸布，月亮正在融化", "Try the corpse in the oven with peppers and fur" = "尝尝烤箱里的尸体吧，配着辣椒和皮毛", "Souls draped in rotten tatters and Father dances in the dark" = "灵魂披着腐烂的破布，父亲在黑暗中起舞", "Make the tallow from the fat of a hangman" = "拿绞刑刽子手的脂肪炼油", "Bent like a calf for the butcher" = "像待宰的小牛一样蜷伏", "You're in for it now" = "这下有你受的了", "They're coming" = "他们来了", "It casts a crooked shadow" = "它投下扭曲的影子", "Elkabo, elkabo, pixy queen where all is green" = "埃尔卡博，埃尔卡博，小妖精女王所在之处皆是翠绿", "It's a tangle of asps" = "那是一团纠缠的毒蛇", "Sealed with the kiss of swine" = "以猪的亲吻封缄", "A trick with two tongues" = "两条舌头耍的把戏", "The very thought falls to the flame" = "连这个念头也坠入火焰"))
#define FLOOR_DISAPPEAR 3 SECONDS

// associative list used by dementation and the derangement quirk
GLOBAL_LIST_INIT(derangement_phrases,list(
	"Evil crouches" = 'modular_darkpack/modules/powers/sounds/dementation/speech/crouch.ogg',
	"Death" = 'modular_darkpack/modules/powers/sounds/dementation/speech/death.ogg',
	"DIE!" = 'modular_darkpack/modules/powers/sounds/dementation/speech/die.ogg',
	"I smell a rancid grave" = 'modular_darkpack/modules/powers/sounds/dementation/speech/grave.ogg',
	"Rustling robes of the Reaper" = 'modular_darkpack/modules/powers/sounds/dementation/speech/reaper.ogg',
	"All are blind whose eyes are closed" = 'modular_darkpack/modules/powers/sounds/dementation/speech/blind.ogg',
	"The drove is a terrible mistress" = 'modular_darkpack/modules/powers/sounds/dementation/speech/mistress.ogg',
	"Wishes and words sprout from the same seed" = 'modular_darkpack/modules/powers/sounds/dementation/speech/wishes_words.ogg',
	"A dark light from your death" = 'modular_darkpack/modules/powers/sounds/dementation/speech/dark_light.ogg',
	"Hemlock for the deceivers" = 'modular_darkpack/modules/powers/sounds/dementation/speech/hemlock.ogg',
	"It has two mouths to lick from" = 'modular_darkpack/modules/powers/sounds/dementation/speech/two_mouths.ogg',
	"Deep of the Atlantic, dark, dreaming, sleeping" = 'modular_darkpack/modules/powers/sounds/dementation/speech/atlantic.ogg',
	"Can't see, can't see! Where have my eyes gone to?" = 'modular_darkpack/modules/powers/sounds/dementation/speech/eyes.ogg',
	"Heloise said you. Cranberry sauce. Hotel foxtrot" = 'modular_darkpack/modules/powers/sounds/dementation/speech/heloise.ogg',
	"Stop doing that. Mother shan't be too pleased. None too pleased" = 'modular_darkpack/modules/powers/sounds/dementation/speech/mother.ogg',
	"Those lips bleed a putrid poison" = 'modular_darkpack/modules/powers/sounds/dementation/speech/putrid.ogg',
	"Rat tails, cat tails, coat tails, all tales" = 'modular_darkpack/modules/powers/sounds/dementation/speech/tails.ogg',
	"It's not fair! I wanted to" = 'modular_darkpack/modules/powers/sounds/dementation/speech/not_fair.ogg',
	"Pennies for your eyes in its pockets" = 'modular_darkpack/modules/powers/sounds/dementation/speech/pennies.ogg',
	"Why is it troubled?" = 'modular_darkpack/modules/powers/sounds/dementation/speech/troubled.ogg',
	"Ask about the free arsenic" = 'modular_darkpack/modules/powers/sounds/dementation/speech/arsenic.ogg',
	"Blood brings the vicious beast" = 'modular_darkpack/modules/powers/sounds/dementation/speech/beast.ogg',
	"I see daggers hang on his breath" = 'modular_darkpack/modules/powers/sounds/dementation/speech/daggers.ogg',
	"Bone round in melody and word layed in rain" = 'modular_darkpack/modules/powers/sounds/dementation/speech/bone.ogg',
	"Cemetery runoff congealing at the door" = 'modular_darkpack/modules/powers/sounds/dementation/speech/cemetery.ogg',
	"Maggots love you. Trust me" = 'modular_darkpack/modules/powers/sounds/dementation/speech/maggots.ogg',
	"Mast lay shrouded and the moon is melting" = 'modular_darkpack/modules/powers/sounds/dementation/speech/moon.ogg',
	"Try the corpse in the oven with peppers and fur" = 'modular_darkpack/modules/powers/sounds/dementation/speech/peppers.ogg',
	"Souls draped in rotten tatters and Father dances in the dark" = 'modular_darkpack/modules/powers/sounds/dementation/speech/souls.ogg',
	"Make the tallow from the fat of a hangman" = 'modular_darkpack/modules/powers/sounds/dementation/speech/tallow.ogg',
	"Bent like a calf for the butcher" = 'modular_darkpack/modules/powers/sounds/dementation/speech/calf.ogg',
	"You're in for it now" = 'modular_darkpack/modules/powers/sounds/dementation/speech/in_for_it.ogg',
	"They're coming" = 'modular_darkpack/modules/powers/sounds/dementation/speech/theyre_coming.ogg',
	"It casts a crooked shadow" = 'modular_darkpack/modules/powers/sounds/dementation/speech/shadow.ogg',
	"Elkabo, elkabo, pixy queen where all is green" = 'modular_darkpack/modules/powers/sounds/dementation/speech/elkabo.ogg',
	"It's a tangle of asps" = 'modular_darkpack/modules/powers/sounds/dementation/speech/asps.ogg',
	"Sealed with the kiss of swine" = 'modular_darkpack/modules/powers/sounds/dementation/speech/swine.ogg',
	"A trick with two tongues" = 'modular_darkpack/modules/powers/sounds/dementation/speech/tongues.ogg',
	"The very thought falls to the flame" = 'modular_darkpack/modules/powers/sounds/dementation/speech/flame.ogg'
))


/datum/quirk/darkpack/derangement
	name = "Derangement"
	desc = "你患有永久且无法治愈的精神紊乱，感知会因此改变。"
	icon = FA_ICON_HOUSE_MEDICAL_CIRCLE_EXCLAMATION
	gain_text = span_hypnophrase("你觉得有些不对劲……")
	lose_text = span_notice("你开始觉得自己恢复正常了……")
	medical_record_text = "患者患有难治性精神疾病。"
	value = -3
	hardcore_value = 6
	quirk_flags = QUIRK_PROCESSES
	mob_trait = TRAIT_SHIFTY_EYES // they're deranged, so give them the trait that tells people around them about their crazy eyes
	mail_goodies = list(/obj/effect/spawner/random/contraband/narcotics) // happy pills! :)
	excluded_clans = list(VAMPIRE_CLAN_MALKAVIAN)
	var/process_interval = 3 SECONDS
	var/list/derangements
	COOLDOWN_DECLARE(next_process)

/datum/quirk/darkpack/derangement/add()
	derangements = subtypesof(/datum/hallucination/malk)

/datum/quirk/darkpack/derangement/process(seconds_per_tick)
	if(!quirk_holder.client)
		return
	if(!COOLDOWN_FINISHED(src, next_process))
		return
	if(SPT_PROB(2, seconds_per_tick))
		quirk_holder.cause_hallucination( \
			pick(derangements), \
			"derangement", \
		)
	COOLDOWN_START(src, next_process, process_interval)
	handle_malk_floors()

// largely taken from https://github.com/The-Final-Nights/The-Final-Nights/pull/287
// based on the work of maaacha
/datum/quirk/darkpack/derangement/proc/handle_malk_floors()
	if(!quirk_holder?.client)
		return
	//Floors go crazy go stupid
	for(var/turf/open/floor in view(quirk_holder))
		if(!prob(7))
			continue
		if(isgroundlessturf(floor))
			continue
		handle_malk_floor(floor)

/datum/quirk/darkpack/derangement/proc/handle_malk_floor(turf/open/floor)
	var/mutable_appearance/fake_floor = image(floor.icon, floor, floor.icon_state, floor.layer)
	quirk_holder?.client.images += fake_floor
	var/offset = pick(-3,-2, -1, 1, 2, 3)
	var/disappearfirst = rand(1 SECONDS, 3 SECONDS) * abs(offset)
	animate(fake_floor, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	addtimer(CALLBACK(src, PROC_REF(malk_floor_stage1), quirk_holder, offset, fake_floor), disappearfirst, TIMER_CLIENT_TIME)

/datum/quirk/darkpack/derangement/proc/malk_floor_stage1(mob/living/malk, offset, mutable_appearance/fake_floor)
	animate(fake_floor, pixel_y = -offset, time = FLOOR_DISAPPEAR, flags = ANIMATION_RELATIVE)
	addtimer(CALLBACK(src, PROC_REF(malk_floor_stage2), malk, fake_floor), FLOOR_DISAPPEAR, TIMER_CLIENT_TIME)

/datum/quirk/darkpack/derangement/proc/malk_floor_stage2(mob/living/malk, mutable_appearance/fake_floor)
	malk.client?.images -= fake_floor

/datum/hallucination/malk
	random_hallucination_weight = 0 // so it doesn't show up for kine that drink absinthe or something

/datum/hallucination/malk/ambience

/datum/hallucination/malk/ambience/start()
	var/static/list/ambient_sounds = list(
		'modular_darkpack/modules/powers/sounds/dementation/comic1.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/comic2.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/comic3.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/comic4.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/man_cry.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/woman_cry.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/child_cry.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/man_moan.ogg', // zombie like moaning sounds
		'modular_darkpack/modules/powers/sounds/dementation/woman_moan.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/evillaugh.ogg'
	)
	hallucinator.playsound_local(hallucinator, pick(ambient_sounds), vol = 20, vary = FALSE)

/datum/hallucination/malk/object
	var/static/list/audible_hallucinations = GLOB.derangement_phrases

/datum/hallucination/malk/object/start()
	var/list/objects = list()

	for(var/obj/object in view(hallucinator))
		if((object.invisibility > hallucinator.see_invisible) || !object.loc || !object.name || (object in hallucinator.contents))
			continue
		var/weight = 1
		if(isitem(object))
			weight = 3
		else if(isstructure(object))
			weight = 2
		else if(ismachinery(object))
			weight = 2
		objects[object] = weight
	if(!length(objects))
		return

	var/obj/speaker = pick_weight(objects)
	var/speech = pick(audible_hallucinations)
	var/language = hallucinator.get_random_understood_language()
	var/message = hallucinator.compose_message(speaker, language, spooky_font_replace(GLOB.localized_derangement_phrases[speech] || speech))
	hallucinator.playsound_local(hallucinator, audible_hallucinations[speech], vol = 20, vary = TRUE)
	if(hallucinator.client.prefs.read_preference(/datum/preference/toggle/see_rc_emotes))
		hallucinator.create_chat_message(speaker, language, spooky_font_replace(GLOB.localized_derangement_phrases[speech] || speech), spans = list("italics"))
	to_chat(hallucinator, span_cult_italic(message))

	return TRUE

// override for the your_mother hallucination for malkavians
/datum/hallucination/your_mother/malk
	var/malk_file = "~darkpack/malk_mother_hallucination.json" //malkavian specific file
	mother = /obj/effect/client_image_holder/hallucination/your_mother/malk

/datum/hallucination/your_mother/malk/start()
	var/mob/living/carbon/human/malk = astype(hallucinator)
	if(!malk?.client || IS_UNCONSCIOUS(malk))
		return FALSE
	var/age = malk.chronological_age

	var/list/spawn_locs = list()
	for(var/turf/open/floor in view(malk, 4))
		if(floor.is_blocked_turf(exclude_mobs = TRUE))
			continue
		spawn_locs += floor

	if(!length(spawn_locs))
		return FALSE
	var/turf/spawn_loc = pick(spawn_locs)
	mother = new /obj/effect/client_image_holder/hallucination/your_mother/malk(spawn_loc, malk, src)
	mother.AddComponent(/datum/component/leash, owner = malk, distance = get_dist(malk, mother)) //basically makes mother follow them
	point_at(malk)
	talk("[capitalize(malk.real_name)]!!") // Your mother won't be fooled by paltry disguises
	var/list/scold_lines = list(
		pick_list_replacements(malk_file, "do_something"),
		pick_list_replacements(malk_file, "be_upset"),
		pick_list_replacements(malk_file, "get_reprimanded"),
	)

	if(age >= 50)
		scold_lines = list(
			pick_list_replacements(malk_file, "do_something_old"),
			pick_list_replacements(malk_file, "be_upset"),
			pick_list_replacements(malk_file, "get_reprimanded_old"),
		)
	var/delay = 4 SECONDS
	for(var/line in scold_lines)
		addtimer(CALLBACK(src, PROC_REF(talk), line), delay)
		delay += 5 SECONDS
	addtimer(CALLBACK(src, PROC_REF(exit)), delay + 10 SECONDS)
	return TRUE


/obj/effect/client_image_holder/hallucination/your_mother/malk
	gender = FEMALE
	image_icon = 'icons/mob/simple/simple_human.dmi'
	name = "你的母亲"
	desc = "……但，那不可能是她吧？"
	image_state = ""

// the random hallucination type will store overrides and extensions of basegame hallucinations, as well as untouched basegame hallucinations like eyes_in_the_dark
/datum/hallucination/malk/random
	var/list/hallucinations = list(/datum/hallucination/eyes_in_dark, /datum/hallucination/your_mother/malk, /datum/hallucination/blood_flow/malk)

/datum/hallucination/malk/random/start()
	hallucinator.cause_hallucination(pick(hallucinations), "malkavian derangement")
	return TRUE

// 'Blood Flow'
/datum/hallucination/blood_flow/malk
	random_hallucination_weight = 0

/datum/hallucination/blood_flow/malk/by_god()
	if(QDELETED(src) || QDELETED(hallucinator) || QDELETED(bleeding_bodypart))
		return

	to_chat(hallucinator, span_warning("我的伤口血流不止，却好像一点也不疼……"))

#undef FLOOR_DISAPPEAR

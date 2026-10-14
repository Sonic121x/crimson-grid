/datum/brain_trauma/mild/phobia
	name = "恐惧症"
	desc = "患者对某种事物抱有不合理的恐惧。"
	scan_desc = "恐惧症"
	symptoms = "接触特定刺激时，\
		立即出现远超通常程度的焦虑或恐惧反应，\
		导致惊恐发作，或损害社交和工作能力。\
		拥抱等身体接触或安神定等药物可以减轻反应的严重程度。"
	gain_text = span_warning("你开始觉得默认值让人心神不宁……")
	lose_text = span_notice("你不再害怕默认值了。")
	var/static/list/phobia_display_names = list("aliens" = "外星生物", "anime" = "日本文化", "authority" = "权威", "birds" = "鸟类", "blood" = "血液", "clowns" = "小丑", "conspiracies" = "阴谋", "doctors" = "医生", "falling" = "跌落", "fish" = "鱼类", "greytide" = "灰潮", "guns" = "枪械", "insects" = "昆虫", "lizards" = "爬行动物", "ocky icky" = "角色外事物", "robots" = "机器人", "security" = "安保", "skeletons" = "骨骼", "snakes" = "蛇类", "space" = "太空", "spiders" = "蜘蛛", "strangers" = "陌生人", "the supernatural" = "鬼怪", "religion" = "宗教")
	var/phobia_type
	/// Specific terror handler to apply, in case we want
	var/terror_handler = /datum/terror_handler/phobia_source
	/// What mood event to apply when we see the thing & freak out.
	var/mood_event_type = /datum/mood_event/phobia

/datum/brain_trauma/mild/phobia/New(new_phobia_type)
	if(new_phobia_type)
		phobia_type = new_phobia_type

	if(!phobia_type)
		phobia_type = pick(GLOB.phobia_types)

	gain_text = span_warning("你开始觉得[phobia_display_names[phobia_type] || phobia_type]让人心神不宁……")
	lose_text = span_notice("你不再害怕[phobia_display_names[phobia_type] || phobia_type]了。")
	scan_desc = GLOB.phobia_types[phobia_type] || "对[phobia_display_names[phobia_type] || phobia_type]的恐惧症"
	return ..()

/datum/brain_trauma/mild/phobia/on_gain()
	. = ..()
	var/datum/component/fearful/fear = owner.AddComponentFrom(REF(src), /datum/component/fearful, list(/datum/terror_handler/startle))
	var/datum/terror_handler/phobia_source/phobia = fear.add_handler(terror_handler, REF(src))
	phobia.trigger_regex = GLOB.phobia_regexes[phobia_type]
	phobia.trigger_mobs = GLOB.phobia_mobs[phobia_type]
	phobia.trigger_objs = GLOB.phobia_objs[phobia_type]
	phobia.trigger_turfs = GLOB.phobia_turfs[phobia_type]
	phobia.trigger_species = GLOB.phobia_species[phobia_type]
	phobia.mood_event_type = mood_event_type

/datum/brain_trauma/mild/phobia/on_lose(silent)
	. = ..()
	owner.RemoveComponentSource(REF(src), /datum/component/fearful)

// Defined phobia types for badminry, not included in the RNG trauma pool to avoid diluting.

/datum/brain_trauma/mild/phobia/aliens
	phobia_type = "aliens"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/anime
	phobia_type = "anime"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/authority
	phobia_type = "authority"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/birds
	phobia_type = "birds"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/blood
	phobia_type = "blood"
	random_gain = FALSE
	terror_handler = /datum/terror_handler/phobia_source/blood

/datum/brain_trauma/mild/phobia/clowns
	phobia_type = "clowns"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/conspiracies
	phobia_type = "conspiracies"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/doctors
	phobia_type = "doctors"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/falling
	phobia_type = "falling"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/fish
	phobia_type = "fish"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/greytide
	phobia_type = "greytide"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/guns
	phobia_type = "guns"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/insects
	phobia_type = "insects"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/lizards
	phobia_type = "lizards"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/ocky_icky
	phobia_type = "ocky icky"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/robots
	phobia_type = "robots"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/security
	phobia_type = "security"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/skeletons
	phobia_type = "skeletons"
	mood_event_type = /datum/mood_event/spooked
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/snakes
	phobia_type = "snakes"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/space
	phobia_type = "space"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/spiders
	phobia_type = "spiders"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/strangers
	phobia_type = "strangers"
	random_gain = FALSE

/datum/brain_trauma/mild/phobia/supernatural
	phobia_type = "the supernatural"
	random_gain = FALSE

/datum/subsplat/werewolf/tribe/garou
	abstract_type = /datum/subsplat/werewolf/tribe/garou
	fera_restriction = SPLAT_GAROU

// V20s "Wendigos"
/datum/subsplat/werewolf/tribe/garou/galestalkers
	name = TRIBE_GALESTALKERS
	desc = "逐风者是不知疲倦的追踪者与无可匹敌的猎手，以横越苔原的疾风为名。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/beat_of_the_heartdrum
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
	)
	//subsplat_keys = /obj/item/vamp/keys/nps CRIMSON EDIT REMOVAL - Park Keys for Roles


// V20 "Uktena"
/datum/subsplat/werewolf/tribe/garou/ghostcouncil
	name = TRIBE_UKTENA
	desc = "乌克提纳追寻奥秘，行事极为隐秘，是最受误解的部族之一。成员中既有向导与学者，也有虔诚信徒。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/sense_magic,
		// /datum/action/cooldown/power/gift/spirit_speech, // DARKPACK TODO - (Selectable Gifts)
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/hartwardens
	name = TRIBE_FIANNA
	desc = "他们栽培、创造、养育并守护盖亚最纯粹的造物，是最亲近自然的守护者。无论身在何处，他们都尽力从身边的万物中唤出盖亚的赐福。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/faerie_light,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/glasswalkers
	name = TRIBE_GLASS_WALKERS
	desc = "玻璃行者最接近织者，深深扎根于现代人类社会、宗教、科技与城市。每一项新发明与新发现都会成为他们的助力，而非阻碍。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/control_machine/simple,
	)
	subsplat_keys = /obj/item/vamp/keys/techstore

/datum/subsplat/werewolf/tribe/garou/bonegnawers
	name = TRIBE_BONE_GNAWERS
	desc = "啃骨者是生存者与拾荒者，常常一贫如洗、无家可归。旁人将他们视为靠残羹冷炙度日的杂种，但他们深知自身价值。他们是真正的生存者，耐心等待时机，给予自负的敌人致命一击。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/desperate_strength,
	)
	subsplat_keys = /obj/item/vamp/keys/children_of_gaia

/datum/subsplat/werewolf/tribe/garou/childrenofgaia
	name = TRIBE_CHILDREN_OF_GAIA
	desc = "盖亚之子是和平维护者、谈判者、盟约缔造者与哲学家。他们竭尽全力，让分歧重重的部族相互理解、团结一致，共同抵御敌人。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/jam_weapon
		// /datum/action/cooldown/power/gift/mothers_touch, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
	)
	subsplat_keys = /obj/item/vamp/keys/children_of_gaia

/datum/subsplat/werewolf/tribe/garou/getoffenris
	name = TRIBE_GET_OF_FENRIS
	desc = "芬里斯之裔是怀有怜悯却又凶猛的战士，自视为盖亚最强大的英雄。其他部族却对他们心存戒备，因为他们的暴力比勇气更为人所知。"
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/razor_claws, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
		/datum/action/cooldown/power/gift/visage_of_fenris,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/blackfuries
	name = TRIBE_BLACK_FURIES
	desc = "黑怒之女是完全由女性组成的部族，也是狼人中的女族长。她们以荣誉、智慧、自尊及出众的战斗本领赢得赞誉。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/breath_of_the_wyld,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/silentstriders
	name = TRIBE_SILENT_STRIDERS
	desc = "寂静行者是灵性深厚的游牧者。与其他部族相比，他们深入影界更远，在其中停留也更久。"
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/sense_wyrm, // DARKPACK TODO - (Selectable Gifts)
		/datum/action/cooldown/power/gift/speed_of_thought,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/shadowlords
	name = TRIBE_SHADOW_LORDS
	desc = "暗影领主是狼人中最接近“政客”的一群。他们操纵其他部族与敌人，相比蛮力，更依靠计谋与智慧。并非他们之中没有出色的战士，只是整个部族更看重头脑。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/aura_of_confidence,
		/datum/action/cooldown/power/gift/fatal_flaw,
	)
	subsplat_keys = /obj/item/vamp/keys/techstore

/datum/subsplat/werewolf/tribe/garou/redtalons
	name = TRIBE_RED_TALONS
	desc = "赤爪完全由狼裔组成。他们远离人类，视人类为盖亚身上的毒疮。"
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/beast_speech, // DARKPACK TODO - (Selectable Gifts)
		/datum/action/cooldown/power/gift/hidden_killer,
	)

/datum/subsplat/werewolf/tribe/garou/silverfangs
	name = TRIBE_SILVER_FANGS
	desc = "银牙通常被视为狼人国度的“头狼”，成员多为传统统治者与战时领袖，以荣誉和勇气著称。然而，古怪的精神异常开始困扰年轻成员，灵魂与心智的疾病正逐渐侵蚀整个部族。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/falcons_grasp,
		// /datum/action/cooldown/power/gift/inspiration, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/sense_wyrm, // DARKPACK TODO - (Selectable Gifts)
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/stargazers
	name = TRIBE_STARGAZERS
	desc = "观星者是最沉静的狼人，以内敛著称。他们的许多同族被妖蛆消灭，如今是现存部族中规模最小的一支。"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/channeling,
		// /datum/action/cooldown/power/gift/falling_touch, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/sense_wyrm, // DARKPACK TODO - (Selectable Gifts)
	)
	//subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles


/datum/subsplat/werewolf/tribe/garou/blackspiraldancers
	name = TRIBE_BLACK_SPIRAL_DANCERS
	desc = "失落的部族，令人恐惧的狼群。他们与妖蛆同舞，曾踏入迷宫，归来时已面目全非。\n<b>{该部族扮演难度较高，不建议新手选择。扮演此部族需要了解相关背景设定。}</B>"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/bane_protector,
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/sense_wyrm, // DARKPACK TODO - (Selectable Gifts)
	)
	subsplat_traits = list(TRAIT_WYRMTAINTED)

/datum/subsplat/werewolf/tribe/garou/blackspiraldancers/psychomania_effect(mob/living/target, mob/living/owner)
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
	target.visible_message(span_warning("[target]因野兽般的恐惧而呜咽。"), span_cult("硫磺与烈焰的幻象在我眼前闪过！"))
	target.Paralyze(5 SECONDS)

	// CRIMSON GRID ADD END: DARK THAUMATURGY
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY

/datum/subsplat/werewolf/tribe/garou/ronin
	name = TRIBE_RONIN
	desc = "浪人是因各种缘由而遭狼人国度放逐的狼人。"
	gifts_provided = list()

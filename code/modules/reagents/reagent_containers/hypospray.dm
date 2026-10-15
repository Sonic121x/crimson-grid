/obj/item/reagent_containers/hypospray
	name = "气压注射器"
	desc = "迪福瑞斯医疗公司的无菌气压自动注射器，用于迅速为患者给药。"
	icon = 'icons/obj/medical/syringe.dmi'
	inhand_icon_state = "hypo"
	worn_icon_state = "hypo"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = list(5)
	resistance_flags = ACID_PROOF
	initial_reagent_flags = OPENCONTAINER | NO_SPLASH
	slot_flags = ITEM_SLOT_BELT
	var/ignore_flags = NONE
	var/infinite = FALSE
	/// If TRUE, won't play a noise when injecting.
	var/stealthy = FALSE
	/// If TRUE, the hypospray will be permanently unusable.
	var/used_up = FALSE

/obj/item/reagent_containers/hypospray/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/reagent_containers/hypospray/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	return inject(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/item/reagent_containers/hypospray/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	if (!target.reagents)
		return NONE

	if(isliving(target))
		to_chat(user, span_warning("[src]不能用来抽血！"))
		return ITEM_INTERACT_BLOCKING

	if(reagents.holder_full())
		to_chat(user, span_notice("[src]已满。"))
		return ITEM_INTERACT_BLOCKING

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target]是空的！"))
		return ITEM_INTERACT_BLOCKING

	if(!target.is_drawable(user))
		to_chat(user, span_warning("你无法直接从[target]中抽取试剂！"))
		return ITEM_INTERACT_BLOCKING

	var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user)
	if(trans)
		to_chat(user, span_notice("你向[src]中抽入了[trans]单位溶液。里面现有[reagents.total_volume]单位。"))
	return ITEM_INTERACT_SUCCESS

///Handles all injection checks, injection and logging.
/obj/item/reagent_containers/hypospray/proc/inject(mob/living/affected_mob, mob/user)
	if(used_up)
		to_chat(user, span_warning("[src]的喷头坏了，无法再使用！"))
		return FALSE
	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "attempted to inject", src, "([contained])")
	user.changeNext_move(CLICK_CD_MELEE)

	if(!used_up && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))) // Ignore flag should be checked first or there will be an error message.
		to_chat(affected_mob, span_warning("你感到一阵轻微的刺痛！"))
		to_chat(user, span_notice("你用[src]给[affected_mob]注射。"))
		if(!stealthy)
			playsound(affected_mob, 'sound/items/hypospray.ogg', 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)


		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transferred_by = user, methods = INJECT)
			else
				reagents.expose(affected_mob, INJECT, fraction)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, methods = INJECT, copy_only = TRUE)
			to_chat(user, span_notice("已注射[trans]单位，[src]内还剩[reagents.total_volume]单位。"))
			log_combat(user, affected_mob, "injected", src, "([contained])")
		return TRUE
	return FALSE


/obj/item/reagent_containers/hypospray/cmo
	volume = 60
	possible_transfer_amounts = list(1,3,5)
	list_reagents = list(/datum/reagent/medicine/omnizine = 30)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//combat

/obj/item/reagent_containers/hypospray/combat
	name = "战斗兴奋剂注射器"
	desc = "改装的气压自动注射器，供支援人员在战斗中快速治疗伤势。"
	amount_per_transfer_from_this = 10
	inhand_icon_state = "combat_hypo"
	icon_state = "combat_hypo"
	volume = 90
	possible_transfer_amounts = list(5,10)
	ignore_flags = 1 // So they can heal their comrades.
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30, /datum/reagent/medicine/omnizine = 30, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/hypospray/combat/empty
	list_reagents = null

/obj/item/reagent_containers/hypospray/combat/nanites
	name = "experimental combat stimulant injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with experimental medical nanites and a stimulant for rapid healing and a combat boost."
	inhand_icon_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 100
	list_reagents = list(/datum/reagent/medicine/adminordrazine/quantum_heal = 80, /datum/reagent/medicine/synaptizine = 20)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/combat/heresypurge
	name = "holy water piercing injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with 5 doses of a holy water and pacifier mixture. Not for use on your teammates."
	inhand_icon_state = "holy_hypo"
	icon_state = "holy_hypo"
	volume = 250
	possible_transfer_amounts = list(25,50)
	list_reagents = list(/datum/reagent/water/holywater = 150, /datum/reagent/peaceborg/tire = 50, /datum/reagent/peaceborg/confuse = 50)
	amount_per_transfer_from_this = 50

//MediPens

/obj/item/reagent_containers/hypospray/medipen
	name = "肾上腺素急救注射笔"
	desc = "让缺乏专业医学知识的人员也能快速、安全地稳定危重患者的状况。内含强效防腐成分，用于尸体可延缓腐败，也能在过敏反应中阻止组胺产生。"
	icon_state = "medipen"
	inhand_icon_state = "medipen"
	worn_icon_state = "medipen"
	base_icon_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount_per_transfer_from_this = 15
	has_variable_transfer_amount = FALSE
	volume = 15
	ignore_flags = 1 //so you can medipen through spacesuits
	initial_reagent_flags = NONE
	flags_1 = null
	list_reagents = list(/datum/reagent/medicine/epinephrine = 10, /datum/reagent/toxin/formaldehyde = 3, /datum/reagent/medicine/coagulant = 2)
	custom_price = PAYCHECK_CREW
	custom_premium_price = PAYCHECK_COMMAND
	var/label_examine = TRUE
	var/label_text

/obj/item/reagent_containers/hypospray/medipen/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]把[src]塞进喉咙，开始窒息！看起来是想自杀！"))
	return OXYLOSS//ironic. he could save others from oxyloss, but not himself.

/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(. && !reagents.total_volume)
		used_up = TRUE //Makes them useless afterwards
		reagents.flags = NONE
		update_appearance()

/obj/item/reagent_containers/hypospray/medipen/attack_self(mob/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH|ALLOW_RESTING))
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/medipen/Initialize(mapload)
	. = ..()
	label_text = span_notice("侧面的贴纸写着：“警告：此急救注射笔含有[pretty_string_from_reagent_list(reagents.reagent_list, names_only = TRUE, join_text = ", ", final_and = TRUE, capitalize_names = TRUE)]，如对所列任何成分过敏，请勿使用。”")

/obj/item/reagent_containers/hypospray/medipen/examine()
	. = ..()
	if (label_examine)
		. += label_text
	if(length(reagents?.reagent_list))
		. += span_notice("里面还有药剂。")
	else
		. += span_notice("已经用完了。")

/obj/item/reagent_containers/hypospray/medipen/stimpack //goliath kiting
	name = "stimpack medipen"
	desc = "A rapid way to stimulate your body's adrenaline, allowing for freer movement in restrictive armor."
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/medicine/ephedrine = 10, /datum/reagent/consumable/coffee = 10)

/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor
	desc = "A modified stimulants autoinjector for use in combat situations. Has a mild healing effect."
	list_reagents = list(/datum/reagent/medicine/stimulants = 10, /datum/reagent/medicine/omnizine = 10)
	volume = 20

/obj/item/reagent_containers/hypospray/medipen/stimulants
	name = "stimulant medipen"
	desc = "Contains a very large amount of an incredibly powerful stimulant, vastly increasing your movement speed and reducing stuns by a very large amount for around five minutes. Do not take if pregnant."
	icon_state = "syndipen"
	inhand_icon_state = "tbpen"
	base_icon_state = "syndipen"
	volume = 50
	amount_per_transfer_from_this = 50
	list_reagents = list(/datum/reagent/medicine/stimulants = 50)

/obj/item/reagent_containers/hypospray/medipen/methamphetamine
	name = "methamphetamine medipen"
	volume = 24
	amount_per_transfer_from_this = 24
	desc = "Contains a relatively safe quantity of methamphetamine, along with mannitol to ensure that brain damage is kept at a minimum."
	list_reagents = list(/datum/reagent/drug/methamphetamine = 10, /datum/reagent/medicine/mannitol = 14)

/obj/item/reagent_containers/hypospray/medipen/morphine
	name = "morphine medipen"
	desc = "A rapid way to get you out of a tight situation and fast! You'll feel rather drowsy, though."
	icon_state = "morphen"
	inhand_icon_state = "morphen"
	base_icon_state = "morphen"
	list_reagents = list(/datum/reagent/medicine/morphine = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/oxandrolone
	name = "奥沙雄龙急救注射笔"
	desc = "含有奥沙雄龙的自动注射器，用于治疗严重烧伤。"
	icon_state = "oxapen"
	inhand_icon_state = "oxapen"
	base_icon_state = "oxapen"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/penacid
	name = "喷替酸急救注射笔"
	desc = "含有喷替酸的自动注射器，用于清除大量体内辐射并缓解中度中毒。"
	icon_state = "penacid"
	inhand_icon_state = "penacid"
	base_icon_state = "penacid"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/salacid
	name = "水杨酸急救注射笔"
	desc = "含有水杨酸的自动注射器，用于治疗严重外伤。"
	icon_state = "salacid"
	inhand_icon_state = "salacid"
	base_icon_state = "salacid"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/salbutamol
	name = "沙丁胺醇急救注射笔"
	desc = "含有沙丁胺醇的自动注射器，用于快速治疗缺氧损伤。"
	icon_state = "salpen"
	inhand_icon_state = "salpen"
	base_icon_state = "salpen"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10)
	volume = 10

// DARKPACK EDIT ADD START
/obj/item/reagent_containers/hypospray/medipen/ifak
	name = "个人急救包稳伤注射笔"
	desc = "用于一般治疗和稳定伤情的一次性自动注射器。切勿重复注射。内含水杨酸、沙丁胺醇、奥沙雄龙、促凝血剂和肾上腺素。"
	icon_state = "salpen"
	inhand_icon_state = "salpen"
	volume = 45
	amount_per_transfer_from_this = 45
	list_reagents = list(/datum/reagent/medicine/sal_acid = 10, /datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/oxandrolone = 10, /datum/reagent/medicine/epinephrine = 10, /datum/reagent/medicine/coagulant = 5)
// DARKPACK EDIT ADD END

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure
	name = "BVAK autoinjector"
	desc = "Bio Virus Antidote Kit autoinjector. Has a two use system for yourself, and someone else. Inject when infected."
	icon_state = "tbpen"
	inhand_icon_state = "tbpen"
	base_icon_state = "tbpen"
	volume = 20
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 20)

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"

/obj/item/reagent_containers/hypospray/medipen/survival
	name = "survival emergency medipen"
	desc = "A medipen for surviving in the harsh environments, heals most common damage sources. WARNING: May cause organ damage."
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list( /datum/reagent/medicine/epinephrine = 8, /datum/reagent/medicine/c2/aiuri = 8, /datum/reagent/medicine/c2/libital = 8, /datum/reagent/medicine/leporazine = 6)

/obj/item/reagent_containers/hypospray/medipen/survival/inject(mob/living/affected_mob, mob/user)
	if(lavaland_equipment_pressure_check(get_turf(user)))
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
		return ..()

	if(DOING_INTERACTION(user, DOAFTER_SOURCE_SURVIVALPEN))
		to_chat(user,span_notice("You are too busy to use \the [src]!"))
		return

	to_chat(user,span_notice("You start manually releasing the low-pressure gauge..."))
	if(!do_after(user, 10 SECONDS, affected_mob, interaction_key = DOAFTER_SOURCE_SURVIVALPEN))
		return

	amount_per_transfer_from_this = initial(amount_per_transfer_from_this) * 0.5
	return ..()


/obj/item/reagent_containers/hypospray/medipen/survival/luxury
	name = "luxury medipen"
	desc = "Cutting edge bluespace technology allowed Nanotrasen to compact 60u of volume into a single medipen. Contains rare and powerful chemicals used to aid in exploration of very hard environments. WARNING: DO NOT MIX WITH EPINEPHRINE OR ATROPINE."
	icon_state = "luxpen"
	inhand_icon_state = "atropen"
	base_icon_state = "luxpen"
	volume = 60
	amount_per_transfer_from_this = 60
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/c2/penthrite = 10, /datum/reagent/medicine/oxandrolone = 10, /datum/reagent/medicine/sal_acid = 10 ,/datum/reagent/medicine/omnizine = 10 ,/datum/reagent/medicine/leporazine = 10)

/obj/item/reagent_containers/hypospray/medipen/survival/luxury/purple
	name = "luxury purple medipen"
	desc = "Cutting edge bluespace technology allowed Nanotrasen to compact 60u of volume into a single medipen. Contains rare and powerful chemicals used to aid in exploration of very hard environments. This one is purple. WARNING: DO NOT MIX WITH EPINEPHRINE OR ATROPINE."
	icon_state = "slimepen"
	base_icon_state = "slimepen"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/c2/penthrite = 10, /datum/reagent/medicine/oxandrolone = 10, /datum/reagent/medicine/sal_acid = 10 ,/datum/reagent/medicine/regen_jelly/diluted = 5 ,/datum/reagent/toxin = 5 ,/datum/reagent/medicine/leporazine = 10)

/obj/item/reagent_containers/hypospray/medipen/survival/luxury/purple/Initialize(mapload)
	. = ..()
	if(prob(0.1)) // idea by melbert
		name = "luxury ourple medipen"
		desc = replacetext(desc, "purple", "ourple") // i do not feel like copy-pasting the entire desc for a one-word change

/obj/item/reagent_containers/hypospray/medipen/atropine
	name = "阿托品自动注射器"
	desc = "迅速挽救危重伤员！另含强效促凝血剂，可防止失血。"
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/atropine = 10, /datum/reagent/medicine/coagulant = 2)
	volume = 12

/obj/item/reagent_containers/hypospray/medipen/snail
	name = "snail shot"
	desc = "All-purpose snail medicine! Do not use on non-snails!"
	icon_state = "snail"
	inhand_icon_state = "snail"
	base_icon_state = "snail"
	list_reagents = list(/datum/reagent/snail = 10)
	label_examine = FALSE
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/magillitis
	name = "experimental autoinjector"
	desc = "A custom-frame needle injector with a small single-use reservoir, containing an experimental serum. Unlike the more common medipen frame, it cannot pierce through protective armor or space suits, nor can the chemical inside be extracted."
	icon_state = "gorillapen"
	inhand_icon_state = "gorillapen"
	base_icon_state = "gorillapen"
	volume = 5
	ignore_flags = 0
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/hypospray/medipen/pumpup
	name = "maintenance pump-up"
	desc = "A ghetto looking autoinjector filled with a cheap adrenaline shot... Great for shrugging off the effects of stunbatons."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/drug/pumpup = 15)
	icon_state = "maintenance"
	base_icon_state = "maintenance"
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/ekit
	name = "emergency first-aid autoinjector"
	desc = "An epinephrine medipen with extra coagulant and antibiotics to help stabilize bad cuts and burns."
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 12, /datum/reagent/medicine/coagulant = 2.5, /datum/reagent/medicine/spaceacillin = 0.5)

/obj/item/reagent_containers/hypospray/medipen/blood_loss
	name = "hypovolemic-response autoinjector"
	desc = "A medipen designed to stabilize and rapidly reverse severe bloodloss."
	icon_state = "hypovolemic"
	base_icon_state = "hypovolemic"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 5, /datum/reagent/medicine/coagulant = 2.5, /datum/reagent/iron = 3.5, /datum/reagent/medicine/salglu_solution = 4)

/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone autoinjector"
	desc = "A mutadone medipen to assist in curing genetic errors in one single injector."
	icon_state = "penacid"
	inhand_icon_state = "penacid"
	base_icon_state = "penacid"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/mutadone = 15)

/obj/item/reagent_containers/hypospray/medipen/penthrite
	name = "penthrite autoinjector"
	desc = "Experimental heart medication."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/c2/penthrite = 10)
	volume = 10

/obj/structure/retail/occult
	icon_state = "menu"
	owner_needed = FALSE
	desc = "用你的神秘学研究成果换取珍藏的知识与遗物。"

	products_list = list(
	// SPELLBOOKS
	new /datum/data/vending_product("诱焰之道法术书（I 级）",	/obj/item/path_spellbook/lure_of_flames/level1,	130),
	new /datum/data/vending_product("诱焰之道法术书（II 级）",	/obj/item/path_spellbook/lure_of_flames/level2,	180),
	new /datum/data/vending_product("诱焰之道法术书（III 级）",	/obj/item/path_spellbook/lure_of_flames/level3,	210),
	new /datum/data/vending_product("诱焰之道法术书（IV 级）",	/obj/item/path_spellbook/lure_of_flames/level4,	240),
	new /datum/data/vending_product("诱焰之道法术书（V 级）",	/obj/item/path_spellbook/lure_of_flames/level5,	270),

	new /datum/data/vending_product("雷霆之道法术书（I 级）",	/obj/item/path_spellbook/levinbolt/level1,	130),
	new /datum/data/vending_product("雷霆之道法术书（II 级）",	/obj/item/path_spellbook/levinbolt/level2,	180),
	new /datum/data/vending_product("雷霆之道法术书（III 级）",	/obj/item/path_spellbook/levinbolt/level3,	210),
	new /datum/data/vending_product("雷霆之道法术书（IV 级）",	/obj/item/path_spellbook/levinbolt/level4,	240),
	new /datum/data/vending_product("雷霆之道法术书（V 级）",	/obj/item/path_spellbook/levinbolt/level5, 270),

	// ARTIFACTS
	// Lower tier artifacts
	new /datum/data/vending_product("威卡帕格蓟", /obj/item/occult_artifact/vampire/weekapaug_thistle, 75),
	new /datum/data/vending_product("裹尸布灵器", /obj/item/occult_artifact/vampire/mummywrap_fetish, 70),
	new /datum/data/vending_product("加尔朱姆", /obj/item/occult_artifact/vampire/galdjum, 70),
	new /datum/data/vending_product("血星", /obj/item/occult_artifact/vampire/bloodstar, 70),

	// Mid tier artifacts
	new /datum/data/vending_product("妖精护符", /obj/item/occult_artifact/vampire/fae_charm, 120),
	new /datum/data/vending_product("戴蒙诺里", /obj/item/occult_artifact/vampire/daimonori, 120),
	new /datum/data/vending_product("阿拉穆特之钥", /obj/item/occult_artifact/vampire/key_of_alamut, 130),
	new /datum/data/vending_product("伊莱莎之心", /obj/item/occult_artifact/vampire/heart_of_eliza, 140),
	new /datum/data/vending_product("血石", /obj/item/occult_artifact/vampire/bloodstone, 140),

	// High tier artifacts
	new /datum/data/vending_product("憎恶之杯", /obj/item/occult_artifact/vampire/odious_chalice, 180),

)

/obj/structure/retail/occult/New()
	. = ..()
	//each item starts with 2 in stock
	for(var/datum/data/vending_product/prize in products_list)
		prize.amount = 2
		prize.max_amount = 10

// are they antitribu?
/obj/structure/retail/occult/proc/has_purchase_privileges(datum/job/job)
	return is_type_in_list(job, list(
		/datum/job/vampire/regent,
		/datum/job/vampire/archivist,
		/datum/job/vampire/hound,
		/datum/job/vampire/sheriff,
		/datum/job/vampire/clerk,
		/datum/job/vampire/prince)
	)

// find the regent
/obj/structure/retail/occult/proc/find_regent()
	for(var/mob/living/carbon/human/human_user in GLOB.human_list)
		if(istype(human_user.mind?.assigned_role, /datum/job/vampire/regent))
			return human_user
	return null

// find all archivists
/obj/structure/retail/occult/proc/find_archivists()
	var/list/archivists = list()
	for(var/mob/living/carbon/human/human_user in GLOB.human_list)
		if(istype(human_user.mind?.assigned_role, /datum/job/vampire/archivist))
			archivists += human_user
	return archivists

// Non-Chantry non-Camarilla Tremeres, when spending their research points, give 30% of their purchase to the Regent, or distributed among all archivists
/obj/structure/retail/occult/proc/distribute_research_points(amount, purchaser_name, item_name)
	var/tribute_amount = round(amount * 0.3)
	var/mob/living/carbon/human/regent = find_regent()

	if(regent)
		regent.research_points += tribute_amount
		to_chat(regent, span_notice("[purchaser_name]购买了[item_name]，档案库将其中[tribute_amount]研究点转交给了你。"))
		return

	var/list/archivists = find_archivists()
	if(archivists.len > 0)
		var/points_per_archivist = round(tribute_amount / archivists.len)
		var/remaining_points = tribute_amount - (points_per_archivist * archivists.len)

		for(var/mob/living/carbon/human/archivist in archivists)
			var/points_to_give = points_per_archivist
			if(remaining_points > 0)
				points_to_give++
				remaining_points--
			archivist.research_points += points_to_give
			to_chat(archivist, span_notice("[purchaser_name]购买了[item_name]，档案库从中分配了[points_to_give]研究点给你。"))

/obj/structure/retail/occult/proc/increment_stock(item_path)
	for(var/datum/data/vending_product/prize in products_list)
		if(prize.product_path == item_path)
			prize.amount = min(prize.amount + 1, prize.max_amount)
			return

// SpellbookVendor.jsx in tgui/interfaces
/obj/structure/retail/occult/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SpellbookVendor", name)
		ui.open()

/obj/structure/retail/occult/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		.["user"]["points"] = human_user.research_points
		.["user"]["name"] = "[human_user.real_name]"
		.["user"]["job"] = "[JOB_DISPLAY_NAME(human_user.mind?.assigned_role.title)]"
		.["user"]["has_thaumaturgy"] = !!human_user.get_discipline(/datum/discipline/thaumaturgy)
		.["user"]["has_necromancy"] = !!human_user.get_discipline(/datum/discipline/necromancy)
		.["user"]["is_regent"] = istype(human_user.mind?.assigned_role, /datum/job/vampire/regent)
		.["user"]["has_privileges"] = has_purchase_privileges(human_user.mind?.assigned_role)
	else
		.["user"]["points"] = 0
		.["user"]["name"] = "未知"
		.["user"]["job"] = "未知"
		.["user"]["has_thaumaturgy"] = FALSE
		.["user"]["has_necromancy"] = FALSE
		.["user"]["is_regent"] = FALSE
		.["user"]["has_privileges"] = FALSE

	.["tremere_members"] = list()
	for(var/mob/living/carbon/human/tremere_member in GLOB.human_list)
		if(!tremere_member.mind)
			continue
		var/datum/job/role = tremere_member.mind.assigned_role
		if(is_type_in_list(role, list(/datum/job/vampire/archivist, /datum/job/vampire/gargoyle, /datum/job/vampire/regent)))
			.["tremere_members"] += list(list(
				"name" = tremere_member.real_name,
				"role" = JOB_DISPLAY_NAME(role.title),
				"points" = tremere_member.research_points,
				"ref" = "\ref[tremere_member]"
			))


	.["product_records"] = list()
	for(var/datum/data/vending_product/prize in products_list)
		var/stock_count = prize.amount
		var/obj/item/product_item = prize.product_path
		var/list/product_data = list(
			path = replacetext(replacetext("[prize.product_path]", "/obj/item/", ""), "/", "-"),
			name = prize.name,
			price = prize.price,
			ref = REF(prize),
			stock = stock_count,
			available = (stock_count > 0),
			icon = initial(product_item.icon),
			icon_state = initial(product_item.icon_state)
		)
		.["product_records"] += list(product_data)

/obj/structure/retail/occult/ui_act(action, params)
	if(action == "transfer_points")
		return handle_point_transfer(action, params)
	if(action == "seize_points")
		return handle_point_seizure(action, params)
	if(action != "purchase")
		return ..()

	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/human_user = usr

	if(!get_kindred_splat(usr))
		return

	var/datum/data/vending_product/prize = locate(params["ref"]) in products_list
	var/current_stock = prize.amount
	if(current_stock <= 0)
		to_chat(usr, span_alert("错误：[prize.name]已售罄！"))
		return

	if(prize.price > human_user.research_points)
		to_chat(usr, span_alert("错误：研究点不足，无法购买[prize.name]！你需要[prize.price]研究点。"))
		return

	human_user.research_points -= prize.price

	// Check if user is loyal to the chantry/camarilla - if not, award 30% tribute to leadership
	var/datum/job/user_role = human_user.mind?.assigned_role
	var/has_privileges = has_purchase_privileges(user_role)

	if(!has_privileges)
		distribute_research_points(prize.price, human_user.real_name, prize.name)
		to_chat(usr, span_notice("你的一部分研究点经由档案库流向秘所领导层，作为贡赋。"))

	prize.amount -= 1

	to_chat(usr, span_notice("档案库散发着黑暗能量，将[prize.name]送到你面前！"))
	new prize.product_path(loc)
	return TRUE

//transfer research points
/obj/structure/retail/occult/proc/handle_point_transfer(action, params)
	if(!ishuman(usr))
		return FALSE

	var/mob/living/carbon/human/sender = usr
	var/target_ref = params["target_ref"]
	var/amount = text2num(params["amount"])

	if(!target_ref || !amount || amount <= 0)
		to_chat(sender, span_alert("错误：转移参数无效！"))
		return FALSE

	if(amount > sender.research_points)
		to_chat(sender, span_alert("你的研究点不足！"))
		return FALSE

	var/mob/living/carbon/human/target = locate(target_ref)

	sender.research_points -= amount
	target.research_points += amount

	to_chat(sender, span_notice("你通过档案库的黑暗通道，将[amount]研究点转移给了[target.real_name]。"))
	to_chat(target, span_notice("档案库向你低语……[sender.real_name]给你转来了[amount]研究点。"))

	return TRUE

//research point seizure
/obj/structure/retail/occult/proc/handle_point_seizure(action, params)
	if(!ishuman(usr))
		return FALSE

	var/mob/living/carbon/human/regent = usr

	if(!istype(regent.mind?.assigned_role, /datum/job/vampire/regent))
		to_chat(regent, span_alert("只有秘所摄政才能行使这项权力！"))
		return FALSE

	var/target_ref = params["target_ref"]
	var/amount = text2num(params["amount"])

	if(!target_ref || !amount || amount <= 0)
		to_chat(regent, span_alert("错误：征收参数无效！"))
		return FALSE

	var/mob/living/carbon/human/target = locate(target_ref)

	var/actual_amount = min(amount, target.research_points)

	if(actual_amount <= 0)
		to_chat(regent, span_alert("目标没有可供征收的研究点！"))
		return FALSE

	target.research_points -= actual_amount
	regent.research_points += actual_amount

	to_chat(regent, span_notice("你行使秘所摄政的权力，通过档案库从[target.real_name]处征收了[actual_amount]研究点。"))
	to_chat(target, span_warning("档案库变得冰冷……秘所摄政[regent.real_name]凭借职权征收了你的[actual_amount]研究点。"))

	return TRUE

//offer artifacts to the shop for research points AND increment stock
/obj/structure/retail/occult/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/occult_artifact))
		var/obj/item/occult_artifact/artifact = tool

		if(!ishuman(user))
			return ITEM_INTERACT_BLOCKING

		var/mob/living/carbon/human/human_user = user

		if(artifact.research_value <= 0)
			to_chat(user, span_warning("档案库认为这件遗物毫无价值。"))
			return ITEM_INTERACT_BLOCKING

		human_user.research_points += artifact.research_value

		increment_stock(artifact.type)

		//when donating an artifact, increase stock of a random spellbook
		increment_stock(pick(
			/obj/item/path_spellbook/lure_of_flames/level1,
			/obj/item/path_spellbook/lure_of_flames/level2,
			/obj/item/path_spellbook/lure_of_flames/level3,
			/obj/item/path_spellbook/lure_of_flames/level4,
			/obj/item/path_spellbook/lure_of_flames/level5,
			/obj/item/path_spellbook/levinbolt/level1,
			/obj/item/path_spellbook/levinbolt/level2,
			/obj/item/path_spellbook/levinbolt/level3,
			/obj/item/path_spellbook/levinbolt/level4,
			/obj/item/path_spellbook/levinbolt/level5))

		if(artifact.research_value >= 20)
			to_chat(user, span_nicegreen("档案库贪婪地吞下这件强大的遗物，将其纳入收藏，并给予你[artifact.research_value]研究点！"))
		else if(artifact.research_value >= 10)
			to_chat(user, span_notice("档案库吸收了遗物的精华，将其中的知识编目归档，并给予你[artifact.research_value]研究点。"))
		else
			to_chat(user, span_notice("档案库勉强收下这件不起眼的遗物，将其归档，并给予你[artifact.research_value]研究点。"))

		qdel(artifact)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/path_spellbook))
		var/obj/item/path_spellbook/spellbook = tool

		if(!ishuman(user))
			return ITEM_INTERACT_BLOCKING

		var/mob/living/carbon/human/human_user = user

		var/research_reward = 5 // base reward modified by spellbook
		human_user.research_points += research_reward

		increment_stock(spellbook.type)

		to_chat(user, span_notice("档案库收下了你的法术书，将其中的知识纳入收藏，并给予你[research_reward]研究点。"))

		qdel(spellbook)
		return ITEM_INTERACT_SUCCESS


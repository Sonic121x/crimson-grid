/obj/structure/dresser
	name = "衣柜"
	desc = "一个做工精良的木制衣柜，里面装满了各式内衣。"
	icon = 'modular_darkpack/master_files/icons/obj/fluff/general.dmi' // DARKPACK EDIT CHANGE
	icon_state = "dresser"
	resistance_flags = FLAMMABLE
	density = TRUE
	anchored = TRUE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)
GLOBAL_LIST_INIT(localized_dresser_styles, list("Nude" = "不穿", "Briefs" = "三角内裤", "Boxers" = "平角内裤", "Striped Boxers" = "条纹平角内裤", "Midway Boxers" = "中长平角内裤", "Long Johns" = "长款保暖内裤", "Jockstrap" = "护裆内裤", "Mankini" = "男式比基尼", "Hearts Boxers" = "爱心平角内裤", "Commie Boxers" = "共产主义平角内裤", "Freedom Boxers" = "自由旗帜平角内裤", "UK Boxers" = "英国旗帜平角内裤", "Bikini" = "比基尼", "Lace Bikini" = "蕾丝比基尼", "Bralette w/ Boyshorts" = "软罩文胸配平角内裤", "Sports Bra w/ Boyshorts" = "运动文胸配平角内裤", "Thong" = "丁字裤", "Strapless Bikini" = "无肩带比基尼", "Babydoll" = "娃娃款睡裙", "One-Piece Swimsuit" = "连体泳衣", "Strapless One-Piece Swimsuit" = "无肩带连体泳衣", "Two-Piece Swimsuit" = "分体泳衣", "Strapless Two-Piece Swimsuit" = "无肩带分体泳衣", "Strapless Striped Swimsuit" = "无肩带条纹泳衣", "Halter Swimsuit" = "挂脖泳衣", "Neko Bikini (White)" = "猫咪比基尼（白色）", "Neko Bikini (Black)" = "猫咪比基尼（黑色）", "Commie Bikini" = "共产主义比基尼", "Freedom Bikini" = "自由旗帜比基尼", "UK Bikini" = "英国旗帜比基尼", "Lingerie" = "情趣内衣", "Jersey (Blue)" = "球衣（蓝色）", "Jersey (Red)" = "球衣（红色）", "Polo Shirt (Blue)" = "翻领运动衫（蓝色）", "Polo Shirt (Gray-Yellow)" = "翻领运动衫（灰黄）", "Polo Shirt (Red)" = "翻领运动衫（红色）", "Polo Shirt (White)" = "翻领运动衫（白色）", "Shirt (Alien)" = "衬衣（外星人）", "Shirt (Band)" = "衬衣（乐队）", "Shirt (Black)" = "衬衣（黑色）", "Shirt (Blue)" = "衬衣（蓝色）", "Shirt (Clown)" = "衬衣（小丑）", "Shirt (Commie)" = "衬衣（共产主义）", "Shirt (Green)" = "衬衣（绿色）", "Shirt (Grey)" = "衬衣（灰色）", "Shirt (Ian)" = "衬衣（伊恩）", "Shirt (I Love NT)" = "衬衣（我爱纳诺传讯）", "Shirt (Lover)" = "衬衣（爱人）", "Shirt (Matroska)" = "衬衣（水手条纹）", "Shirt (Meat)" = "衬衣（肉）", "Shirt (Nanotrasen)" = "衬衣（纳诺传讯）", "Shirt (Peace)" = "衬衣（和平）", "Shirt (Pogoman)" = "衬衣（弹簧人）", "Shirt (Question)" = "衬衣（问号）", "Shirt (Red)" = "衬衣（红色）", "Shirt (Skull)" = "衬衣（骷髅）", "Shirt (SS13)" = "衬衣（SS13）", "Shirt (Striped)" = "衬衣（条纹）", "Shirt (Tie-dye)" = "衬衣（扎染）", "Shirt (UK)" = "衬衣（英国）", "Shirt (USA)" = "衬衣（美国）", "Shirt (White)" = "衬衣（白色）", "Short-sleeved Shirt (Black)" = "短袖衬衣（黑色）", "Short-sleeved Shirt (Blue)" = "短袖衬衣（蓝色）", "Short-sleeved Shirt (Green)" = "短袖衬衣（绿色）", "Short-sleeved Shirt (Purple)" = "短袖衬衣（紫色）", "Short-sleeved Shirt (White)" = "短袖衬衣（白色）", "Sports Bra" = "运动文胸", "Sports Bra (Alt)" = "运动文胸（另一款）", "Sports Shirt (Blue)" = "运动衫（蓝色）", "Sports Shirt (Green)" = "运动衫（绿色）", "Sports Shirt (Red)" = "运动衫（红色）", "Tank Top (Black)" = "背心（黑色）", "Tank Top (Fire)" = "背心（火焰）", "Tank Top (Grey)" = "背心（灰色）", "Tank Top (Midriff)" = "背心（露腹）", "Tank Top (Red)" = "背心（红色）", "Tank Top (Striped)" = "背心（条纹）", "Tank Top (White)" = "背心（白色）", "Top (Red)" = "上衣（红色）", "Top (White)" = "上衣（白色）", "T-Shirt (Blue)" = "T恤（蓝色）", "T-Shirt (Green)" = "T恤（绿色）", "T-Shirt (Red)" = "T恤（红色）", "T-Shirt (Yellow)" = "T恤（黄色）", "Knee-high (Ace)" = "及膝袜（无性恋旗帜）", "Knee-high (Bee)" = "及膝袜（蜜蜂）", "Knee-high (Black)" = "及膝袜（黑色）", "Knee-High (Commie)" = "及膝袜（共产主义）", "Knee-High (Freedom)" = "及膝袜（自由旗帜）", "Knee-high (Rainbow)" = "及膝袜（彩虹）", "Knee-high (Striped)" = "及膝袜（条纹）", "Knee-high (Thin)" = "及膝袜（薄款）", "Knee-high (Trans)" = "及膝袜（跨性别旗帜）", "Knee-High (UK)" = "及膝袜（英国旗帜）", "Knee-high (White)" = "及膝袜（白色）", "Knee-high (Fishnet)" = "及膝袜（网眼）", "Normal (Black)" = "普通袜（黑色）", "Normal (White)" = "普通袜（白色）", "Pantyhose" = "连裤袜", "Short (Black)" = "短袜（黑色）", "Short (White)" = "短袜（白色）", "Stockings (Blue)" = "长袜（蓝色）", "Stockings (Cyan)" = "长袜（青色）", "Stockings (Dark Pink)" = "长袜（深粉色）", "Stockings (Green)" = "长袜（绿色）", "Stockings (Orange)" = "长袜（橙色）", "Stockings (Programmer)" = "长袜（程序员）", "Stockings (Purple)" = "长袜（紫色）", "Stockings (Yellow)" = "长袜（黄色）", "Stockings (Fishnet)" = "长袜（网眼）", "Thigh-high (Ace)" = "过膝袜（无性恋旗帜）", "Thigh-high (Bee)" = "过膝袜（蜜蜂）", "Thigh-high (Black)" = "过膝袜（黑色）", "Thigh-high (Commie)" = "过膝袜（共产主义）", "Thigh-high (Freedom)" = "过膝袜（自由旗帜）", "Thigh-high (Rainbow)" = "过膝袜（彩虹）", "Thigh-high (Striped)" = "过膝袜（条纹）", "Thigh-high (Thin)" = "过膝袜（薄款）", "Thigh-high (Trans)" = "过膝袜（跨性别旗帜）", "Thigh-high (UK)" = "过膝袜（英国旗帜）", "Thigh-high (White)" = "过膝袜（白色）", "Thigh-high (Fishnet)" = "过膝袜（网眼）", "Thocks" = "索克斯袜"))
/obj/structure/dresser/wrench_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("你开始用扳手[anchored ? "松开" : "拧紧"][src]的固定螺栓。"))
	if(!tool.use_tool(src, user, 20, volume=50))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你成功用扳手[anchored ? "松开" : "拧紧"]了[src]的固定螺栓。"))
	set_anchored(!anchored)
	return ITEM_INTERACT_SUCCESS

/obj/structure/dresser/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
/obj/structure/dresser/proc/select_style(mob/user, message, list/styles) { var/list/choices = list(); for(var/style in styles) { choices[GLOB.localized_dresser_styles[style] || style] = style; }; return choices[tgui_input_list(user, message, "更衣", choices)]; }
/obj/structure/dresser/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))//no tele-grooming
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/dressing_human = user
	if(HAS_TRAIT(dressing_human, TRAIT_NO_UNDERWEAR))
		to_chat(dressing_human, span_warning("你无法穿着内衣。"))
		return

	var/choice = tgui_input_list(user, "要更换内衣、衬衣还是袜子？", "更衣", list("内衣","内衣颜色","衬衣","袜子"))
	if(isnull(choice))
		return

	if(!Adjacent(user))
		return
	switch(choice)
		if("内衣")
			var/new_undies = select_style(user, "选择内衣", SSaccessories.underwear_list)
			if(new_undies)
				dressing_human.underwear = new_undies
		if("内衣颜色")
			var/new_underwear_color = tgui_color_picker(dressing_human, "选择内衣颜色", "内衣颜色", dressing_human.underwear_color)
			if(new_underwear_color)
				dressing_human.underwear_color = sanitize_hexcolor(new_underwear_color)
		if("衬衣")
			var/new_undershirt = select_style(user, "选择衬衣", SSaccessories.undershirt_list)
			if(new_undershirt)
				dressing_human.undershirt = new_undershirt
		if("袜子")
			var/new_socks = select_style(user, "选择袜子", SSaccessories.socks_list)
			if(new_socks)
				dressing_human.socks = new_socks

	add_fingerprint(dressing_human)
	dressing_human.update_body()

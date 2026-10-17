/**
 * # Action system
 *
 * A simple base for an modular behavior attached to atom or datum.
 */
/datum/action
	var/static/list/localized_mob_action_names = list("Lava Swoop" = "熔岩俯冲", "Meteors" = "陨石雨", "Standard Mob Cooldown Ability" = "标准生物冷却能力", "Command Star Gazer" = "指挥观星者", "Personality Commune" = "人格交流", "Projectile Attack" = "弹体攻击", "Rapid Fire" = "连射", "Shrapnel Fire" = "破片射击", "Strong Shrapnel Fire" = "强化破片射击", "Spiral Shots" = "螺旋射击", "All Directions" = "全向射击", "Shotgun Fire" = "霰弹射击", "Alternating Shotgun Fire" = "交替霰弹射击", "Circular Shotgun Fire" = "环形霰弹射击", "Directional Shots" = "定向射击", "Alternating Shots" = "交替射击", "Fire Kinetic Accelerator" = "发射动能加速器", "Titan's Finale" = "泰坦终幕", "Wave Shots" = "波状射击", "Sign Language" = "手语", "Sneak" = "潜行", "Teleport" = "传送", "Dashing And Attacking" = "冲刺攻击", "Direct And AoE Firing" = "直射与范围射击", "Join" = "回到宿主身边", "Hide" = "隐藏", "Show" = "显现", "Echolocation Focus" = "回声定位聚焦", "Listen Prayers" = "聆听祈祷", "Pump your blood" = "主动泵血", "Force Contract" = "强制收缩", "MMI Talk" = "人机接口传话", "Toggle Seethrough" = "切换身体透视", "Toggle" = "切换", "Toggle Hood" = "收放兜帽", "Adrenaline!" = "激发肾上腺素！", "Mindread" = "读心术", "Drop a limb" = "舍弃肢体", "Create Snow" = "造雪", "Cryobeam" = "寒冰射线", "Farsight" = "远视", "Create Ash" = "造灰", "Pyrobeam" = "烈焰射线", "Remember the Scent" = "记住气味", "Activate Thermal Vision" = "启用热成像视觉", "Launch spike" = "发射舌刺", "Launch chem spike" = "发射药剂尖刺", "Transfer Chemicals" = "转移药剂", "Shock Touch" = "电击之触", "Mending Touch" = "愈合之触", "Invoke Void" = "召唤虚空", "Convoke Void" = "召集虚空")
	var/name = "Generic Action"
	/// The description of what the action does, shown in button tooltips
	var/desc
	/// The target the action is attached to. If the target datum is deleted, the action is as well.
	/// Set in New() via the proc link_to(). PLEASE set a target if you're making an action
	var/datum/target
	/// Where any buttons we create should be by default. Accepts screen_loc and location defines
	var/default_button_position = SCRN_OBJ_IN_LIST
	/// This is who currently owns the action, and most often, this is who is using the action if it is triggered
	/// This can be the same as "target" but is not ALWAYS the same - this is set and unset with Grant() and Remove()
	var/mob/owner
	/// If False, the owner of this action does not get a hud and cannot activate it on their own
	var/owner_has_control = TRUE
	/// Flags that will determine of the owner / user of the action can... use the action
	var/check_flags = NONE
	/// Whether the button becomes transparent when it can't be used, or just reddened
	var/transparent_when_unavailable = TRUE
	///List of all mobs that are viewing our action button -> A unique movable for them to view.
	var/list/viewers = list()
	/// If TRUE, this action button will be shown to observers / other mobs who view from this action's owner's eyes.
	/// Used in [/mob/proc/show_other_mob_action_buttons]
	var/show_to_observers = TRUE
	/// If observers can click this action at any time, regardless of the owner
	var/allow_observer_click = FALSE

	/// The style the button's tooltips appear to be
	var/buttontooltipstyle = ""

	/// This is the file for the BACKGROUND underlay icon of the button
	var/background_icon = 'modular_darkpack/master_files/icons/mob/actions/backgrounds.dmi' // DARKPACK EDIT CHANGE
	/// This is the icon state state for the BACKGROUND underlay icon of the button
	/// (If set to ACTION_BUTTON_DEFAULT_BACKGROUND, uses the hud's default background)
	var/background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND

	/// This is the file for the icon that appears on the button
	var/button_icon = 'icons/hud/actions.dmi'
	/// This is the icon state for the icon that appears on the button
	var/button_icon_state = "default"

	/// This is the file for any FOREGROUND overlay icons on the button (such as borders)
	var/overlay_icon = 'modular_darkpack/master_files/icons/mob/actions/backgrounds.dmi' // DARKPACK EDIT CHANGE
	/// This is the icon state for any FOREGROUND overlay icons on the button (such as borders)
	var/overlay_icon_state

	/// full key we are bound to
	var/full_key

	/// Toggles whether this action is usable or not
	var/action_disabled = FALSE
	/// Can this action be shared with our rider?
	var/can_be_shared = TRUE

/datum/action/New(Target)
	link_to(Target)

/// Links the passed target to our action, registering any relevant signals
/datum/action/proc/link_to(Target)
	target = Target
	RegisterSignal(target, COMSIG_QDELETING, PROC_REF(clear_ref), override = TRUE)

	if(isatom(target))
		RegisterSignal(target, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_target_icon_update))

	if(istype(target, /datum/mind))
		RegisterSignal(target, COMSIG_MIND_TRANSFERRED, PROC_REF(on_target_mind_swapped))

/datum/action/Destroy()
	if(owner)
		Remove(owner)
	target = null
	QDEL_LIST_ASSOC_VAL(viewers) // Qdel the buttons in the viewers list **NOT THE HUDS**
	return ..()

/// Signal proc that clears any references based on the owner or target deleting
/// If the owner's deleted, we will simply remove from them, but if the target's deleted, we will self-delete
/datum/action/proc/clear_ref(datum/ref)
	SIGNAL_HANDLER
	if(ref == owner)
		Remove(owner)
	if(ref == target)
		qdel(src)

/// Grants the action to the passed mob, making it the owner
/datum/action/proc/Grant(mob/grant_to)
	if(isnull(grant_to))
		Remove(owner)
		return
	if(grant_to == owner)
		return // We already have it
	var/mob/previous_owner = owner
	owner = grant_to
	if(!isnull(previous_owner))
		Remove(previous_owner)
	SEND_SIGNAL(src, COMSIG_ACTION_GRANTED, owner)
	SEND_SIGNAL(owner, COMSIG_MOB_GRANTED_ACTION, src)
	RegisterSignal(owner, COMSIG_QDELETING, PROC_REF(clear_ref), override = TRUE)

	// Register some signals based on our check_flags
	// so that our button icon updates when relevant
	if(check_flags & AB_CHECK_CONSCIOUS)
		RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(update_status_on_signal))
	if(check_flags & AB_CHECK_INCAPACITATED)
		RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_INCAPACITATED), SIGNAL_REMOVETRAIT(TRAIT_INCAPACITATED)), PROC_REF(update_status_on_signal))
	if(check_flags & AB_CHECK_IMMOBILE)
		RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_IMMOBILIZED), SIGNAL_REMOVETRAIT(TRAIT_IMMOBILIZED)), PROC_REF(update_status_on_signal))
	if(check_flags & AB_CHECK_HANDS_BLOCKED)
		RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_HANDS_BLOCKED), SIGNAL_REMOVETRAIT(TRAIT_HANDS_BLOCKED)), PROC_REF(update_status_on_signal))
	if(check_flags & AB_CHECK_LYING)
		RegisterSignal(owner, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(update_status_on_signal))
	if(check_flags & AB_CHECK_PHASED)
		RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_MAGICALLY_PHASED), SIGNAL_REMOVETRAIT(TRAIT_MAGICALLY_PHASED)), PROC_REF(update_status_on_signal))
	if(check_flags & AB_CHECK_OPEN_TURF)
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(update_status_on_signal))
	if(owner_has_control)
		RegisterSignal(grant_to, COMSIG_MOB_KEYDOWN, PROC_REF(keydown), override = TRUE)
		GiveAction(grant_to)

/// Remove the passed mob from being owner of our action
/datum/action/proc/Remove(mob/remove_from)
	SHOULD_CALL_PARENT(TRUE)

	for(var/datum/hud/hud in viewers)
		if(!hud.mymob)
			continue
		HideFrom(hud.mymob)
	LAZYREMOVE(remove_from?.actions, src) // We aren't always properly inserted into the viewers list, gotta make sure that action's cleared
	viewers = list()
	UnregisterSignal(remove_from, COMSIG_MOB_KEYDOWN)

	if(isnull(remove_from))
		return
	SEND_SIGNAL(src, COMSIG_ACTION_REMOVED, remove_from)
	SEND_SIGNAL(remove_from, COMSIG_MOB_REMOVED_ACTION, src)
	UnregisterSignal(remove_from, COMSIG_QDELETING)

	// Clean up our check_flag signals
	UnregisterSignal(remove_from, list(
		COMSIG_LIVING_SET_BODY_POSITION,
		COMSIG_MOB_STATCHANGE,
		COMSIG_MOVABLE_MOVED,
		SIGNAL_ADDTRAIT(TRAIT_HANDS_BLOCKED),
		SIGNAL_ADDTRAIT(TRAIT_IMMOBILIZED),
		SIGNAL_ADDTRAIT(TRAIT_INCAPACITATED),
		SIGNAL_ADDTRAIT(TRAIT_MAGICALLY_PHASED),
		SIGNAL_REMOVETRAIT(TRAIT_HANDS_BLOCKED),
		SIGNAL_REMOVETRAIT(TRAIT_IMMOBILIZED),
		SIGNAL_REMOVETRAIT(TRAIT_INCAPACITATED),
		SIGNAL_REMOVETRAIT(TRAIT_MAGICALLY_PHASED),
	))

	if(target == remove_from)
		RegisterSignal(target, COMSIG_QDELETING, PROC_REF(clear_ref))
	if (owner == remove_from)
		owner = null

/// Actually triggers the effects of the action.
/// Called when the on-screen button is clicked, for example.
/datum/action/proc/Trigger(mob/clicker, trigger_flags)
	SHOULD_CALL_PARENT(TRUE)
	if(!(trigger_flags & TRIGGER_FORCE_AVAILABLE) && !IsAvailable(feedback = TRUE))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER, src) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	return TRUE

/**
 * Whether our action is currently available to use or not
 * * feedback - If true this is being called to check if we have any messages to show to the owner
 */
/datum/action/proc/IsAvailable(feedback = FALSE)
	if(!owner)
		return FALSE
	if(action_disabled)
		return FALSE
	if((check_flags & AB_CHECK_CONSCIOUS) && IS_UNCONSCIOUS_OR_CRIT(owner))
		if (feedback)
			if(owner.stat == DEAD)
				owner.balloon_alert(owner, "已死亡！")
			else if(IS_UNCONSCIOUS(owner))
				owner.balloon_alert(owner, "昏迷中！")
			else
				owner.balloon_alert(owner, "处于濒危状态！")
		return FALSE
	if((check_flags & AB_CHECK_HANDS_BLOCKED) && HAS_TRAIT(owner, TRAIT_HANDS_BLOCKED))
		if (feedback)
			owner.balloon_alert(owner, "双手受阻！")
		return FALSE
	if((check_flags & AB_CHECK_IMMOBILE) && HAS_TRAIT(owner, TRAIT_IMMOBILIZED))
		if (feedback)
			owner.balloon_alert(owner, "无法移动！")
		return FALSE
	if((check_flags & AB_CHECK_INCAPACITATED) && HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		if (feedback)
			owner.balloon_alert(owner, "无法行动！")
		return FALSE
	if((check_flags & AB_CHECK_LYING) && isliving(owner))
		var/mob/living/action_owner = owner
		if(action_owner.body_position == LYING_DOWN)
			if (feedback)
				owner.balloon_alert(owner, "必须先站起来！")
			return FALSE
	if((check_flags & AB_CHECK_PHASED) && HAS_TRAIT(owner, TRAIT_MAGICALLY_PHASED))
		if (feedback)
			owner.balloon_alert(owner, "没有实体！")
		return FALSE
	if((check_flags & AB_CHECK_OPEN_TURF) && !isopenturf(owner.loc))
		if (feedback)
			owner.balloon_alert(owner, "空间不足！")
		return FALSE
	return TRUE

/// Builds / updates all buttons we have shared or given out
/datum/action/proc/build_all_button_icons(update_flags = ALL, force)
	for(var/datum/hud/hud as anything in viewers)
		build_button_icon(viewers[hud], update_flags, force)

/**
 * Builds the icon of the button.
 *
 * Concept:
 * - Underlay (Background icon)
 * - Icon (button icon)
 * - Maptext
 * - Overlay (Background border)
 *
 * button - which button we are modifying the icon of
 * force - whether we're forcing a full update
 */
/datum/action/proc/build_button_icon(atom/movable/screen/movable/action_button/button, update_flags = ALL, force = FALSE)
	if(!button)
		return

	button.actiontooltipstyle = buttontooltipstyle

	if(update_flags & UPDATE_BUTTON_NAME)
		update_button_name(button, force)

	if(update_flags & UPDATE_BUTTON_BACKGROUND)
		apply_button_background(button, force)

	if(update_flags & UPDATE_BUTTON_ICON)
		apply_button_icon(button, force)

	if(update_flags & UPDATE_BUTTON_OVERLAY)
		apply_button_overlay(button, force)

	if(update_flags & UPDATE_BUTTON_STATUS)
		update_button_status(button, force)

/datum/action/proc/get_display_name(action_name = name)
	var/static/list/localized_names = list("Generic Action" = "通用动作", "Item Action" = "物品动作", "Vote!" = "投票！", "Dash" = "冲刺", "End Holocall" = "结束全息通话", "Adjust Item" = "调整物品", "Adjust Item Style" = "调整物品样式", "Adjust Visor" = "调整面罩", "Toggle Zooming Speed" = "切换瞄准速度", "Switch Zoom Mode" = "切换瞄准模式", "Berserk" = "狂暴", "Activate Jump Boots" = "启动跳跃靴", "Activate Rocket Boots" = "启动火箭靴", "Change Name" = "更改姓名", "Draw Blood Rune" = "绘制鲜血符文", "Activate Flight Jets" = "启动飞行喷射器", "Activate" = "启动", "Shift Nerves" = "调整神经", "Toggle Zoom" = "切换变焦", "Organ Action" = "器官动作", "Toggle Organ" = "开关器官", "Use Organ" = "使用器官", "Go Feral" = "野性爆发", "Bite the Hand that Feeds" = "恩将仇报", "Unleash Id" = "释放本我", "Activate Catbrain" = "启用猫脑", "Gremlin Mode" = "小捣蛋鬼模式", "Nom Mode" = "啃咬模式", "Dehumanize Yourself" = "抛弃人性", "Misbehave" = "撒野", "Juggernaut mode" = "重装防御模式", "Reload Rebar" = "装填钢筋", "Set Internals" = "设置供氧气源", "Deploy Box" = "展开纸箱", "Summon Stick Minions" = "召唤火柴人仆从", "Toggle Flashlight" = "开关手电筒", "Toggle Gunlight" = "开关枪灯", "Toggle Mode" = "切换模式", "Toggle Barrier Spread" = "切换屏障展开模式", "Toggle Paddles" = "取放电极板", "Toggle Mister" = "取放喷雾器", "Toggle Helmet Light" = "开关头盔照明", "Toggle Welding Screen" = "开关焊接护目屏", "Toggle Suit Thermal Regulator" = "开关服装温控器", "Toggle Helmet Flashlight" = "开关头盔手电筒", "Toggle Helmet Mode" = "切换头盔模式", "Toggle Voice Box" = "开关语音盒", "Toggle Helmet" = "收放头盔", "Toggle Seclight" = "开关安保手电筒", "Toggle Jetpack" = "开关喷气背包", "Toggle Jetpack Stabilization" = "开关喷气背包稳定器", "Toggle Implant HUD" = "开关植入式HUD", "Toggle Wheels" = "收放滑轮", "Activate Kindle Kicks" = "启动炫光鞋", "Switch gathering mode" = "切换收集模式", "Flip" = "翻转", "Call MODlink" = "呼叫模块通讯器", "Toggle Wearable HUD" = "开关穿戴式HUD", "Toggle Night Vision" = "开关夜视", "Unzip Duffel" = "拉开行李袋", "Unzip" = "拉开拉链", "Zip" = "拉上拉链", "Vortex Recall" = "漩涡召回", "Adjust Vision" = "调整视野", "Assume Form" = "拟态", "Blood Warp" = "鲜血跃迁", "Charge" = "冲锋", "Basic Charge" = "基础冲锋", "Triple Charge" = "三连冲锋", "Hallucination Charge" = "幻象冲锋", "Surround Target" = "包围目标", "Charge APCs" = "为区域电力控制器充电", "Chase Target" = "追击目标", "Foam wall" = "泡沫墙", "Create Legion Skull" = "制造军团头骨", "Create Sentinels" = "制造哨卫", "Change Mode" = "切换模式", "Fire Breath" = "火焰吐息", "Fire Cone" = "锥形火焰", "Mass Fire" = "烈焰迸发", "Ground Slam" = "震地重击", "Check Type" = "查看类型", "Communicate" = "心灵通讯", "Manifest" = "显现", "Recall" = "召回", "Toggle Light" = "开关发光", "Toggle Stealth" = "切换隐身", "Toggle Gas" = "切换气体")
	if(istype(src, /datum/action/vote) && findtext(action_name, "Vote: ") == 1)
		return "投票：[copytext(action_name, 7)]"
	return list("Change Cable Color" = "更改扭扭棒颜色", "Toggle Fast Wiring Gui" = "开关快速布线界面")[action_name] || localized_mob_action_names[action_name] || localized_names[action_name] || (istype(src, /datum/action/item_action/adjust_style) && findtext(action_name, "Adjust ") == 1 ? "调整[copytext(action_name, 8, -8)]的样式" : istype(src, /datum/action/item_action/adjust_visor) && findtext(action_name, "Adjust ") == 1 ? "调整[copytext(action_name, 8, -6)]的面罩" : istype(src, /datum/action/item_action/adjust) && findtext(action_name, "Adjust ") == 1 ? "调整[copytext(action_name, 8)]" : istype(src, /datum/action/item_action/organ_action/toggle) && findtext(action_name, "Toggle ") == 1 ? "开关[copytext(action_name, 8)]" : istype(src, /datum/action/item_action/organ_action/use) && findtext(action_name, "Use ") == 1 ? "使用[copytext(action_name, 5)]" : action_name)
/datum/action/proc/update_button_name(atom/movable/screen/movable/action_button/button, force = FALSE)
	button.position_name = name
	button.name = get_display_name(name)
	if(desc)
		button.desc = desc

/**
 * Creates the background underlay for the button
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/apply_button_background(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if(!background_icon || !background_icon_state || (current_button.active_underlay_icon_state == background_icon_state && !force))
		return

	// What icons we use for our background
	var/list/icon_settings = list(
		// The icon file
		"bg_icon" = background_icon,
		// The icon state, if is_action_active() returns FALSE
		"bg_state" = background_icon_state,
		// The icon state, if is_action_active() returns TRUE
		"bg_state_active" = background_icon_state,
	)

	// If background_icon_state is ACTION_BUTTON_DEFAULT_BACKGROUND instead use our hud's action button scheme
	if(background_icon_state == ACTION_BUTTON_DEFAULT_BACKGROUND && owner?.hud_used)
		icon_settings = owner.hud_used.get_action_buttons_icons()

	// Determine which icon to use
	var/used_icon_key = is_action_active(current_button) ? "bg_state_active" : "bg_state"

	// Make the underlay
	current_button.underlays.Cut()
	current_button.underlays += image(icon = icon_settings["bg_icon"], icon_state = icon_settings[used_icon_key])
	current_button.active_underlay_icon_state = icon_settings[used_icon_key]

/**
 * Applies our button icon and icon state to the button
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if(!button_icon || !button_icon_state || (current_button.icon_state == button_icon_state && !force))
		return

	current_button.icon = button_icon
	current_button.icon_state = button_icon_state

/**
 * Applies any overlays to our button
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/apply_button_overlay(atom/movable/screen/movable/action_button/current_button, force = FALSE)

	SEND_SIGNAL(src, COMSIG_ACTION_OVERLAY_APPLY, current_button, force)

	if(!overlay_icon || !overlay_icon_state || (current_button.active_overlay_icon_state == overlay_icon_state && !force))
		return

	current_button.cut_overlay(current_button.button_overlay)
	current_button.button_overlay = mutable_appearance(icon = overlay_icon, icon_state = overlay_icon_state)
	current_button.add_overlay(current_button.button_overlay)
	current_button.active_overlay_icon_state = overlay_icon_state

/**
 * Any other miscellaneous "status" updates within the action button is handled here,
 * such as redding out when unavailable or modifying maptext.
 *
 * current_button - what button are we editing?
 * force - whether an update is forced regardless of existing status
 */
/datum/action/proc/update_button_status(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	current_button.update_keybind_maptext(full_key)
	if(IsAvailable())
		current_button.color = rgb(255,255,255,255)
	else
		current_button.color = transparent_when_unavailable ? rgb(128,0,0,128) : rgb(128,0,0)
	SEND_SIGNAL(src, COMSIG_ACTION_STATUS_UPDATE, current_button, force)

/// Gives our action to the passed viewer.
/// Puts our action in their actions list and shows them the button.
/datum/action/proc/GiveAction(mob/viewer)
	var/datum/hud/our_hud = viewer.hud_used
	if(viewers[our_hud]) // Already have a copy of us? go away
		return

	LAZYOR(viewer.actions, src) // Move this in
	ShowTo(viewer)

/// Adds our action button to the screen of the passed viewer.
/datum/action/proc/ShowTo(mob/viewer)
	var/datum/hud/our_hud = viewer.hud_used
	if(!our_hud || viewers[our_hud]) // There's no point in this if you have no hud in the first place
		return

	var/atom/movable/screen/movable/action_button/button = create_button(viewer)
	SetId(button, viewer)

	button.our_hud = our_hud
	viewers[our_hud] = button
	if(viewer.client)
		viewer.client.screen += button

	button.load_position(viewer)
	viewer.update_action_buttons()

/// Removes our action from the passed viewer.
/datum/action/proc/HideFrom(mob/viewer)
	var/datum/hud/our_hud = viewer.hud_used
	var/atom/movable/screen/movable/action_button/button = viewers[our_hud]
	LAZYREMOVE(viewer.actions, src)
	if(button)
		qdel(button)

/// Creates an action button movable for the passed mob, and returns it.
/datum/action/proc/create_button(mob/viewer)
	var/atom/movable/screen/movable/action_button/button = viewer.hud_used.add_screen_object(/atom/movable/screen/movable/action_button)
	button.linked_action = src
	button.allow_observer_click = allow_observer_click
	build_button_icon(button, ALL, TRUE)
	return button

/datum/action/proc/SetId(atom/movable/screen/movable/action_button/our_button, mob/owner)
	//button id generation
	var/bitfield = 0
	for(var/datum/action/action in owner.actions)
		if(action == src) // This could be us, which is dumb
			continue
		var/atom/movable/screen/movable/action_button/button = action.viewers[owner.hud_used]
		if(action.name == name && button.id)
			bitfield |= button.id

	bitfield = ~bitfield // Flip our possible ids, so we can check if we've found a unique one
	for(var/i in 0 to 23) // We get 24 possible bitflags in dm
		var/bitflag = 1 << i // Shift us over one
		if(bitfield & bitflag)
			our_button.id = bitflag
			return

/// Updates our buttons if our target's icon was updated
/datum/action/proc/on_target_icon_update(datum/source, updates, updated)
	SIGNAL_HANDLER

	var/update_flag = NONE
	var/forced = FALSE
	if(updates & UPDATE_ICON_STATE)
		update_flag |= UPDATE_BUTTON_ICON
		forced = TRUE
	if(updates & UPDATE_OVERLAYS)
		update_flag |= UPDATE_BUTTON_OVERLAY
		forced = TRUE
	if(updates & (UPDATE_NAME|UPDATE_DESC))
		update_flag |= UPDATE_BUTTON_NAME
	// Status is not relevant, and background is not relevant. Neither will change

	// Force the update if an icon state or overlay change was done
	build_all_button_icons(update_flag, forced)

/// A general use signal proc that reacts to an event and updates JUST our button's status
/datum/action/proc/update_status_on_signal(datum/source, new_stat, old_stat)
	SIGNAL_HANDLER

	build_all_button_icons(UPDATE_BUTTON_STATUS)

/// Signal proc for COMSIG_MIND_TRANSFERRED - for minds, transfers our action to our new mob on mind transfer
/datum/action/proc/on_target_mind_swapped(datum/mind/source, mob/old_current)
	SIGNAL_HANDLER

	// Grant() calls Remove() from the existing owner so we're covered on that
	Grant(source.current)

/// Checks if our action is actively selected. Used for selecting icons primarily.
/datum/action/proc/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return FALSE

/datum/action/proc/begin_creating_bind(atom/movable/screen/movable/action_button/current_button, mob/user)
	if(!current_button || user != owner)
		return
	if(!isnull(full_key))
		full_key = null
		update_button_status(current_button)
		return
	full_key = tgui_input_keycombo(user, "请为此动作绑定按键。")
	update_button_status(current_button)

/datum/action/proc/keydown(mob/source, key, client/client, full_key)
	SIGNAL_HANDLER
	if(isnull(full_key) || full_key != src.full_key)
		return
	if(istype(source))
		if(source.next_click > world.time)
			return
		else
			source.next_click = world.time + CLICK_CD_ACTIVATE_ABILITY
	INVOKE_ASYNC(src, PROC_REF(Trigger))

/// Used for setting the keybind via external sources.
/datum/action/proc/set_key(new_full_key)
	full_key = new_full_key
	build_all_button_icons(UPDATE_BUTTON_STATUS)

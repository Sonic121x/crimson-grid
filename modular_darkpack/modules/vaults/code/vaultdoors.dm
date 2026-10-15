/obj/structure/vaultdoor
	name = "金库门"
	desc = "一扇厚重的门，看起来能承受猛烈的破坏。"
	icon = 'modular_darkpack/modules/vaults/icons/vault.dmi'
	icon_state = "vault-1"
	base_icon_state = "vault"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -16
	anchored = TRUE
	density = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	var/id = ""
	var/brokenicon = "vault_broken"
	var/pincode
	var/closed = TRUE
	var/lock_id = ""
	var/door_moving = FALSE
	var/is_broken = FALSE
	var/door_health = 100

	var/open_sound = 'modular_darkpack/modules/vaults/sounds/vault_door_opening.ogg'
	var/close_sound = 'modular_darkpack/modules/vaults/sounds/vault_door_closing.ogg'
	var/lock_sound = 'modular_darkpack/modules/vaults/sounds/vault_door_lock.ogg'

	var/is_locked = FALSE

/obj/structure/vaultdoor/pincode
	name = "金库门"
	desc = "一扇厚重的门，看起来能承受猛烈的破坏。"

/obj/structure/vaultdoor/pincode/bank
	name = "银行金库门"
	desc = "一扇巨大的加固金库门，守护着银行的储备资金。"
	lock_id = "bank_vault"

/obj/structure/vaultdoor/Initialize(mapload)
	. = ..()
	pincode = create_unique_pincode()
	GLOB.vault_doors += src
	is_locked = TRUE

/obj/structure/vaultdoor/Destroy()
	GLOB.vault_doors -= src
	return ..()

/obj/structure/vaultdoor/attack_hand(mob/user)
	. = ..()
	if(is_broken)
		return

	if(is_locked)
		ui_interact(user)
		return

	if(closed && !door_moving)
		open_door(user)
	else if (!door_moving)
		close_door(user)

/obj/structure/vaultdoor/proc/break_open()
	if(is_broken)
		return
	is_broken = TRUE
	is_locked = FALSE
	icon_state = "[brokenicon]-1"
	set_density(FALSE)
	opacity = FALSE
	layer = OPEN_DOOR_LAYER
	visible_message("<span class='warning' style='color:red; font-size:20px;'><b>[src]被破开了！</b></span>")

/obj/structure/vaultdoor/proc/open_door(mob/user)
	playsound(src, open_sound, 75, TRUE)
	door_moving = TRUE
	if(do_after(user, 4 SECONDS))
		icon_state = "[base_icon_state]-0"
		set_density(FALSE)
		opacity = FALSE
		layer = OPEN_DOOR_LAYER
		to_chat(user, span_notice("你打开了[src]。"))
		closed = FALSE
	door_moving = FALSE

/obj/structure/vaultdoor/proc/close_door(mob/user)
	for(var/atom/movable/door_blocker in src.loc)
		if(door_blocker.density)
			to_chat(user, span_warning("[door_blocker]挡住了[src]，你无法将门关上。"))
			return
	playsound(src, close_sound, 75, TRUE)
	door_moving = TRUE
	if(do_after(user, 4 SECONDS))
		icon_state = "[base_icon_state]-1"
		set_density(TRUE)
		opacity = TRUE
		layer = ABOVE_ALL_MOB_LAYER
		to_chat(user, span_notice("你关上了[src]。"))
		closed = TRUE
		is_locked = TRUE
		to_chat(user, span_notice("[src]自动锁上了。"))
		playsound(src, lock_sound, 50, TRUE)
	door_moving = FALSE

/obj/structure/vaultdoor/examine(mob/user)
	. = ..()
	. += span_notice("门的耐久度：[door_health]/100。")

	if(is_locked)
		. += span_warning("[src]锁着。")

	. += span_notice("[src]使用电子密码锁。")

/obj/structure/vaultdoor/ui_interact(mob/user, datum/tgui/ui)
	if(is_broken || !is_locked)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VaultDoor")
		ui.open()

/obj/structure/vaultdoor/ui_data(mob/user)
	var/list/data = list()
	data["pincode"] = pincode
	return data

/obj/structure/vaultdoor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(action == "submit_pincode")
		if(params["pincode"] == pincode)
			to_chat(usr, span_notice("验证通过。"))
			is_locked = FALSE
			playsound(src, 'sound/machines/terminal/terminal_success.ogg', 50, TRUE)
		else
			to_chat(usr, span_warning("拒绝访问。"))
			playsound(src, 'sound/machines/terminal/terminal_error.ogg', 50, TRUE)
		. = TRUE


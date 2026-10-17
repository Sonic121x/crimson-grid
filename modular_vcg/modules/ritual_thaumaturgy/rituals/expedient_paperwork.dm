/obj/ritual_rune/thaumaturgy/expedient_paperwork
	name = "公文速成"
	desc = "制作一套看起来尽可能正式齐全的公文。"
	icon_state = "rune5"
	word = ""
	level = 1
	sacrifices = list(/obj/item/paper, /obj/item/watch) // we don't have dog hair
	var/paperwork_name
	var/paperwork_icon
	var/static/list/paperwork_icons = list("docs_generic", "docs_part", "docs_verified", "docs_red", "docs_blue")

/obj/ritual_rune/thaumaturgy/expedient_paperwork/attack_hand(mob/living/user)
	if(activated)
		return

	var/chosen_name = tgui_input_text(user, "文件名称？", "公文速成", max_length = MAX_NAME_LEN)
	if(!chosen_name)
		to_chat(user, span_warning("你决定不再速成公文。"))
		return FALSE

	var/list/icon_choices = list()
	for(var/state in paperwork_icons)
		icon_choices[state] = image(icon = 'icons/obj/service/bureaucracy.dmi', icon_state = state)

	var/chosen_icon = show_radial_menu(user, src, icon_choices, require_near = TRUE, tooltips = TRUE)
	if(!chosen_icon)
		to_chat(user, span_warning("你决定不再速成公文。"))
		return FALSE

	paperwork_name = chosen_name
	paperwork_icon = chosen_icon
	. = ..()

/obj/ritual_rune/thaumaturgy/expedient_paperwork/complete()
	. = ..()

	var/obj/item/paperwork/documents = new(loc)
	documents.name = paperwork_name
	documents.icon_state = paperwork_icon
	documents.desc = "一套填制得一丝不苟的公文，每个细节都显得齐全而严谨。"
	qdel(src)

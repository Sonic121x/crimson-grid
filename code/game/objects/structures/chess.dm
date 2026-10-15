/obj/structure/chess
	anchored = FALSE
	density = FALSE
	icon = 'icons/obj/toys/chess.dmi'
	icon_state = "white_pawn"
	name = "\improper Probably a White Pawn"
	desc = "This is weird. Please inform administration on how you managed to get the parent chess piece. Thanks!"
	max_integrity = 100
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/chess/wrench_act(mob/user, obj/item/tool)
	if(flags_1 & HOLOGRAM_1)
		balloon_alert(user, "直接穿过去了！")
		return TRUE
	to_chat(user, span_notice("你开始拆解棋子。"))
	if(!do_after(user, 0.5 SECONDS, target = src))
		return TRUE
	var/obj/item/stack/sheet/iron/metal_sheets = new (drop_location(), 2)
	if (!QDELETED(metal_sheets))
		metal_sheets.add_fingerprint(user)
	tool.play_tool_sound(src)
	qdel(src)
	return TRUE

/obj/structure/chess/whitepawn
	name = "\improper 白兵"
	desc = "国际象棋的白兵。漂亮地吃掉过路兵时，小心被人指责作弊。"
	icon_state = "white_pawn"

/obj/structure/chess/whiterook
	name = "\improper 白车"
	desc = "国际象棋的白车，又称城堡。能沿直线走任意格数，还有一种叫王车易位的特殊走法。"
	icon_state = "white_rook"

/obj/structure/chess/whiteknight
	name = "\improper 白马"
	desc = "国际象棋的白马，可以越过其他棋子，沿L形移动。白马骑——哦，哈！"
	icon_state = "white_knight"

/obj/structure/chess/whitebishop
	name = "\improper 白象"
	desc = "国际象棋的白象，可以沿斜线走任意格数。"
	icon_state = "white_bishop"

/obj/structure/chess/whitequeen
	name = "\improper 白后"
	desc = "国际象棋的白后，可以沿斜线或直线走任意格数。"
	icon_state = "white_queen"

/obj/structure/chess/whiteking
	name = "\improper 白王"
	desc = "国际象棋的白王，可以向任意方向走一格。"
	icon_state = "white_king"

/obj/structure/chess/blackpawn
	name = "\improper 黑兵"
	desc = "国际象棋的黑兵。漂亮地吃掉过路兵时，小心被人指责作弊。"
	icon_state = "black_pawn"

/obj/structure/chess/blackrook
	name = "\improper 黑车"
	desc = "国际象棋的黑车，又称城堡。能沿直线走任意格数，还有一种叫王车易位的特殊走法。"
	icon_state = "black_rook"

/obj/structure/chess/blackknight
	name = "\improper 黑马"
	desc = "国际象棋的黑马，可以越过其他棋子，沿L形移动。"
	icon_state = "black_knight"

/obj/structure/chess/blackbishop
	name = "\improper 黑象"
	desc = "国际象棋的黑象，可以沿斜线走任意格数。"
	icon_state = "black_bishop"

/obj/structure/chess/blackqueen
	name = "\improper 黑后"
	desc = "国际象棋的黑后，可以沿斜线或直线走任意格数。"
	icon_state = "black_queen"

/obj/structure/chess/blackking
	name = "\improper 黑王"
	desc = "国际象棋的黑王，可以向任意方向走一格。"
	icon_state = "black_king"

/obj/structure/chess/checker
	icon_state = "white_checker_man"
	name = "\improper Probably a White Checker"
	desc = "This is weird. Please inform administration on how you managed to get the parent checker piece. Thanks!"

/obj/structure/chess/checker/whiteman
	name = "\improper 白色跳棋棋子"
	desc = "一枚白色西洋跳棋棋子，看起来可疑地像被压扁的国际象棋兵。"
	icon_state = "white_checker_man"

/obj/structure/chess/checker/whiteking
	name = "\improper 白色跳棋王棋"
	desc = "一枚白色西洋跳棋棋子。叠起来成王了！"
	icon_state = "white_checker_king"

/obj/structure/chess/checker/blackman
	name = "\improper 黑色跳棋棋子"
	desc = "一枚黑色西洋跳棋棋子，看起来可疑地像被压扁的国际象棋兵。"
	icon_state = "black_checker_man"

/obj/structure/chess/checker/blackking
	name = "\improper 黑色跳棋王棋"
	desc = "一枚黑色西洋跳棋棋子。叠起来成王了！"
	icon_state = "black_checker_king"

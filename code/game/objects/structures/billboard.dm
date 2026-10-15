/obj/structure/billboard
	name = "空白广告牌"
	desc = "一块空白广告牌，可以刊登各种广告。"
	icon = 'icons/obj/fluff/billboard.dmi'
	icon_state = "billboard_blank"
	plane = ABOVE_GAME_PLANE
	max_integrity = 1000
	bound_width = 96
	bound_height = 32
	density = TRUE
	anchored = TRUE

/obj/structure/billboard/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_BILLBOARD)

/obj/structure/billboard/donk_n_go
	name = "\improper 当克即走广告牌"
	desc = "一块当克即走广告牌。这是当克公司无处不在、始终不健康的快餐品牌：进来，吃饱，走人！"
	icon_state = "billboard_donk_n_go"

/obj/structure/billboard/space_cola
	name = "\improper 太空可乐广告牌"
	desc = "一块太空可乐广告牌：放轻松，喝瓶太可。"
	icon_state = "billboard_space_cola"

/obj/structure/billboard/nanotrasen
	name = "\improper 纳诺传讯广告牌"
	desc = "一块纳诺传讯广告牌：美好明天，今日实现。"
	icon_state = "billboard_nanotrasen"

/obj/structure/billboard/nanotrasen/defaced
	name = "被涂污的纳诺传讯广告牌"
	desc = "一块纳诺传讯广告牌。有人在上面喷了一句话：去他妈的企业猪。"
	icon_state = "billboard_fuck_corps"

/obj/structure/billboard/azik
	name = "\improper 阿兹克星际广告牌"
	desc = "一块宣传阿兹克星际及其最新型号——独裁者号太阳帆船的广告牌。阿兹克星际：以提兹拉匠心，满足银河所需。"
	icon_state = "billboard_azik"

/obj/structure/billboard/cvr
	name = "\improper 查理曼·冯·莱茵兰广告牌"
	desc = "一块宣传查理曼·冯·莱茵兰日耳曼尼亚级超级游艇的广告牌。查理曼·冯·莱茵兰：王者的造船厂。"
	icon_state = "billboard_cvr"

/obj/structure/billboard/twenty_four_seven
	name = "\improper 全天候便利店广告牌"
	desc = "一块宣传全天候便利店全新限量口味思乐冰的广告牌。全天候便利店：每天，全天。"
	icon_state = "billboard_twenty_four_seven"

/obj/structure/billboard/starway
	name = "\improper 星途运输广告牌"
	desc = "一块宣传星途运输新莫斯科至纽约直达航班的广告牌：经济舱铺位仅需2000信用点。星途：通往群星的船票。"
	icon_state = "billboard_starway"

/obj/structure/billboard/lizards_gas
	name = "\improper 蜥蜴加油站广告牌"
	desc = "一块标示“蜥蜴加油站”的广告牌。这个品牌已被岁月遗忘，这也是唯一已知的同类加油站。单看广告牌的质量，真不明白它怎么会倒闭。"
	icon_state = "billboard_lizards_gas"

/obj/structure/billboard/lizards_gas/defaced
	desc = "一块标示“蜥蜴加油站”的广告牌。精心绘制的广告曾遭人涂鸦，后来一位好心的陌生人又涂掉了那些恶毒的字句。"
	icon_state = "billboard_lizards_gas_defaced"

/obj/structure/billboard/roadsign
	name = "\improper 公路指示广告牌"
	desc = "一块告知距离加油站还有多少英里的广告牌。不过这块似乎是空白的。"
	icon_state = "billboard_roadsign_blank"

/obj/structure/billboard/roadsign/two
	desc = "一块告知距离下一座加油站还有多少英里的广告牌。实在看不出这块牌子有什么用。"
	icon_state = "billboard_roadsign_two"

/obj/structure/billboard/roadsign/twothousand
	desc = "一块告知距离下一座加油站还有多少英里的广告牌。看到这种牌子，你大概会想多备些食物和汽油。"
	icon_state = "billboard_roadsign_twothousand"

/obj/structure/billboard/roadsign/twomillion
	desc = "一块告知距离下一座加油站还有多少英里的广告牌。如果你能跋涉数百万英里，这应该不在话下！如果不能……"
	icon_state = "billboard_roadsign_twomillion"

/obj/structure/billboard/roadsign/error
	desc = "一块告知距离下一座加油站还有多少英里的广告牌。这可是印制的固定牌子，真让人好奇，什么人会把它印出来，还挂上去。"
	icon_state = "billboard_roadsign_error"

/obj/structure/billboard/smoothies
	name = "\improper 旋臂果昔广告牌"
	desc = "一块宣传旋臂果昔的广告牌。"
	icon_state = "billboard_smoothies"

/obj/structure/billboard/fortune_telling
	name = "\improper 占卜师广告牌"
	desc = "一块宣传占卜服务的广告牌。据说由真正的灵能者亲自占卜！"
	icon_state = "billboard_fortune_tell"

/obj/structure/billboard/Phone_booth
	name = "\improper 全息电话广告牌"
	desc = "一块宣传全息电话的广告牌。星际通话仅需49.99信用点，还提供免税零食！"
	icon_state = "billboard_phone"

/obj/structure/billboard/american_diner
	name = "\improper 全美餐馆广告牌"
	desc = "一块宣传20世纪50年代复古主题连锁餐厅\"全美餐馆\"的广告牌。"
	icon_state = "billboard_american_diner"

/obj/structure/billboard/gloves
	name = "\improper 罗罗公司手套广告牌"
	desc = "一块宣传绝缘手套及其配件制造商罗罗公司的广告牌，上面画着公司可爱的吉祥物罗罗。"
	icon_state = "billboard_gloves"

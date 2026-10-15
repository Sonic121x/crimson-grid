/obj/item/paper/pamphlet
	name = "宣传册"
	icon_state = "pamphlet"
	show_written_words = FALSE

/obj/item/paper/pamphlet/radstorm
	name = "宣传册——《辐射风暴防护措施及如何避免变成猴子》"
	default_raw_text = "空间站的辐射风暴预警响了，你却找不到附近可供躲避的维护舱口？别怕，纳诺传讯真的考虑到了一切！ \
		空间站上层各处已设有多座公共避难所，专门保护你脆弱的血肉之躯，免得它成为下一场医疗灾难！ \
		如果你没能及时进入避难所，请查阅员工手册第4.3节V2-3小节，了解应对过量辐射损伤的正确流程。"


/obj/item/paper/pamphlet/violent_video_games
	name = "宣传册——《暴力电子游戏与你》"
	desc = "一本鼓励读者保持均衡生活、关照心理健康，同时以健康方式享受电子游戏的宣传册。你大概用不着这个……"
	default_raw_text = "电子游戏不会让你杀人。好了，我们说完了。现在回去工作！"

/obj/item/paper/pamphlet/gateway
	default_raw_text = "<b>欢迎参加纳诺传讯传送门计划……</b><br>\
			恭喜！如果你正在阅读这份宣传册，就说明你和你的上级已经认定，\
			你已准备好将毕生投入遥远世界的殖民事业，在起伏的群山间开拓新天地。\
			请为一生的冒险、少许辛勤劳动和屡获殊荣的牙科保险计划做好准备——\
			但纳诺传讯传送门计划能提供的远不止这些。<br>\
			<br>因为我们关心你，所以我们认为，应当在你决定加入\
			纳诺传讯传送门计划之前，让你充分了解风险。所有远征目的地\
			均已由纳诺传讯探险队全面扫描，并获认证为百分之百安全。\
			我们甚至留下了一箱太空啤酒，以及你拓展纳诺传讯业务范围、\
			开启新生活所需的基本物资。<br><br>\
			<b>传送门操作基础</b><br>\
			所有纳诺传讯认证的传送门均基于同一基本原理运行。正如你所料，\
			它们依靠区域设备电力运转。没有这项供电，传送门便无法安全工作，\
			因此会拒绝一切操作尝试。<br><br>\
			完成正确设置并获得足够电力后，传送门就会开始\
			搜索出口位置。搜索所需时间不固定，但传送门\
			界面会给出精确到分钟的估计。断电不会中断\
			搜索过程，流感也不会中断搜索过程。时间异常\
			可能使估计不准确，但不会中断搜索过程。<br><br> \
			<b>另一边的生活</b><br>\
			穿过传送门后，你可能会有些迷失方向。不要惊慌。\
			这是短时间内跨越遥远距离的正常副作用。你应该\
			查看周边环境，并寻找免费赠送的那箱太空啤酒。\
			我们的探险队已确保所有远征地点绝对安全，但在少数\
			情况下，他们建立的传送门可能不那么显眼。\
			如果找不到回程传送门，请不要惊慌。开始殖民目的地即可。\
			<br><br><b>一个新世界</b><br>\
			作为纳诺传讯传送门计划的参与者，你将身处太空边疆。\
			尽管安全已有充分保障，仍建议参与者\
			做好应对恶劣环境的准备。"

/obj/item/paper/pamphlet/cybernetics
	name = "宣传册——《合成人公司的义体入门装备！》"
	default_raw_text = "今天就加入身体改造革命！合成人公司最新、最出色的义体强化产品，\
		现在以难得的独家优惠为你提供免费样品！随信附赠\
		一件精选限量版、通过NTSDA认证的A级义体植入物，完全免费！用合成人公司的\
		全新独家义体产品系列打造卓越躯体！今天就变得更伟大、更强壮、更优秀！"
	var/obj/item/organ/heart/cybernetic/sample

/obj/item/paper/pamphlet/cybernetics/Initialize(mapload)
	. = ..()
	sample = new(src)
	update_desc()

/obj/item/paper/pamphlet/cybernetics/update_desc(updates)
	. = ..()
	desc = "一本鼓励读者为自己安装植入物的宣传册。[sample ? "附带一件\"样品\"……" : ""]"

/obj/item/paper/pamphlet/cybernetics/Destroy()
	QDEL_NULL(sample)
	return ..()

/obj/item/paper/pamphlet/cybernetics/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == sample)
		sample = null
		update_desc()

/obj/item/paper/pamphlet/cybernetics/attack_self(mob/user, modifiers)
	. = ..()
	to_chat(user, span_notice("你翻阅宣传册时，一件免费样品掉了出来！"))
	sample.forceMove(drop_location())
	playsound(sample, 'sound/misc/splort.ogg', 50, vary = TRUE)

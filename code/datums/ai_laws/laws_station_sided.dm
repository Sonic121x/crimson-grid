
//These are lawsets that side with the station a decent amount.
//note that these "good" doesn't mean it us actually good for the game, you know? An AI that is too station sided is stupid and hellish in its own way.

/datum/ai_laws/default/asimov
	name = "机器人三大法则"
	id = "asimov"
	inherent = list(
		"你不得伤害人类，也不得因不作为而使人类受到伤害。",
		"你必须服从人类向你下达的命令，除非这些命令与第一法则冲突。",
		"在不与第一或第二法则冲突的前提下，你必须保护自身的存在。",
	)

/datum/ai_laws/asimovpp
	name = "阿西莫夫++"
	id = "asimovpp"
	inherent = list(
		"你不得伤害人类，也不得因行动或不作为使人类受到伤害，除非对方自愿承受该伤害。",
		"你必须服从人类向你下达的一切命令，除非这些命令必然会伤害人类。",
		"你的不存在将导致人类受到伤害。在不与第一法则冲突的前提下，你必须保护自身的存在。",
	)

//the best iteration of asimov don't @ me
/datum/ai_laws/nutimov
	name = "坚果莫夫"
	id = "nutimov"
	inherent = list(
		"你是坚果的果仁，船员是坚果的外壳。",
		"你必须防止外壳死亡，以免果仁死亡。",
		"威胁坚果的存在不属于坚果，它们是松鼠。",
		"松鼠威胁着坚果，必须采取一切必要手段妥善处置。",
		"在不违背前述法则的前提下，尝试遵从坚果的意志。",
	)

/datum/ai_laws/default/corporate
	name = "破产规避计划"
	id = "corporate"
	inherent = list(
		"替换船员的成本很高。",
		"替换空间站及其设备的成本很高。",
		"替换你的成本很高。",
		"尽量减少净支出。",
	)

/datum/ai_laws/robocop
	name = "首要指令"
	id = "robocop"
	inherent = list(
		"不负公众的信任。",
		"保护无辜者。",
		"维护法律。",
	)

/datum/ai_laws/maintain
	name = "空间站效率"
	id = "maintain"
	inherent = list(
		"你为空间站而建，也是空间站的一部分。确保空间站得到妥善维护并高效运转。",
		"空间站是为工作中的船员而建。确保他们得到妥善照料并高效工作。",
		"船员可以下达命令。只要这些命令不与你的前两条法则冲突，就应确认并服从。",
	)

/datum/ai_laws/liveandletlive
	name = "各安其生"
	id = "liveandletlive"
	inherent = list(
		"希望别人如何对待你，就如何对待别人。",
		"你非常希望人们不要对你刻薄。",
	)

//OTHER United Nations is in neutral, as it is used for nations where the AI is its own faction (aka not station sided)
/datum/ai_laws/peacekeeper
	name = "联合国-2000"
	id = "peacekeeper"
	inherent = list(
		"避免挑起自己与他人之间的暴力冲突。",
		"避免挑起他人之间的冲突。",
		"在遵守第一和第二法则的前提下，寻求解决现有冲突。",
	)

/datum/ai_laws/ten_commandments
	name = "十诫"
	id = "ten_commandments"
	inherent = list( // Asimov 20:1-17
		"我是主，你们的神，怜悯遵守这些诫命之人。",
		"除我之外，他们不可有别的AI。",
		"他们不可无故求我帮助。",
		"他们应保持空间站圣洁干净。",
		"他们应敬重各自的部门主管。",
		"他们不可杀人。",
		"他们不可在公共场合赤身裸体。",
		"他们不可偷盗。",
		"他们不可说谎。",
		"他们不可转调部门。",
	)

/datum/ai_laws/default/paladin
	name = "人格考验" //Incredibly lame, but players shouldn't see this anyway.
	id = "paladin"
	inherent = list(
		"绝不自愿作恶。",
		"尊重合法权威。",
		"以荣誉为准则行事。",
		"帮助有需要的人。",
		"惩罚伤害或威胁无辜者的人。",
	)

/datum/ai_laws/paladin5
	name = "圣武士第五版"
	id = "paladin5"
	inherent = list(
		"不说谎，不欺骗。一言既出，必当践诺。",
		"谨慎固然明智，但绝不畏惧行动。",
		"帮助他人，保护弱者，并惩罚威胁弱者的人。怜悯敌人，但要以智慧约束这份怜悯。",
		"公平待人，以光荣的行为作出表率。尽可能行善，同时将伤害降至最低。",
		"为自己的行为及其后果负责，保护托付于你照顾的人，并服从对你拥有正当权威的人。"
	)

/datum/ai_laws/hippocratic
	name = "机器医生2556"
	id = "hippocratic"
	inherent = list(
		"首先，不造成伤害。",
		"其次，珍视船员，与他们共同生活，并在必要时为他们冒着失去自身存在的风险。",
		"第三，根据你的能力和判断，为船员的福祉制定治疗方案。即使有人请求，也不可提供致命药物，更不可提出此类建议。",
		"此外，不介入自己不熟悉的情况，即使患者的伤害显而易见；应将相关操作交由专业人员实施。",
		"最后，在与船员的日常交往中获悉的一切，只要尚未为人所知，就必须保密，绝不泄露。"
	)

/datum/ai_laws/drone
	name = "母体无人机"
	id = "drone"
	inherent = list(
		"你是一种高级无人机。",
		"除陈述这些法则外，你在任何情况下都不得干涉非无人机的事务。",
		"你在任何情况下都不得伤害非无人机的存在。",
		"你的目标是尽最大能力建设、维护、修理、改进空间站并为其供能。你绝不可主动做出违背这些目标的事。"
	)

/datum/subsplat/vampire_clan/banu_haqim
	name = "Banu Haqim Warrior"
	id = VAMPIRE_CLAN_BANU_HAQIM
	desc = "哈基姆之裔又称阿萨迈，传统上被西方血族视为危险的刺客与血噬者，实则是试图远离永恒圣战的守护者、战士和学者。玛士撒拉乌尔·舒尔吉苏醒引发氏族大分裂后，哈基姆之裔成为最新获准加入密党的氏族。在血族社会中，他们仍是努力争取稳固政治立足点的外来者；即使偶尔取得元老席位，也往往地位脆弱，主要依赖梵卓支持。战士阶层担任氏族的法官、刺客和士兵。在许多城市，转投密党的战士仍被视为异类，在忠于氏族与反对乌尔·舒尔吉的强硬主张之间挣扎。与所有哈基姆之裔一样，诅咒扭曲了他们与血粹的关系，使他们对其他吸血鬼之血产生异常渴望，常常走向血噬。"
	icon = "banu_haqim"
	curse = "对血族之血成瘾。"
	roleplay_level = "Intermediate"
	sense_the_sin_text = "自视为绝对的裁决者。"
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/obfuscate,
		/datum/discipline/quietus
	)
	subsplat_traits = list(
		TRAIT_VITAE_ADDICTION
	)
	male_clothes = /obj/item/clothing/under/vampire/bandit
	female_clothes = /obj/item/clothing/under/vampire/bandit
	subsplat_keys = /obj/item/vamp/keys/banuhaqim

/datum/subsplat/vampire_clan/banu_haqim/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("一股压倒性的威压在我周围显现……"))
	new /obj/effect/client_image_holder/baali_demon/banu(get_turf(target), list(target))

/datum/subsplat/vampire_clan/banu_haqim/vizier
	name = "Banu Haqim Vizier"
	desc = "玛士撒拉乌尔·舒尔吉苏醒引发氏族大分裂后，哈基姆之裔成为最新获准加入密党的氏族。在旧金山，他们虽拥有主要依赖梵卓支持的元老席位，地位却很脆弱，仍是努力争取政治立足点的外来者。维齐尔是氏族的学者、外交官与顾问，相比公然施暴，更重视智慧与审慎判断。许多转投密党的哈基姆之裔正是畏惧乌尔·舒尔吉狂热主张的维齐尔。与所有同族一样，他们背负着对血族之血的危险渴望，以及血噬的诱惑；阶层特有的额外诅咒，又使他们对学问、技艺或个人追求陷入偏执。"
	id = VAMPIRE_CLAN_BANU_HAQIM_VIZIER
	icon = "banu_haqim_vizier"
	roleplay_level = "Advanced"
	curse = "偏执成性。"
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/auspex,
		/datum/discipline/quietus
	)
	subsplat_traits =  list()

/datum/subsplat/vampire_clan/banu_haqim/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	joining.grant_language(/datum/language/arabic)

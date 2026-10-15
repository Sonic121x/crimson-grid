/obj/structure/billboard/darkpack
	name = "广告牌"
	desc = "一块展示着巨幅广告的广告牌。"
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_blank"

/obj/structure/billboard/darkpack/transam
	icon_state = "billboard_1"
	desc = "一块宣传泛美公司的广告牌，这家控股公司旗下管理着多家人寿保险和投资公司。"

/obj/structure/billboard/darkpack/endron
	icon_state = "billboard_2"
	desc = "一块宣传安德隆的广告牌，这是一家成立于1916年的石油天然气公司。安德隆，为了更绿色的明天。"

/obj/structure/billboard/darkpack/endronvandal
	icon_state = "billboard_3"
	desc = "一块宣传安德隆的广告牌，这是一家成立于1916年的石油天然气公司。这块广告牌似乎遭到了涂改，上面写着‘末日将至’。"

/obj/structure/billboard/darkpack/king
	icon_state = "billboard_4"
	desc = "一块宣传国王酿酒厂两款旗舰产品的广告牌：蓝条啤酒和国王拉格。"

/obj/structure/billboard/darkpack/kingvandal
	icon_state = "billboard_5"
	desc = "一块宣传国王酿酒厂两款旗舰产品的广告牌：蓝条啤酒和国王拉格。这块广告牌似乎遭到了涂改，广告上潦草地写着‘毒药’。"

/obj/structure/billboard/darkpack/bubway
	icon_state = "billboard_6"
	desc = "一块宣传巴布威‘经典巴布’三明治的广告牌，售价10美元。"

/obj/structure/billboard/darkpack/starkist
	icon_state = "billboard_7"
	desc = "一块宣传星吻橙味汽水的广告牌，人人都想来一口。它含有电解质！"

/obj/structure/billboard/darkpack/starkistvandal
	icon_state = "billboard_8"
	desc = "一块宣传星吻橙味汽水的广告牌，人人都想来一口。这块广告牌似乎遭到了涂改，真粗俗！"

/obj/structure/billboard/darkpack/redbat
	icon_state = "billboard_9"
	desc = "一块宣传红蝠的广告牌，这是运动能量饮料中的佼佼者。据说它能给你一双翅膀。"

/obj/structure/billboard/darkpack/magadon
	icon_state = "billboard_10"
	desc = "一块宣传玛加顿公司的广告牌，这是一家领先的制药企业，也是医院的供应商。玛加顿，塑造更好的你。"

/obj/structure/billboard/darkpack/rednews
	icon_state = "billboard_11"
	desc = "一块宣传红网的广告牌，这家新闻广播公司致力于让公众掌握资讯，并深深吸引他们。"

/obj/effect/spawner/random/structure/billboard/darkpack
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_random"
	loot = list(
		/obj/structure/billboard/darkpack/transam = 50,
		/obj/structure/billboard/darkpack/endron = 50,
		/obj/structure/billboard/darkpack/endronvandal = 20,
		/obj/structure/billboard/darkpack/king = 50,
		/obj/structure/billboard/darkpack/kingvandal = 20,
		/obj/structure/billboard/darkpack/bubway = 50,
		/obj/structure/billboard/darkpack/starkist = 50,
		/obj/structure/billboard/darkpack/starkistvandal = 20,
		/obj/structure/billboard/darkpack/redbat = 50,
		/obj/structure/billboard/darkpack/magadon = 50,
		/obj/structure/billboard/darkpack/rednews = 50,
	)

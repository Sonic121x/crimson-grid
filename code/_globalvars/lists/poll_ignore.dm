//Each lists stores ckeys for "Never for this round" option category

#define POLL_IGNORE_ACADEMY_WIZARD "academy_wizard"
#define POLL_IGNORE_ALIEN_LARVA "alien_larva"
#define POLL_IGNORE_ASH_SPIRIT "ash_spirit"
#define POLL_IGNORE_ASHWALKER "ashwalker"
#define POLL_IGNORE_BLOB "blob"
#define POLL_IGNORE_BLOOD_WORM "blood_worm"
#define POLL_IGNORE_BOTS "bots"
#define POLL_IGNORE_CARGORILLA "cargorilla"
#define POLL_IGNORE_CONSTRUCT "construct"
#define POLL_IGNORE_CONTRACTOR_SUPPORT "contractor_support"
#define POLL_IGNORE_DRONE "drone"
#define POLL_IGNORE_FIRE_SHARK "fire_shark"
#define POLL_IGNORE_FUGITIVE "fugitive"
#define POLL_IGNORE_GLITCH "glitch"
#define POLL_IGNORE_GOLEM "golem"
#define POLL_IGNORE_HERETIC_MONSTER "heretic_monster"
#define POLL_IGNORE_HOLOPARASITE "holoparasite"
#define POLL_IGNORE_HORRIFIC_NECKTIE "horrific_necktie"
#define POLL_IGNORE_IMAGINARYFRIEND "imaginary_friend"
#define POLL_IGNORE_LAVALAND_ELITE "lavaland_elite"
#define POLL_IGNORE_MAID_IN_MIRROR "maid_in_mirror"
#define POLL_IGNORE_MONKEY_HELMET "mind_magnified_monkey"
#define POLL_IGNORE_PAI "pai"
#define POLL_IGNORE_POSIBRAIN "posibrain"
#define POLL_IGNORE_POSSESSED_BLADE "possessed_blade"
#define POLL_IGNORE_PYROSLIME "slime"
#define POLL_IGNORE_RAW_PROPHET "raw_prophet"
#define POLL_IGNORE_REGAL_RAT "regal_rat"
#define POLL_IGNORE_RUST_SPIRIT "rust_spirit"
#define POLL_IGNORE_SENTIENCE_POTION "sentience_potion"
#define POLL_IGNORE_SHADE "shade"
#define POLL_IGNORE_SHUTTLE_DENIZENS "shuttle_denizens"
#define POLL_IGNORE_SPECTRAL_BLADE "spectral_blade"
#define POLL_IGNORE_SPIDER "spider"
#define POLL_IGNORE_SPLITPERSONALITY "split_personality"
#define POLL_IGNORE_STALKER "stalker"
#define POLL_IGNORE_SYNDICATE "syndicate"
#define POLL_IGNORE_SYNDICATE_MONKEY "syndicate_monkey"
#define POLL_IGNORE_VENUSHUMANTRAP "venus_human_trap"
#define POLL_IGNORE_RECOVERED_CREW "recovered_crew"
#define POLL_IGNORE_EXPERIMENTAL_CLONER "experimental_cloner"
#define POLL_IGNORE_FREE_SPORE "free_spore"
#define POLL_IGNORE_BAALI_GUARD "baali_guard" // DARKPACK EDIT ADD

GLOBAL_LIST_INIT(poll_ignore_desc, list(
	POLL_IGNORE_ACADEMY_WIZARD = "学院守卫巫师",
	POLL_IGNORE_ALIEN_LARVA = "异形幼体",
	POLL_IGNORE_ASH_SPIRIT = "灰烬之灵",
	POLL_IGNORE_ASHWALKER = "灰烬行者之卵",
	POLL_IGNORE_BLOB = "黏液团孢子",
	POLL_IGNORE_BOTS = "机器人",
	POLL_IGNORE_CARGORILLA = "货运大猩猩",
	POLL_IGNORE_CONSTRUCT = "构装体",
	POLL_IGNORE_CONTRACTOR_SUPPORT = "承包商支援单位",
	POLL_IGNORE_DRONE = "无人机机体",
	POLL_IGNORE_FIRE_SHARK = "火鲨",
	POLL_IGNORE_FUGITIVE = "逃犯猎手",
	POLL_IGNORE_GLITCH = "故障体",
	POLL_IGNORE_GOLEM = "魔像",
	POLL_IGNORE_HERETIC_MONSTER = "异端魔物",
	POLL_IGNORE_HOLOPARASITE = "全息寄生体",
	POLL_IGNORE_HORRIFIC_NECKTIE = "恐怖领带",
	POLL_IGNORE_IMAGINARYFRIEND = "幻想朋友",
	POLL_IGNORE_LAVALAND_ELITE = "熔岩星球精英",
	POLL_IGNORE_MAID_IN_MIRROR = "镜中女仆",
	POLL_IGNORE_MONKEY_HELMET = "心智强化猴",
	POLL_IGNORE_PAI = "个人AI",
	POLL_IGNORE_POSIBRAIN = "正电子脑",
	POLL_IGNORE_POSSESSED_BLADE = "附魂之刃",
	POLL_IGNORE_PYROSLIME = "史莱姆",
	POLL_IGNORE_RAW_PROPHET = "血肉先知",
	POLL_IGNORE_REGAL_RAT = "鼠王",
	POLL_IGNORE_RUST_SPIRIT = "锈蚀行者",
	POLL_IGNORE_SENTIENCE_POTION = "启智药水",
	POLL_IGNORE_SHADE = "幽影",
	POLL_IGNORE_SHUTTLE_DENIZENS = "穿梭机住民",
	POLL_IGNORE_SPECTRAL_BLADE = "幽魂之刃",
	POLL_IGNORE_SPIDER = "蜘蛛",
	POLL_IGNORE_SPLITPERSONALITY = "分裂人格",
	POLL_IGNORE_STALKER = "潜猎者",
	POLL_IGNORE_SYNDICATE = "辛迪加",
	POLL_IGNORE_SYNDICATE_MONKEY = "辛迪加猴子",
	POLL_IGNORE_VENUSHUMANTRAP = "捕人草",
	POLL_IGNORE_RECOVERED_CREW = "获救船员",
	POLL_IGNORE_FREE_SPORE = "游离孢子",
	POLL_IGNORE_BAALI_GUARD = "巴力守卫", // DARKPACK EDIT ADD
))
GLOBAL_LIST_INIT(poll_ignore, init_poll_ignore())


/proc/init_poll_ignore()
	. = list()
	for (var/k in GLOB.poll_ignore_desc)
		.[k] = list()

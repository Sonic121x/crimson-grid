/area/vtm
	name = CITY_NAME
	icon = 'modular_darkpack/modules/areas/icons/areas.dmi'
	icon_state = "sewer"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	outdoors = TRUE

	ambience_index = null
	ambient_buzz = null
	ambient_buzz_vol = 8
	min_ambience_cooldown = 30 SECONDS
	max_ambience_cooldown = 2 MINUTES

	var/zone_type = ZONE_MASQUERADE

	// 7 is an average city street.
	/// The rating of the gauntlet, the Gauntlet is strongest near certain types of environments
	var/gauntlet_rating = 7 // WEREWOLF

	// is this able to be classified as a domain? e.g, territorial flaw, later political implementation
	var/domain = FALSE
GLOBAL_LIST_INIT(localized_darkpack_area_names, list("San Francisco" = "旧金山", "Interior" = "室内", "Bar" = "酒吧", "Bar - Basement" = "酒吧－地下室", "Garage" = "车库", "Laundromat" = "自助洗衣店", "Giovanni Mansion" = "乔凡尼宅邸", "Giovanni Mansion - Basement" = "乔凡尼宅邸－地下室", "Nightwolf Techshop" = "夜狼科技商店", "Bianchi Bank" = "比安基银行", "\improper Police Station" = "\improper 警察局", "Police Station - Morgue" = "警察局－停尸间", "Police Station - Upstairs" = "警察局－楼上", "Reserved Room" = "预留房间", "Courthouse" = "法院", "Firewatch Tower" = "防火瞭望塔", "Cleaners" = "保洁站", "Strip Club" = "脱衣舞俱乐部", "Abandoned Mansion" = "废弃宅邸", "Millenium Apartments" = "千禧公寓", "Glasswalker's Lab" = "玻璃行者实验室", "Backrooms" = "后室", "Wyrm Corruption" = "妖蛆腐化区", "Strip Club - Elysium" = "脱衣舞俱乐部－极乐境", "Jazz Club" = "爵士俱乐部", "Siren's Cabaret" = "海妖歌舞厅", "Clinic" = "诊所", "Clinic - Psych Ward" = "诊所－精神科病房", "Supply Offices" = "补给办公室", "Hotel" = "旅馆", "Cab Depot" = "出租车站", "Church" = "教堂", "Church - Backrooms" = "教堂－后厅", "Church - Restricted Floor" = "教堂－禁入楼层", "Elevator" = "电梯", "Theatre" = "剧院", "Old Seaside Church" = "海滨旧教堂", "Historical Museum" = "历史博物馆", "Antique Shop" = "古董店", "Alcoholics Anonymous" = "匿名戒酒会", "Vet Clinic" = "兽医诊所", "Coffee House" = "咖啡馆", "Coffee House - Employee Only" = "咖啡馆－员工专用区", "Clan Tzimisce Manor" = "茨密希氏族庄园", "Clan Tzimisce Sanctum" = "茨密希氏族密所", "Community Center" = "社区中心", "Community Center Basement" = "社区中心地下室", "Ghetto Apartments" = "贫民区公寓", "Little Italy - Store" = "小意大利－商店", "Little Italy - Apartments" = "小意大利－公寓", "Tzimisce Sanctum" = "茨密希密所", "Subway Station" = "地铁站", "Grid Substation" = "电网变电站", "[MAIN_EVIL_COMPANY] Facility" = "[MAIN_EVIL_COMPANY_DISPLAY_NAME]设施", "[MAIN_EVIL_COMPANY] Facility Restricted" = "[MAIN_EVIL_COMPANY_DISPLAY_NAME]设施禁区", "Endron Helipad" = "安德隆直升机停机坪", "Endron Forest Worksite" = "安德隆林区工地", "Endron Processing Plant" = "安德隆加工厂", "Endron Facility Restricted" = "安德隆设施禁区", "Forest Caverns" = "森林洞穴", "Children of Gaia Caern" = "盖亚之子圣地", "Children of Gaia Bawn" = "盖亚之子圣地周边领地", "Earth's Bounty Food Pantry" = "大地恩赐食物救济站", "Graveyard Interior" = "墓园内室", "Haight Arts Center" = "海特艺术中心", "Chantry" = "秘所", "Chantry Basement" = "秘所地下室", "Millennium Tower F1" = "千禧大厦1层", "Millennium Tower F2" = "千禧大厦2层", "Millennium Tower F3" = "千禧大厦3层", "Millennium Tower F4" = "千禧大厦4层", "Millennium Tower F5" = "千禧大厦5层", "Millennium Tower Penthouse" = "千禧大厦顶层公寓", "Millenium Elevator" = "千禧大厦电梯", "Sewer" = "下水道", "Underground Town" = "地下城镇", "Police Station - Basement" = "警察局－地下室", "Underground Warren" = "地下巢穴", "Underground Bar" = "地下酒吧", "Underground Office" = "地下办公室", "\improper Shop" = "\improper 商店", "Gummaguts" = "咕玛肚", "Bubway" = "巴布威", "Baco Tell" = "巴可特尔", "O'Tolleys" = "奥托利", "Red Dragon" = "红龙", "\improper Coffee Shop" = "\improper 咖啡店", "\improper Clothing Shop" = "\improper 服装店", "\improper Costume Shop" = "\improper 戏服店", "Hot Ishu" = "热潮", "\improper Grocery Store" = "\improper 杂货店", "\improper Gas Station" = "\improper 加油站", "\improper Camping Store" = "\improper 露营用品店", "\improper Music Store" = "\improper 乐器店", "\improper Hardware Store" = "\improper 五金店", "\improper Pawn Shop" = "\improper 当铺", "\improper Gun Store" = "\improper 枪店", "\improper Smoke Shop" = "\improper 烟草店", "\improper Skate Shop" = "\improper 滑板店", "Community Garden" = "社区花园", "\improper Pharmacy" = "\improper 药店", "Financial District" = "金融区", "Ghetto" = "贫民区", "Pacific Heights" = "太平洋高地", "Pacific Heights Forest Outskirts" = "太平洋高地林区边缘", "Pacific Heights - Old District" = "太平洋高地－旧城区", "Pacific Heights - Community Road" = "太平洋高地－社区道路", "Pacific Heights - Industrial District" = "太平洋高地－工业区", "Chinatown" = "唐人街", "Fisherman's Wharf" = "渔人码头", "Fisherman's Wharf - Ghetto" = "渔人码头－贫民区", "Fisherman's Wharf - Lower Beachside" = "渔人码头－下滨海区", "Fisherman's Wharf - Industrial District" = "渔人码头－工业区", "North Beach" = "北滩", "Baywalk District" = "滨湾区", "Union Square" = "联合广场", "Park" = "公园", "Supply" = "补给区", "Cultural District" = "文化区", "Cultural District - Little Italy" = "文化区－小意大利", "Giovanni Mansion - Courtyard" = "乔凡尼宅邸－庭院", "Forest" = "森林", "Graveyard" = "墓园", "Woodland" = "林地"))
/area/vtm/proc/break_elysium()
	if (zone_type != ZONE_MASQUERADE)
		return

	zone_type = ZONE_NO_MASQUERADE
	addtimer(CALLBACK(src, PROC_REF(restore_elysium)), 3 MINUTES)
/area/vtm/Initialize(mapload) { name = GLOB.localized_darkpack_area_names[name] || name; return ..(); }
/area/vtm/proc/restore_elysium()
	if (zone_type != ZONE_NO_MASQUERADE)
		return

	zone_type = ZONE_MASQUERADE

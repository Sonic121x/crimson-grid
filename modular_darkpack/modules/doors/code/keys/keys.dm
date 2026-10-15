GLOBAL_LIST_INIT(key_access_by_types, init_key_access_by_types())
GLOBAL_LIST_INIT(city_door_lock_ids, list())

/// Builds a list of the access locks because we cant pull lists from un initlizied keys and we dont want to qdel a key for every spawn.
/proc/init_key_access_by_types()
	var/list/keys_by_type = list()
	for(var/subtype in valid_subtypesof(/obj/item/vamp/keys))
		var/obj/item/vamp/keys/temp_key = new subtype()
		keys_by_type[subtype] = temp_key.accesslocks
		qdel(temp_key)

	return keys_by_type

/proc/key_has_matching_door(key_type)
	for(var/access in GLOB.key_access_by_types[key_type])
		if(access in GLOB.city_door_lock_ids)
			return TRUE

	return FALSE


/obj/item/vamp/keys
	name = "钥匙"
	desc = "可以打开某些门。"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "keys"
	gender = PLURAL
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/keys
	resistance_flags = FIRE_PROOF | ACID_PROOF
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

	var/list/accesslocks = list(
		"nothing"
	)
	var/roundstart_fix = FALSE

/datum/armor/keys
	fire = 100
	acid = 100

//===========================VAMPIRE KEYS===========================
/obj/item/vamp/keys/camarilla
	name = "\improper 密党钥匙"
	accesslocks = list(LOCKACCESS_CAMARILLA)
	color = "#bd3327"

/obj/item/vamp/keys/prince
	name = "亲王钥匙"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_PRINCE,
		LOCKACCESS_CLERK,
		LOCKACCESS_CHANTRY,
		LOCKACCESS_THEATRE,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/sheriff
	name = "治安官钥匙"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_PRINCE,
		LOCKACCESS_THEATRE,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_CLERK,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/clerk
	name = "总管钥匙"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_CLERK,
		LOCKACCESS_THEATRE,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
		LOCKACCESS_PRINCE,
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla
	name = "\improper 千禧大厦钥匙"
	accesslocks = list(
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CLERK,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla/ghoul
	name = "\improper 千禧大厦员工钥匙"
	accesslocks = list(
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CLERK,
		LOCKACCESS_CAMARILLA
	)
	color = "#bd3327"

/obj/item/vamp/keys/archive
	name = "档案室钥匙"
	accesslocks = list(
		LOCKACCESS_CHANTRY
	)

/obj/item/vamp/keys/regent
	name = "高级档案室钥匙"
	accesslocks = list(
		LOCKACCESS_CHANTRY,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)

/obj/item/vamp/keys/baron
	name = "男爵钥匙"
	accesslocks = list(
		LOCKACCESS_BAR,
		LOCKACCESS_ANARCH,
		LOCKACCESS_BAR_DELIVERY,
		LOCKACCESS_BARON,
	)
	color = "#434343"

/obj/item/vamp/keys/anarch
	name = "酒吧钥匙"
	accesslocks = list(
		LOCKACCESS_BAR,
		LOCKACCESS_ANARCH,
		LOCKACCESS_BAR_DELIVERY,
	)
	color = "#434343"

/obj/item/vamp/keys/anarch_limited
	name = "酒保钥匙"
	accesslocks = list(
		LOCKACCESS_BAR
	)
	color = "#434343"

/obj/item/vamp/keys/giovanni
	name = "黑手党钥匙"
	accesslocks = list(
		LOCKACCESS_GIOVANNI,
		LOCKACCESS_BANK
	)

/obj/item/vamp/keys/capo
	name = "家主钥匙"
	accesslocks = list(
		LOCKACCESS_BANKBOSS,
		LOCKACCESS_BANK,
		LOCKACCESS_GIOVANNI
	)


/obj/item/vamp/keys/baali
	name = "撒旦钥匙"
	accesslocks = list(
		LOCKACCESS_BAALI
	)

/obj/item/vamp/keys/lasombra
	name = "黑暗钥匙"
	accesslocks = list(
		LOCKACCESS_LASOMBRA,
		LOCKACCESS_KIASYD,
		LOCKACCESS_CHURCH
	)
	color = "#290355"

/obj/item/vamp/keys/lasombra/primogen
	name = "极其黑暗的钥匙"
	accesslocks = list(
		LOCKACCESS_LASOMBRA,
		LOCKACCESS_KIASYD,
		LOCKACCESS_CHURCH,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_PRIMOGEN_LASOMBRA,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_THEATRE,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_PRIMOGEN_LASOMBRA,
	)
	color = "#4b039c"

/obj/item/vamp/keys/daughters
	name = "风格杂糅的钥匙"
	accesslocks = list(
		LOCKACCESS_DAUGHTERS
	)

/obj/item/vamp/keys/salubri
	name = "阴谋钥匙"
	accesslocks = list(
		LOCKACCESS_SALUBRI
	)

/obj/item/vamp/keys/old_clan_tzimisce
	name = "尊贵的钥匙"
	accesslocks = list(
		LOCKACCESS_OLD_CLAN_TZI
	)

/obj/item/vamp/keys/malkav
	name = "疯狂钥匙"
	accesslocks = list(
		LOCKACCESS_MALK
	)
	color = "#8cc4ff"

/obj/item/vamp/keys/malkav/primogen
	name = "极其疯狂的钥匙"
	accesslocks = list(
		LOCKACCESS_MALK_PRIMOGEN,
		LOCKACCESS_MALK,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#2c92ff"

/obj/item/vamp/keys/toreador
	name = "性感钥匙"
	accesslocks = list(
		LOCKACCESS_TOREADOR,
		"toreador1",
		"toreador2",
		"toreador3",
		"toreador4"
	)
	color = "#ffa7e6"

/obj/item/vamp/keys/banuhaqim
	name = "公正的钥匙"
	accesslocks = list(
		LOCKACCESS_BANU
	)
	color = "#06053d"

/obj/item/vamp/keys/banuhaqim/primogen
	name = "极其公正的钥匙" // lol
	accesslocks = list(
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_THEATRE,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_BANU,
		LOCKACCESS_BANU_PRIMOGEN,
	)
/obj/item/vamp/keys/toreador/primogen
	name = "极其性感的钥匙"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_TOREADOR,
		LOCKACCESS_TOREADOR,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
		LOCKACCESS_STRIP, //CRIMSON GRID ADD | PR: Adds Strip Key Access to Toreador Primogen (They own the Club)
	)
	color = "#ff2fc4"

/obj/item/vamp/keys/nosferatu
	name = "丑陋钥匙"
	accesslocks = list(
		LOCKACCESS_NOSFERATU
	)
	color = "#93bc8e"

/obj/item/vamp/keys/nosferatu/primogen
	name = "极其丑陋的钥匙"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_NOSFERATU,
		LOCKACCESS_NOSFERATU,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#367c31"

/obj/item/vamp/keys/brujah
	name = "朋克钥匙"
	accesslocks = list(
		LOCKACCESS_BRUJAH
	)
	color = "#ecb586"

/obj/item/vamp/keys/brujah/primogen
	name = "极其朋克的钥匙"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_BRUJAH,
		LOCKACCESS_BRUJAH,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA
	)
	color = "#ec8f3e"

/obj/item/vamp/keys/ventrue
	name = "商务范的钥匙"
	accesslocks = list(
		LOCKACCESS_VENTRUE,
		LOCKACCESS_JAZZ_CLUB
	)
	color = "#f6ffa7"

/obj/item/vamp/keys/ventrue/primogen
	name = "商务范十足的钥匙"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_VENTRUE,
		LOCKACCESS_VENTRUE,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#e8ff29"

/obj/item/vamp/keys/cappadocian
	name = "腐蚀的钥匙"
	accesslocks = list(
		LOCKACCESS_CAPPADOCIAN
	)
	color = "#99620e"

/obj/item/vamp/keys/sabbat
	name = "脏钥匙"
	accesslocks = list(
		LOCKACCESS_SABBAT
	)
	color = "#6a2e1d"

/obj/item/vamp/keys/setite
	name = "瑟泰信徒钥匙"
	accesslocks = list(
		LOCKACCESS_SETITE
	)

//===========================CLINIC KEYS===========================
/obj/item/vamp/keys/clinic
	name = "诊所钥匙"
	accesslocks = list(
		LOCKACCESS_CLINIC
	)

/obj/item/vamp/keys/clinics_director
	name = "诊所主任钥匙"
	accesslocks = list(
		LOCKACCESS_CLINIC,
		LOCKACCESS_DIRECTOR
	)

//===========================POLICE KEYS===========================
/obj/item/vamp/keys/police
	name = "警局钥匙"
	accesslocks = list(
		LOCKACCESS_POLICE
	)

/obj/item/vamp/keys/police/federal
	name = "联邦探员钥匙"
	accesslocks = list(
		LOCKACCESS_POLICE,
		LOCKACCESS_FEDERAL
	)

/obj/item/vamp/keys/dispatch
	name = "调度员钥匙"
	accesslocks = list(
		LOCKACCESS_DISPATCH
	)

/obj/item/vamp/keys/police/secure
	name = "警长钥匙"
	accesslocks = list(
		LOCKACCESS_POLICE,
		LOCKACCESS_POLICE_SECURE
	)

/obj/item/vamp/keys/police/secure/captain
	name = "警监钥匙"
	accesslocks = list(
		LOCKACCESS_DISPATCH,
		LOCKACCESS_POLICE,
		LOCKACCESS_POLICE_SECURE,
		LOCKACCESS_POLICE_CAPTAIN
	)

//===========================FERA KEYS===========================

/obj/item/vamp/keys/nps
	name = "\improper 公园管理局钥匙"
	accesslocks = list(
		LOCKACCESS_PARK_RANGER
	)
	color = "#1e7531"

/obj/item/vamp/keys/techstore
	name = "科技商店钥匙"
	accesslocks = list(
		LOCKACCESS_WOLFTECH
	)
	color = "#466a72"

/obj/item/vamp/keys/pentex
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "设施钥匙"
	accesslocks = list(
		LOCKACCESS_PENTEX
	)
	color = "#062e03"

/obj/item/vamp/keys/pentex/leader
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "管理层钥匙"
	accesslocks = list(
		LOCKACCESS_PENTEX,
		LOCKACCESS_PENTEX_LEADER
	)
	color = "#062e03"

/obj/item/vamp/keys/children_of_gaia
	name = "食物救济站钥匙"
	accesslocks = list(
		LOCKACCESS_COGGIE
	)
	color = "#339933"

//===========================MISC KEYS===========================

/obj/item/vamp/keys/triads
	name = "生锈的钥匙"
	accesslocks = list(
		LOCKACCESS_TRAID,
		LOCKACCESS_LAUNDROMAT
	)

/obj/item/vamp/keys/graveyard
	name = "墓园钥匙"
	accesslocks = list(
		LOCKACCESS_GRAVEYARD
	)

/obj/item/vamp/keys/cleaning
	name = "保洁钥匙"
	accesslocks = list(
		LOCKACCESS_CLEANING
	)

/obj/item/vamp/keys/church
	name = "教堂钥匙"
	accesslocks = list(
		LOCKACCESS_CHURCH
	)

/obj/item/vamp/keys/hunter
	name = "奇怪的钥匙"
	accesslocks = list(
		LOCKACCESS_HUNTER
	)

/obj/item/vamp/keys/kiasyd
	name = "博物馆钥匙"
	accesslocks = list(
		LOCKACCESS_KIASYD
	)

/obj/item/vamp/keys/supply
	name = "货运钥匙"
	accesslocks = list(
		LOCKACCESS_SUPPLY
	)
	color = "#434343"

/obj/item/vamp/keys/strip
	name = "脱衣舞俱乐部钥匙"
	accesslocks = list(
		LOCKACCESS_STRIP
	)

/obj/item/vamp/keys/taxi
	name = "出租车钥匙"
	accesslocks = list(
		LOCKACCESS_TAXI
	)
	color = "#fffb8b"

/obj/item/vamp/keys/apartment
	name = "公寓钥匙"
	desc = "某人家的钥匙。希望不是弄丢的。"
	accesslocks = list(
		"apartment"
	)

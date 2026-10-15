/datum/preference/choiced/country_of_origin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "country_of_origin"
	can_randomize = FALSE

/datum/preference/choiced/country_of_origin/init_possible_values()
	return list(
		"Afghanistan" = "阿富汗", "Albania" = "阿尔巴尼亚", "Algeria" = "阿尔及利亚", "American Samoa" = "美属萨摩亚", "Andorra" = "安道尔", "Angola" = "安哥拉", "Antigua and Barbuda" = "安提瓜和巴布达", "Argentina" = "阿根廷", "Armenia" = "亚美尼亚", "Australia" = "澳大利亚", "Austria" = "奥地利", "Azerbaijan" = "阿塞拜疆", "Bahamas" = "巴哈马",
		"Bahrain" = "巴林", "Bangladesh" = "孟加拉国", "Barbados" = "巴巴多斯", "Belarus" = "白俄罗斯", "Belgium" = "比利时", "Belize" = "伯利兹", "Benin" = "贝宁", "Bermuda" = "百慕大", "Bhutan" = "不丹", "Bolivia" = "玻利维亚", "Bosnia and Herzegovina" = "波斯尼亚和黑塞哥维那", "Botswana" = "博茨瓦纳", "Brazil" = "巴西", "Brunei" = "文莱", "Bulgaria" = "保加利亚", "Burkina Faso" = "布基纳法索",
		"Burundi" = "布隆迪", "Cambodia" = "柬埔寨", "Cameroon" = "喀麦隆", "Canada" = "加拿大", "Cape Verde" = "佛得角", "Cayman Islands" = "开曼群岛", "Central African Republic" = "中非共和国", "Chad" = "乍得", "Chile" = "智利", "China" = "中国", "Colombia" = "哥伦比亚", "Comoros" = "科摩罗", "Democratic Republic of the Congo" = "刚果民主共和国",
		"Republic of the Congo" = "刚果共和国", "Costa Rica" = "哥斯达黎加", "Côte d'Ivoire" = "科特迪瓦", "Croatia" = "克罗地亚", "Cuba" = "古巴", "Curaçao" = "库拉索", "Cyprus" = "塞浦路斯", "Czech Republic" = "捷克共和国", "Denmark" = "丹麦", "Djibouti" = "吉布提", "Dominica" = "多米尼克", "Dominican Republic" = "多米尼加共和国", "East Timor" = "东帝汶",
		"Ecuador" = "厄瓜多尔", "Egypt" = "埃及", "El Salvador" = "萨尔瓦多", "Equatorial Guinea" = "赤道几内亚", "Eritrea" = "厄立特里亚", "Estonia" = "爱沙尼亚", "Ethiopia" = "埃塞俄比亚", "Faroe Islands" = "法罗群岛", "Fiji" = "斐济", "Finland" = "芬兰", "France" = "法国", "French Polynesia" = "法属波利尼西亚", "Gabon" = "加蓬", "Gambia" = "冈比亚", "Georgia" = "格鲁吉亚", "Germany" = "德国",
		"Ghana" = "加纳", "Greece" = "希腊", "Greenland" = "格陵兰", "Grenada" = "格林纳达", "Guam" = "关岛", "Guatemala" = "危地马拉", "Guinea" = "几内亚", "Guinea-Bissau" = "几内亚比绍", "Guyana" = "圭亚那", "Haiti" = "海地", "Honduras" = "洪都拉斯", "Hong Kong" = "香港", "Hungary" = "匈牙利", "Iceland" = "冰岛", "India" = "印度", "Indonesia" = "印度尼西亚", "Iran" = "伊朗", "Iraq" = "伊拉克", "Ireland" = "爱尔兰",
		"Israel" = "以色列", "Italy" = "意大利", "Jamaica" = "牙买加", "Japan" = "日本", "Jordan" = "约旦", "Kazakhstan" = "哈萨克斯坦", "Kenya" = "肯尼亚", "Kiribati" = "基里巴斯", "North Korea" = "朝鲜", "South Korea" = "韩国", "Kosovo" = "科索沃", "Kuwait" = "科威特", "Kyrgyzstan" = "吉尔吉斯斯坦", "Laos" = "老挝", "Latvia" = "拉脱维亚", "Lebanon" = "黎巴嫩", "Lesotho" = "莱索托", "Liberia" = "利比里亚",
		"Libya" = "利比亚", "Liechtenstein" = "列支敦士登", "Lithuania" = "立陶宛", "Luxembourg" = "卢森堡", "Macedonia" = "马其顿", "Madagascar" = "马达加斯加", "Malawi" = "马拉维", "Malaysia" = "马来西亚", "Maldives" = "马尔代夫", "Mali" = "马里", "Malta" = "马耳他", "Marshall Islands" = "马绍尔群岛", "Mauritania" = "毛里塔尼亚", "Mauritius" = "毛里求斯", "Mexico" = "墨西哥",
		"Micronesia" = "密克罗尼西亚", "Moldova" = "摩尔多瓦", "Monaco" = "摩纳哥", "Mongolia" = "蒙古", "Montenegro" = "黑山", "Morocco" = "摩洛哥", "Mozambique" = "莫桑比克", "Myanmar" = "缅甸", "Namibia" = "纳米比亚", "Nauru" = "瑙鲁", "Nepal" = "尼泊尔", "Netherlands" = "荷兰", "New Zealand" = "新西兰", "Nicaragua" = "尼加拉瓜", "Niger" = "尼日尔", "Nigeria" = "尼日利亚", "Northern Mariana Islands" = "北马里亚纳群岛",
		"Norway" = "挪威", "Oman" = "阿曼", "Pakistan" = "巴基斯坦", "Palau" = "帕劳", "State of Palestine" = "巴勒斯坦国", "Panama" = "巴拿马", "Papua New Guinea" = "巴布亚新几内亚", "Paraguay" = "巴拉圭", "Peru" = "秘鲁", "Philippines" = "菲律宾", "Poland" = "波兰", "Portugal" = "葡萄牙", "Puerto Rico" = "波多黎各", "Qatar" = "卡塔尔", "Romania" = "罗马尼亚", "Russia" = "俄罗斯",
		"Rwanda" = "卢旺达", "Saint Kitts and Nevis" = "圣基茨和尼维斯", "Saint Lucia" = "圣卢西亚", "Saint Vincent and the Grenadines" = "圣文森特和格林纳丁斯", "Samoa" = "萨摩亚", "San Marino" = "圣马力诺", "Sao Tome and Principe" = "圣多美和普林西比", "Saudi Arabia" = "沙特阿拉伯", "Senegal" = "塞内加尔", "Serbia" = "塞尔维亚", "Seychelles" = "塞舌尔", "Sierra Leone" = "塞拉利昂",
		"Singapore" = "新加坡", "Sint Maarten" = "荷属圣马丁", "Slovakia" = "斯洛伐克", "Slovenia" = "斯洛文尼亚", "Solomon Islands" = "所罗门群岛", "Somalia" = "索马里", "South Africa" = "南非", "Spain" = "西班牙", "Sri Lanka" = "斯里兰卡", "Sudan" = "苏丹", "South Sudan" = "南苏丹", "Suriname" = "苏里南", "Swaziland" = "斯威士兰", "Sweden" = "瑞典", "Switzerland" = "瑞士", "Syria" = "叙利亚",
		"Taiwan" = "台湾", "Tajikistan" = "塔吉克斯坦", "Tanzania" = "坦桑尼亚", "Thailand" = "泰国", "Togo" = "多哥", "Tonga" = "汤加", "Trinidad and Tobago" = "特立尼达和多巴哥", "Tunisia" = "突尼斯", "Turkey" = "土耳其", "Turkmenistan" = "土库曼斯坦", "Tuvalu" = "图瓦卢", "Uganda" = "乌干达", "Ukraine" = "乌克兰", "United Arab Emirates" = "阿拉伯联合酋长国", "United Kingdom" = "英国",
		"United States" = "美国", "Uruguay" = "乌拉圭", "Uzbekistan" = "乌兹别克斯坦", "Vanuatu" = "瓦努阿图", "Vatican City" = "梵蒂冈", "Venezuela" = "委内瑞拉", "Vietnam" = "越南", "British Virgin Islands" = "英属维尔京群岛", "U.S. Virgin Islands" = "美属维尔京群岛", "Yemen" = "也门", "Zambia" = "赞比亚", "Zimbabwe" = "津巴布韦"
	)
/datum/preference/choiced/country_of_origin/compile_constant_data() { return ..() + list("display_names" = get_choices()); }
/datum/preference/choiced/country_of_origin/create_informed_default_value(datum/preferences/preferences)
	if(prob(90)) //most people are gonna be from the USA
		return ..()
	return pick(cached_values)

/datum/preference/choiced/country_of_origin/create_default_value()
	return "United States"

/datum/preference/choiced/country_of_origin/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.country_of_origin = value
	var/static/list/country_language_map
	if(!country_language_map)
		country_language_map = list(
			// spanish-speaking countries
			"Argentina" = list(/datum/language/spanish),
			"Bolivia" = list(/datum/language/spanish),
			"Chile" = list(/datum/language/spanish),
			"Colombia" = list(/datum/language/spanish),
			"Costa Rica" = list(/datum/language/spanish),
			"Cuba" = list(/datum/language/spanish),
			"Dominican Republic" = list(/datum/language/spanish),
			"Ecuador" = list(/datum/language/spanish),
			"El Salvador" = list(/datum/language/spanish),
			"Equatorial Guinea" = list(/datum/language/spanish),
			"Guatemala" = list(/datum/language/spanish),
			"Honduras" = list(/datum/language/spanish),
			"Mexico" = list(/datum/language/spanish),
			"Nicaragua" = list(/datum/language/spanish),
			"Panama" = list(/datum/language/spanish),
			"Paraguay" = list(/datum/language/spanish),
			"Peru" = list(/datum/language/spanish),
			"Puerto Rico" = list(/datum/language/spanish),
			"Spain" = list(/datum/language/spanish),
			"Uruguay" = list(/datum/language/spanish),
			"Venezuela" = list(/datum/language/spanish),
			// arabic/middle eastern countries
			"Algeria" = list(/datum/language/arabic),
			"Bahrain" = list(/datum/language/arabic),
			"Comoros" = list(/datum/language/arabic),
			"Djibouti" = list(/datum/language/arabic),
			"Egypt" = list(/datum/language/arabic),
			"Iraq" = list(/datum/language/arabic),
			"Jordan" = list(/datum/language/arabic),
			"Lebanon" = list(/datum/language/arabic),
			"Libya" = list(/datum/language/arabic),
			"Mauritania" = list(/datum/language/arabic),
			"Morocco" = list(/datum/language/arabic),
			"Oman" = list(/datum/language/arabic),
			"Kuwait" = list(/datum/language/arabic),
			"Qatar" = list(/datum/language/arabic),
			"Saudi Arabia" = list(/datum/language/arabic),
			"Somalia" = list(/datum/language/arabic),
			"State of Palestine" = list(/datum/language/arabic),
			"Sudan" = list(/datum/language/arabic),
			"Syria" = list(/datum/language/arabic),
			"Tunisia" = list(/datum/language/arabic),
			"United Arab Emirates" = list(/datum/language/arabic),
			"Yemen" = list(/datum/language/arabic),
			// farsi + arabic
			"Afghanistan" = list(/datum/language/farsi, /datum/language/arabic),
			"Iran" = list(/datum/language/farsi, /datum/language/arabic),
			"Tajikistan" = list(/datum/language/farsi, /datum/language/arabic),
			// french-speaking countries
			"Belgium" = list(/datum/language/french),
			"Benin" = list(/datum/language/french),
			"Burkina Faso" = list(/datum/language/french),
			"Cameroon" = list(/datum/language/french),
			"Central African Republic" = list(/datum/language/french),
			"Chad" = list(/datum/language/french),
			"Côte d'Ivoire" = list(/datum/language/french),
			"Democratic Republic of the Congo" = list(/datum/language/french),
			"France" = list(/datum/language/french),
			"French Polynesia" = list(/datum/language/french),
			"Gabon" = list(/datum/language/french),
			"Guinea" = list(/datum/language/french),
			"Haiti" = list(/datum/language/french),
			"Luxembourg" = list(/datum/language/french),
			"Madagascar" = list(/datum/language/french),
			"Mali" = list(/datum/language/french),
			"Mauritius" = list(/datum/language/french),
			"Monaco" = list(/datum/language/french),
			"Niger" = list(/datum/language/french),
			"Republic of the Congo" = list(/datum/language/french),
			"Rwanda" = list(/datum/language/french),
			"Senegal" = list(/datum/language/french),
			"Seychelles" = list(/datum/language/french),
			"Togo" = list(/datum/language/french),
			// german-speaking countries
			"Austria" = list(/datum/language/german),
			"Germany" = list(/datum/language/german),
			"Liechtenstein" = list(/datum/language/german),
			"Switzerland" = list(/datum/language/german),
			// russian-speaking countries
			"Belarus" = list(/datum/language/russian),
			"Kazakhstan" = list(/datum/language/russian),
			"Kyrgyzstan" = list(/datum/language/russian),
			"Russia" = list(/datum/language/russian),
			"Turkmenistan" = list(/datum/language/russian),
			"Uzbekistan" = list(/datum/language/russian),
			// italian-speaking countries
			"Italy" = list(/datum/language/italian),
			"San Marino" = list(/datum/language/italian),
			// korean
			"North Korea" = list(/datum/language/korean),
			"South Korea" = list(/datum/language/korean),
			// greek
			"Cyprus" = list(/datum/language/greek),
			"Greece" = list(/datum/language/greek),
			// mandarin
			"China" = list(/datum/language/mandarin),
			"Singapore" = list(/datum/language/mandarin),
			"Taiwan" = list(/datum/language/mandarin),
			"Japan" = list(/datum/language/japanese),
			"Poland" = list(/datum/language/polish),
			"Czech Republic" = list(/datum/language/czech),
			"Ukraine" = list(/datum/language/ukrainian, /datum/language/russian),
			"Armenia" = list(/datum/language/armenian),
			"Israel" = list(/datum/language/hebrew),
			"Hong Kong" = list(/datum/language/mandarin, /datum/language/cantonese),
			"Philippines" = list(/datum/language/tagalog),
			"Ireland" = list(/datum/language/irish),
			"Vatican City" = list(/datum/language/latin),
		)
	var/list/languages = country_language_map[value]
	if(!languages)
		return
	for(var/language_type in languages)
		if(!target.has_language(language_type))
			target.grant_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE, source = "province_of_origin")

/datum/preference/choiced/state_of_origin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "state_of_origin"
	priority = /datum/preference/choiced/country_of_origin::priority + 0.1
	can_randomize = FALSE
	must_be_accessible = TRUE

/datum/preference/choiced/state_of_origin/init_possible_values()
	return list(
		"Alabama" = "阿拉巴马州", "Alaska" = "阿拉斯加州", "Arizona" = "亚利桑那州", "Arkansas" = "阿肯色州", "California" = "加利福尼亚州", "Colorado" = "科罗拉多州", "Connecticut" = "康涅狄格州", "Delaware" = "特拉华州", "Florida" = "佛罗里达州", "Georgia" = "佐治亚州",
		"Hawaii" = "夏威夷州", "Idaho" = "爱达荷州", "Illinois" = "伊利诺伊州", "Indiana" = "印第安纳州", "Iowa" = "艾奥瓦州", "Kansas" = "堪萨斯州", "Kentucky" = "肯塔基州", "Louisiana" = "路易斯安那州", "Maine" = "缅因州", "Maryland" = "马里兰州",
		"Massachusetts" = "马萨诸塞州", "Michigan" = "密歇根州", "Minnesota" = "明尼苏达州", "Mississippi" = "密西西比州", "Missouri" = "密苏里州", "Montana" = "蒙大拿州", "Nebraska" = "内布拉斯加州", "Nevada" = "内华达州", "New Hampshire" = "新罕布什尔州", "New Jersey" = "新泽西州",
		"New Mexico" = "新墨西哥州", "New York" = "纽约州", "North Carolina" = "北卡罗来纳州", "North Dakota" = "北达科他州", "Ohio" = "俄亥俄州", "Oklahoma" = "俄克拉何马州", "Oregon" = "俄勒冈州", "Pennsylvania" = "宾夕法尼亚州", "Rhode Island" = "罗得岛州", "South Carolina" = "南卡罗来纳州",
		"South Dakota" = "南达科他州", "Tennessee" = "田纳西州", "Texas" = "得克萨斯州", "Utah" = "犹他州", "Vermont" = "佛蒙特州", "Virginia" = "弗吉尼亚州", "Washington" = "华盛顿州", "West Virginia" = "西弗吉尼亚州", "Wisconsin" = "威斯康星州", "Wyoming" = "怀俄明州",
		"District of Columbia" = "哥伦比亚特区", "Puerto Rico" = "波多黎各", "Guam" = "关岛", "U.S. Virgin Islands" = "美属维尔京群岛", "American Samoa" = "美属萨摩亚", "Northern Mariana Islands" = "北马里亚纳群岛"
	)
/datum/preference/choiced/state_of_origin/compile_constant_data() { return ..() + list("display_names" = get_choices()); }
/datum/preference/choiced/state_of_origin/create_informed_default_value(datum/preferences/preferences)
	if(prob(80))
		return ..()
	return pick(cached_values)

/datum/preference/choiced/state_of_origin/create_default_value()
	return "California"

/datum/preference/choiced/state_of_origin/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.country_of_origin = "United States, [value]"

/datum/preference/choiced/state_of_origin/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	var/country = preferences.read_preference(/datum/preference/choiced/country_of_origin)
	return (country == "United States")

/datum/preference/choiced/province_of_origin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "province_of_origin"
	priority = /datum/preference/choiced/country_of_origin::priority + 0.1
	can_randomize = FALSE
	must_be_accessible = TRUE

/datum/preference/choiced/province_of_origin/init_possible_values()
	return list(
		"British Columbia" = "不列颠哥伦比亚省", "Alberta" = "艾伯塔省", "Saskatchewan" = "萨斯喀彻温省", "Manitoba" = "马尼托巴省", "Ontario" = "安大略省", "Quebec" = "魁北克省", "New Brunswick" = "新不伦瑞克省",
		"Nova Scotia" = "新斯科舍省", "Prince Edward Island" = "爱德华王子岛省", "Newfoundland and Labrador" = "纽芬兰与拉布拉多省", "Yukon" = "育空地区", "Northwest Territories" = "西北地区",
		"Nunvaut" = "努纳武特地区",
	)
/datum/preference/choiced/province_of_origin/compile_constant_data() { return ..() + list("display_names" = get_choices()); }
/datum/preference/choiced/province_of_origin/create_informed_default_value(datum/preferences/preferences)
	if(prob(50))
		return ..()
	return pick(cached_values)

/datum/preference/choiced/province_of_origin/create_default_value()
	return "Ontario"

/datum/preference/choiced/province_of_origin/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.country_of_origin = "Canada, [value]"
	var/static/list/province_language_map
	if(!province_language_map)
		province_language_map = list(
			// french-speaking provinces
			"Quebec" = list(/datum/language/french),
			"New Brunswick" = list(/datum/language/french),
			"Yukon" = list(/datum/language/french),
		)
	var/list/languages = province_language_map[value]
	if(!languages)
		return
	for(var/language_type in languages)
		if(!target.has_language(language_type))
			target.grant_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE, source = "country_of_origin")

/datum/preference/choiced/province_of_origin/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	var/country = preferences.read_preference(/datum/preference/choiced/country_of_origin)
	return (country == "Canada")

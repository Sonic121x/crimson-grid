/// Singleton datums used to hold material property info
/datum/material_property
	abstract_type = /datum/material_property
	var/name = "错误"
	/// Associated property ID
	var/id = null
	/// Should this property be inherited by child materials?
	var/inherited = TRUE

/// Returns a string to display to sci glasses wearers when the material is examined
/datum/material_property/proc/get_descriptor(value)
	return null

/// Returns the contents of the tooltip under our descriptor
/datum/material_property/proc/get_tooltip(value)
	return "[value < 0 ? "-" : ""]\Roman[round(abs(value), 1)]"

/// Called whenever a material with this property initializes. Mostly used for behavior tracking on optional properties
/datum/material_property/proc/attach_to(datum/material/material)
	return

/// How dense a material is
/datum/material_property/density
	name = "密度"
	id = MATERIAL_DENSITY

/datum/material_property/density/get_descriptor(value)
	// Just for reference, IRL density of ABS plastic and water is ~1g/cm3, glass is 2.5, iron is 7.5 and lead is 11
	// So 0 ~ 1 would be paper/cardboard, then wood at 2, plastic at 3, glass at 4, iron at 6 and lead at 8 ~ 9
	switch(value)
		if (0 to 1)
			return "极其轻盈"
		if (1 to 2)
			return "十分轻盈"
		if (2 to 3)
			return "轻盈"
		if (3 to 4)
			return "稍显致密"
		if (4 to 6)
			return "致密"
		if (6 to 8)
			return "十分致密"
		if (8 to INFINITY)
			return "极其致密"

/// How hard to deformation a material is, pierce/slashing impacts
/datum/material_property/hardness
	name = "硬度"
	id = MATERIAL_HARDNESS

/datum/material_property/hardness/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极其柔软"
		if (1 to 2)
			return "十分柔软"
		if (2 to 3)
			return "柔软"
		if (3 to 4)
			return "稍显坚硬"
		if (4 to 6)
			return "坚硬"
		if (6 to 8)
			return "十分坚硬"
		if (8 to INFINITY)
			return "极其坚硬"

/// How well a material bends and sustains deformation
/datum/material_property/flexibility
	name = "柔韧性"
	id = MATERIAL_FLEXIBILITY

/datum/material_property/flexibility/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极其刚硬"
		if (1 to 2)
			return "十分刚硬"
		if (2 to 3)
			return "刚硬"
		if (3 to 4)
			return "略有柔韧性"
		if (4 to 6)
			return "柔韧"
		if (6 to 8)
			return "十分柔韧"
		if (8 to INFINITY)
			return "极其柔韧"

/// How shiny a material is
/datum/material_property/reflectivity
	name = "反射率"
	id = MATERIAL_REFLECTIVITY

/datum/material_property/reflectivity/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "极其暗淡"
		if (1 to 2)
			return "十分暗淡"
		if (2 to 3)
			return "暗淡"
		if (3 to 4)
			return "哑光"
		if (4 to 6)
			return "反光"
		if (6 to 8)
			return "反光强烈"
		if (8 to INFINITY)
			return "反光极强"

/// How electrically conductive a material is (siemens coeff)
/datum/material_property/electric_conductivity
	name = "导电性"
	id = MATERIAL_ELECTRICAL

/datum/material_property/electric_conductivity/get_descriptor(value)
	switch(value)
		if (0)
			return "完全绝缘"
		if (0 to 1)
			return "高度绝缘"
		if (1 to 2)
			return "绝缘"
		if (2 to 3)
			return "绝缘性较差"
		if (3 to 4)
			return "略微导电"
		if (4 to 6)
			return "导电"
		if (6 to 8)
			return "导电性很强"
		if (8 to INFINITY)
			return "导电性极强"

/// How well a material conducts heat
/datum/material_property/thermal_conductivity
	name = "导热性"
	id = MATERIAL_THERMAL

/datum/material_property/thermal_conductivity/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "隔热性极强"
		if (1 to 2)
			return "隔热性很强"
		if (2 to 3)
			return "隔热"
		if (3 to 4)
			return "略微导热"
		if (4 to 6)
			return "导热"
		if (6 to 8)
			return "导热性很强"
		if (8 to INFINITY)
			return "导热性极强"

/// How well the material resists acids and other similar chemicals
/datum/material_property/chemical_resistance
	name = "耐化学腐蚀性"
	id = MATERIAL_CHEMICAL

/datum/material_property/chemical_resistance/get_descriptor(value)
	switch(value)
		if (0 to 1)
			return "化学性质极其活泼"
		if (1 to 2)
			return "化学性质活泼"
		if (2 to 3)
			return "化学性质略显活泼"
		if (3 to 4)
			return "略耐化学腐蚀"
		if (4 to 6)
			return "耐化学腐蚀"
		if (6 to 8)
			return "耐化学腐蚀性很强"
		if (8 to INFINITY)
			return "耐化学腐蚀性极强"

// Symptoms are the effects that engineered advanced diseases do.

/datum/symptom
	var/name = "8-bitten bugs"
	///Basic symptom description
	var/desc = "If you see this something went very wrong."
	///Potential illness name caused by the symptom
	var/illness = "Unidentified"
	///Descriptions of threshold effects
	var/threshold_descs = list()
	///How the symptom affects the disease's stealth stat, positive values make it less noticeable
	var/stealth = 0
	///How the symptom affects the disease's resistance stat, positive values make it harder to cure
	var/resistance = 0
	///How the symptom affects the disease's stage speed stat, positive values cause faster stage progression
	var/stage_speed = 0
	///How the symptom affects the disease's transmissibility
	var/transmittable = 0
	///The type level of the symptom. Higher is harder to generate.
	var/level = 0
	///The severity level of the symptom. Higher is more dangerous.
	var/severity = 0
	///The hash tag for our diseases, we will add it up with our other symptoms to get a unique id! ID MUST BE UNIQUE!!!
	var/id = ""
	///Base chance of sending warning messages, so it can be modified
	var/base_message_chance = 10
	///Ticks between each activation
	var/next_activation = 0
	var/symptom_delay = 1 // Measured in seconds, not ticks or life ticks
	var/delay_variation = 0.25 // Anywhere from -25% to +25%
	///Can be used to multiply virus effects
	var/power = 1
	///A neutered symptom has no effect, and only affects statistics.
	var/neutered = FALSE
	var/list/thresholds
	///If this symptom can appear from /datum/disease/advance/GenerateSymptoms()
	var/naturally_occuring = TRUE
	///If the symptom requires an organ for the effects to function, robotic organs are immune to disease unless inorganic biology symptom is present
	var/required_organ
	///The remedy for this symptom
	var/datum/reagent/symptom_cure = /datum/reagent/medicine/spaceacillin
	///What color the cure text shows up in the pandemic UI
	var/cure_color = "green"
	///A remedied symptom has no effect and contributes to the cure
	var/remedied = FALSE
	///Whether or not mobs can gain immunity to this symptom after recovering from a disease with it
	var/immunity_proof = FALSE

/datum/symptom/New()
	var/list/S = SSdisease.list_symptoms
	for(var/i = 1; i <= S.len; i++)
		if(type == S[i])
			id = "[i]"
			return
	CRASH("We couldn't assign an ID!")

///Called when processing of the advance disease that holds this symptom infects a host and upon each Refresh() of that advance disease.
/datum/symptom/proc/Start(datum/disease/advance/advanced_disease)
	if(neutered)
		return FALSE
	if(name in advanced_disease.affected_mob.symptom_resistances)
		symptom_delay *= 1.75
	return TRUE

///Called when the advance disease is going to be deleted or when the advance disease stops processing.
/datum/symptom/proc/End(datum/disease/advance/A)
	if(neutered)
		return FALSE
	return TRUE

/datum/symptom/proc/Activate(datum/disease/advance/advanced_disease)
	if(neutered)
		return FALSE
	if(required_organ)
		if(!advanced_disease.has_required_infectious_organ(advanced_disease.affected_mob, required_organ))
			return FALSE
	if(symptom_cure)
		if(symptom_cure && advanced_disease.affected_mob.has_reagent(symptom_cure))
			remedied = TRUE
			return FALSE
		remedied = FALSE
	if(world.time < next_activation)
		return FALSE
	else
		next_activation = world.time + rand(symptom_delay * (1 - delay_variation) SECONDS, symptom_delay * (1 + delay_variation) SECONDS) * DISEASE_SYMPTOM_FREQUENCY_MODIFIER
		return TRUE

/datum/symptom/proc/on_stage_change(datum/disease/advance/A)
	if(neutered)
		return FALSE
	return TRUE

/datum/symptom/proc/Copy()
	var/datum/symptom/new_symp = new type
	new_symp.name = name
	new_symp.id = id
	new_symp.neutered = neutered
	return new_symp

/datum/symptom/proc/generate_threshold_desc()
	return

///Overload when a symptom needs to be active before processing, like changing biotypes.
/datum/symptom/proc/OnAdd(datum/disease/advance/A)
	return

///Overload for running after processing.
/datum/symptom/proc/OnRemove(datum/disease/advance/A)
	return

/proc/localized_symptom_name(symptom_name)
	var/base_name = endswith(symptom_name, " (neutered)") ? copytext(symptom_name, 1, -11) : symptom_name
	var/display_name = list("Facial Hypertrichosis" = "面部多毛症", "Anticoagulant" = "抗凝血", "Hypertension" = "高血压", "Chills" = "寒战", "Choking" = "气道阻塞", "Acute respiratory distress syndrome" = "急性呼吸窘迫综合征", "Confusion" = "意识混乱", "Cough" = "咳嗽", "Deafness" = "耳聋", "Disfiguration" = "毁容", "Dizziness" = "眩晕", "Fever" = "发热", "Spontaneous Combustion" = "自燃", "Alkali perspiration" = "碱性排汗", "Necrotizing Fasciitis" = "坏死性筋膜炎", "Autophagocytosis Necrosis" = "自噬性坏死", "Dormant DNA Activator" = "休眠基因激活", "Hallucigen" = "致幻", "Headache" = "头痛", "Starlight Condensation" = "星光凝聚", "Toxolysis" = "化学分解", "Metabolic Boost" = "代谢加速", "Nocturnal Regeneration" = "暗处再生", "Regenerative Coma" = "再生性昏迷", "Tissue Hydration" = "水合修复", "Plasma Fixation" = "等离子固定", "Radioactive Resonance" = "辐射共振", "Aggressive Healing" = "侵入性愈合", "Mutated Regeneration" = "突变再生", "Itching" = "瘙痒", "Narcolepsy" = "发作性睡病", "Self-Respiration" = "自主供氧", "Mind Restoration" = "心智修复", "Sensory Restoration" = "感官修复", "Alopecia" = "脱毛症", "Polyvitiligo" = "多彩皮肤症", "Sneezing" = "喷嚏", "Necrotic Metabolism" = "坏死代谢", "Inorganic Biology" = "无机生物适应", "Thermoregulation" = "体温调节", "Viral self-adaptation" = "病毒自适应", "Viral evolutionary acceleration" = "病毒进化加速", "Hyphema" = "前房积血", "Voice Change" = "变声", "Vomiting" = "呕吐", "Nebula Vomiting" = "星云呕吐", "Weight Loss" = "体重下降", "Eternal Youth" = "青春永驻")[base_name] || base_name
	return "[display_name][base_name != symptom_name ? "（已失活）" : ""]"
/proc/localized_symptom_cure(datum/reagent/cure_type)
	return cure_type ? (list(/datum/reagent/medicine/c2/tirimol = "眠氧宁", /datum/reagent/toxin/bonehurtingjuice = "骨痛汁", /datum/reagent/medicine/leporazine = "恒温嗪", /datum/reagent/medicine/mannitol = "甘露醇", /datum/reagent/acetaldehyde = "乙醛", /datum/reagent/inverse/penthrite = "再搏素", /datum/reagent/medicine/synaptizine = "突触嗪", /datum/reagent/medicine/psicodine = "安神定", /datum/reagent/consumable/frostoil = "冰霜油", /datum/reagent/medicine/haloperidol = "氟哌啶醇", /datum/reagent/consumable/milk = "牛奶", /datum/reagent/drug/space_drugs = "太空毒品", /datum/reagent/medicine/ondansetron = "昂丹司琼", /datum/reagent/medicine/omnizine = "全能嗪", /datum/reagent/medicine/earthsblood = "大地之血", /datum/reagent/barbers_aid = "生发助剂", /datum/reagent/water/salt = "盐水", /datum/reagent/medicine/spaceacillin = "太空西林", /datum/reagent/medicine/oculine = "明目灵", /datum/reagent/inverse/healing/convermol = "肺膜素", /datum/reagent/medicine/diphenhydramine = "苯海拉明")[cure_type] || cure_type::name) : "无"
/datum/symptom/proc/get_symptom_data()
	var/list/data = list()
	data["name"] = localized_symptom_name(name)
	data["desc"] = desc
	data["stealth"] = stealth
	data["resistance"] = resistance
	data["stage_speed"] = stage_speed
	data["transmission"] = transmittable
	data["level"] = level
	data["neutered"] = neutered
	data["threshold_desc"] = threshold_descs
	if(symptom_cure)
		var/datum/reagent/cure = symptom_cure
		data["symptom_cure"] = localized_symptom_cure(cure)
	else
		data["symptom_cure"] = "无"
	data["cure_color"] = cure_color
	return data

/// Check if we can generate randomly
/datum/symptom/proc/can_generate_randomly()
	return naturally_occuring

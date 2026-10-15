/// Datum holding information about pod type visuals, VFX, name and description
/// These are not created anywhere and thus should not be assigned procs, only being used as data storage
/datum/pod_style
	/// Name that pods of this style will be named by default
	var/name = "补给舱"
	/// Name that is displayed to admins in pod config panel
	var/ui_name = "Standard"
	/// Description assigned to droppods of this style
	var/desc = "纳诺传讯空投补给舱。"
	/// Determines if this pod can use animations/masking/overlays
	var/shape = POD_SHAPE_NORMAL
	/// Base icon state assigned to this pod
	var/icon_state = "pod"
	/// Whenever this pod should have a door overlay added to it. Uses [icon_state]_door sprite
	var/has_door = TRUE
	/// Decals added to this pod, if any
	var/decal_icon = "default"
	/// Color that this pod glows when landing
	var/glow_color = "yellow"
	/// Type of rubble that this pod creates upon landing
	var/rubble_type = RUBBLE_NORMAL
	/// ID for TGUI data
	var/id = "standard"

/datum/pod_style/advanced
	name = "蓝空间补给舱"
	ui_name = "Advanced"
	desc = "纳诺传讯蓝空间补给舱。配送完成后会传送回中央指挥部。"
	decal_icon = "bluespace"
	glow_color = "blue"
	id = "bluespace"

/datum/pod_style/centcom
	name = "\improper 中央指挥部补给舱"
	ui_name = "Nanotrasen"
	desc = "纳诺传讯补给舱，带有中央指挥部标识。配送完成后会传送回中央指挥部。"
	decal_icon = "centcom"
	glow_color = "blue"
	id = "centcom"

/datum/pod_style/syndicate
	name = "血红色补给舱"
	ui_name = "Syndicate"
	desc = "一个令人胆寒的补给舱，遍布辛迪加的血红色标记。最好还是离它远一点。"
	icon_state = "darkpod"
	decal_icon = "syndicate"
	glow_color = "red"
	id = "syndicate"

/datum/pod_style/deathsquad
	name = "\improper 死亡小队空投舱"
	ui_name = "Deathsquad"
	desc = "纳诺传讯空投舱，带有纳诺传讯精锐突击队的标记。"
	icon_state = "darkpod"
	decal_icon = "deathsquad"
	glow_color = "blue"
	id = "deathsquad"

/datum/pod_style/cultist
	name = "染血的补给舱"
	ui_name = "Cultist"
	desc = "一个纳诺传讯补给舱，上面布满抓痕、鲜血和奇异的符文。"
	decal_icon = "cultist"
	glow_color = "red"
	id = "cultist"

/datum/pod_style/missile
	name = "巡航导弹"
	ui_name = "Missile"
	desc = "一枚大得吓人的导弹，似乎并未完全引爆。它很可能来自遥远深空中的某座导弹发射井。侧面似乎有个辅助载荷舱门，但恐怕无法手动打开。"
	shape = POD_SHAPE_OTHER
	icon_state = "missile"
	has_door = FALSE
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_THIN
	id = "missile"

/datum/pod_style/missile/syndicate
	name = "\improper 辛迪加巡航导弹"
	ui_name = "Syndie Missile"
	desc = "一枚大得吓人的血红色导弹，似乎并未完全引爆。它很可能来自深空中的某座辛迪加导弹发射井。侧面似乎有个辅助载荷舱门，但恐怕无法手动打开。"
	icon_state = "smissile"
	id = "syndie_missile"

/datum/pod_style/box
	name = "\improper 奥塞克补给箱"
	ui_name = "Supply Box"
	desc = "一个极其坚固的补给箱，专为承受轨道再入而设计。侧面刻着“奥塞克军械库——2532”。"
	shape = POD_SHAPE_OTHER
	icon_state = "box"
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_WIDE
	id = "supply_box"

/datum/pod_style/clown
	name = "\improper HONK舱"
	ui_name = "Clown Pod"
	desc = "一个色彩鲜艳的补给舱，很可能来自小丑联邦。"
	icon_state = "clownpod"
	decal_icon = "clown"
	glow_color = "green"
	id = "clown"

/datum/pod_style/orange
	name = "\improper 橙子"
	ui_name = "Fruit"
	desc = "一颗愤怒的橙子。"
	shape = POD_SHAPE_OTHER
	icon_state = "orange"
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_WIDE
	id = "orange"

/datum/pod_style/invisible
	name =  "\improper S.T.E.A.L.T.H.隐形舱MKVII型"
	ui_name = "Invisible"
	desc = "一个在正常情况下完全无法用常规手段探测到的补给舱。你到底是怎么看见它的？"
	shape = POD_SHAPE_OTHER
	has_door = FALSE
	icon_state = null
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_NONE
	id = "invisible"

/datum/pod_style/gondola
	name = "冈多拉"
	ui_name = "Gondola"
	desc = "沉默的行者。这位似乎属于某家配送机构。"
	shape = POD_SHAPE_OTHER
	icon_state = "gondola"
	has_door = FALSE
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_NONE
	id = "gondola"

/datum/pod_style/seethrough
	name = null
	ui_name = "Seethrough"
	desc = null
	shape = POD_SHAPE_OTHER
	has_door = FALSE
	icon_state = null
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_NONE
	id = "seethrough"

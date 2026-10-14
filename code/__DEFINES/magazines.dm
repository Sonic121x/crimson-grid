/// Appended to the description of magazines that spawn with old-fashioned incendiary ammo, which generally leave fire trails and give firestacks in return for less base damage.
#define MAGAZINE_DESC_INC "<br>装有可点燃目标并留下火焰轨迹的弹药，但造成的伤害较低。"
/// Appended to the description of magazines that spawn with hollow-point ammo, which generally has higher base damage but is weak against armor.
#define MAGAZINE_DESC_HOLLOWPOINT "<br>装有空尖弹，对无护甲目标效果显著，但对护甲的效果极差。"
/// Appended to the description of magazines that spawn with armor-piercing ammo, which generally has less base damage but penetrates armor.
#define MAGAZINE_DESC_ARMORPIERCE "<br>装有穿甲弹，对有护甲目标效果显著，但对无护甲目标的效果较差。"

/// Defines a magazine to, visually, be for incendiary ammo by setting the ammo band color and appending a short blurb to the description.
#define MAGAZINE_TYPE_INCENDIARY \
	ammo_band_color = COLOR_AMMO_INCENDIARY; \
	desc = parent_type::desc + MAGAZINE_DESC_INC;

/// Defines a magazine to, visually, be for hollow-point ammo by setting the ammo band color and appending a short blurb to the description.
#define MAGAZINE_TYPE_HOLLOWPOINT \
	ammo_band_color = COLOR_AMMO_HOLLOWPOINT; \
	desc = parent_type::desc + MAGAZINE_DESC_HOLLOWPOINT;

/// Defines a magazine to, visually, be for armor-piercing ammo by setting the ammo band color and appending a short blurb to the description.
#define MAGAZINE_TYPE_ARMORPIERCE \
	ammo_band_color = COLOR_AMMO_ARMORPIERCE; \
	desc = parent_type::desc + MAGAZINE_DESC_ARMORPIERCE;

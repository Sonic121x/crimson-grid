// Pretty generic ones for reuse if you dont really want/need a subtype
/datum/storyteller_roll/turn_cooldown
	reroll_cooldown = 1 TURNS

/datum/storyteller_roll/scene_cooldown
	reroll_cooldown = 1 SCENES

/datum/storyteller_roll/spammy
	spammy_roll = TRUE

// Mostly TTRPG accurate rolls

// Combat
/datum/storyteller_roll/attack
	bumper_text = "攻击"
	spammy_roll = TRUE
	alert_prefix = "⚔"
	applicable_stats = list(STAT_DEXTERITY, STAT_BRAWL)

/datum/storyteller_roll/attack/punch
	bumper_text = "攻击（拳击）"

/datum/storyteller_roll/attack/bite
	bumper_text = "攻击（啃咬）"
	difficulty = 5

/datum/storyteller_roll/attack/kick
	bumper_text = "攻击（踢击）"
	difficulty = 7

/datum/storyteller_roll/attack/claw
	bumper_text = "攻击（爪击）"

// Cant tell wether this is meant to be to land or for damage dice.
/datum/storyteller_roll/attack/claw/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_RAZOR_CLAWS))
		. -= 1

/datum/storyteller_roll/attack/sweep
	bumper_text = "攻击（扫腿）"
	difficulty = 8


/datum/storyteller_roll/damage
	bumper_text = "伤害"
	numerical = TRUE
	spammy_roll = TRUE
	// Ok listen I know this is just an emoji but it looks fine ingame.
	alert_prefix = "✊"
	alert_delay = 0.2 SECONDS
	applicable_stats = list(STAT_STRENGTH)

/datum/storyteller_roll/damage/punch
	bumper_text = "伤害（拳击）"

/datum/storyteller_roll/damage/punch/using_bonus(mob/living/roller, atom/target, bonus_added)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_RAZOR_CLAWS)) // Your still using claws. A bit homebrew tho.
		. += 1
	if(HAS_TRAIT(roller, TRAIT_BRASSKNUCKLES))	// Method for giving brass knuckles bonus punch damage. It's blunt, and punch damage is naturally low, so equals out.
		. += 2

/datum/storyteller_roll/damage/bite
	bumper_text = "伤害（啃咬）"
	bonus = 1

/datum/storyteller_roll/damage/kick
	bumper_text = "伤害（踢击）"
	bonus = 1

/datum/storyteller_roll/damage/claw
	bumper_text = "伤害（爪击）"
	bonus = 2

/datum/storyteller_roll/damage/claw/using_bonus(mob/living/roller, atom/target, bonus_added)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_RAZOR_CLAWS))
		. += 2

/datum/storyteller_roll/damage/claw/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_RAZOR_CLAWS))
		. -= 1


/datum/storyteller_roll/damage/attacker_disarm
	numerical = TRUE
	applicable_stats = list(STAT_STRENGTH)

/datum/storyteller_roll/shooting
	bumper_text = "射击"
	applicable_stats = list(STAT_DEXTERITY, STAT_FIREARMS)
	reroll_cooldown = 1 TURNS
	numerical = TRUE


/datum/storyteller_roll/tackle_attacker
	numerical = TRUE
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)

/*
/datum/storyteller_roll/tackle_attacker/using_stats(mob/living/roller)
	. = ..()
	var/strength_brawl = roller.st_get_stat(STAT_STRENGTH) + roller.st_get_stat(STAT_BRAWL)
	var/dex_athletics = roller.st_get_stat(STAT_DEXTERITY) + roller.st_get_stat(STAT_ATHLETICS)
	if(strength_brawl >= dex_athletics)
		. = list(STAT_STRENGTH, STAT_BRAWL)
	else
		. = list(STAT_DEXTERITY, STAT_ATHLETICS)
*/

/datum/storyteller_roll/tackle_defender
	numerical = TRUE
	applicable_stats = list(STAT_DEXTERITY, STAT_ATHLETICS)

// Physical Feats
/datum/storyteller_roll/lockpick
	bumper_text = "撬锁"
	reroll_cooldown = 1 SCENES
	applicable_stats = list(STAT_DEXTERITY, STAT_LARCENY)

/datum/storyteller_roll/bash_door
	bumper_text = "破门"
	reroll_cooldown = 1 SCENES
	applicable_stats = list(STAT_STRENGTH)

/datum/storyteller_roll/bash_door/using_dice(mob/living/roller, bonus)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_HUGE_SIZE))
		. += 2

/datum/storyteller_roll/grappling
	bumper_text = "擒抱"
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)
	numerical = TRUE
	spammy_roll = TRUE

/datum/storyteller_roll/grappled
	bumper_text = "挣扎"
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)
	numerical = TRUE
	spammy_roll = TRUE

/datum/storyteller_roll/climbing
	bumper_text = "攀爬"
	applicable_stats = list(STAT_DEXTERITY, STAT_ATHLETICS)

/datum/storyteller_roll/climbing/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if(roller.has_status_effect(/datum/status_effect/city_running)) // In theory could check for if its the city...
		. -= 2

// Mental Feats
/datum/storyteller_roll/investigation
	bumper_text = "调查"
	applicable_stats = list(STAT_PERCEPTION, STAT_INVESTIGATION)
	roll_output_type = ROLL_FLAG_ROLLER


// Made up shittttt
/datum/storyteller_roll/identify_occult
	bumper_text = "鉴定"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_OCCULT)
	reroll_cooldown = 1 SCENES
	difficulty = 8


/datum/storyteller_roll/slip_restraints
	bumper_text = "脱出束缚"
	applicable_stats = list(STAT_DEXTERITY, STAT_STEALTH)
	// reroll_cooldown = 1 TURNS
	difficulty = 8

/datum/storyteller_roll/slip_restraints/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if(roller.has_status_effect(/datum/status_effect/shed))
		. -= 2

// Based on `Feats of Strength` WTA pg. 270
/datum/storyteller_roll/restraint_break
	bumper_text = "破坏束缚"
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	// reroll_cooldown = 1 TURNS
	difficulty = 9

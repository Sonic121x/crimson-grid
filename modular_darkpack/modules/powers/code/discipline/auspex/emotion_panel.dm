GLOBAL_LIST_INIT(localized_emotion_choices, list("恐惧" = "Afraid", "好斗" = "Aggressive", "愤怒" = "Angry", "怨怼" = "Bitter", "平静" = "Calm", "怜悯" = "Compassionate", "保守" = "Conservative", "消沉" = "Depressed", "欲望" = "Desirous", "不信任" = "Distrustful", "嫉妒" = "Envious", "兴奋" = "Excited", "慷慨" = "Generous", "快乐" = "Happy", "憎恨" = "Hateful", "理想主义" = "Idealistic", "纯真" = "Innocent", "爱意" = "Lovestruck", "执念" = "Obsessed", "悲伤" = "Sad", "灵性" = "Spiritual", "怀疑" = "Suspicious", "焦虑" = "Anxious", "困惑" = "Confused", "心不在焉" = "Daydreaming", "精神错乱" = "Psychotic", "自信" = "Confidence", "腐化" = "Corruption"))
GAME_VERB_DESC(/mob, emotion_panel, "情绪面板", "改变你的角色情绪。", "IC")
	if(HAS_TRAIT(src, TRAIT_FORCED_EMOTION))
		to_chat(src, span_warning("你现在无法改变情绪。"))
		return FALSE

	// This really shouldnt be using aura here. it needs to be detached and made unrelenient on aura/auspex. - Fallcon
	var/new_emotion = GLOB.localized_emotion_choices[tgui_input_list(src, "你现在是什么心情？", "情绪", GLOB.localized_emotion_choices)]
	if(isnull(new_emotion))
		return FALSE
	set_emotion(new_emotion)

/mob/proc/set_emotion(new_emotion)
	if(current_emotion == new_emotion)
		return

	current_emotion = new_emotion
	SEND_SIGNAL(src, COMSIG_MOB_EMOTION_CHANGED, new_emotion)

/datum/status_effect/question_emotion
	id = "question_emotion"
	// Nothing says it needs to be a scene, I just like using our defines to create nice standards of time.
	duration = 1 SCENES

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/question_emotion

/atom/movable/screen/alert/status_effect/question_emotion
	name = "审视情绪"
	desc = "内心的某种感受让你反复审视自己的情绪。"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "riddle"
	click_master = FALSE
	clickable_glow = TRUE

/atom/movable/screen/alert/status_effect/question_emotion/Click()
	. = ..()
	if(!.)
		return FALSE

	attached_effect.owner.emotion_panel()
	// Regardless if they acctually end up setting anything, clear the status effect
	qdel(attached_effect)

/datum/status_effect/forced_emotion
	id = "question_emotion"
	// Nothing says it needs to be a scene, I just like using our defines to create nice standards of time.
	duration = 1 SCENES

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/forced_emotion

/atom/movable/screen/alert/status_effect/forced_emotion
	name = "强加的情绪"
	desc = "某种力量正迫使你的心灵陷入特定情绪。"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "in_love"

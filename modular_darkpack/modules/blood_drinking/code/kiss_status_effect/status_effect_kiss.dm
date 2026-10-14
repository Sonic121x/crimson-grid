/datum/status_effect/kissed
	id = "kissed"
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/kissed

/datum/status_effect/kissed/on_apply()
	. = ..()
	to_chat(owner, span_userlove("尖锐的獠牙刺穿你的皮肤，但一股令人麻木的暖意随之涌来，痛楚很快消退……")) //feel free to change these
	owner.add_client_colour(/datum/client_colour/brightened, "kissed")
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.adjust_eye_blur(15)
		H.adjust_dizzy(10)

/datum/status_effect/kissed/on_remove()
	to_chat(owner, span_userlove("醒来时，你难以回想起刚才几分钟发生的事，只记得一种温暖而愉悦的感觉。")) //feel free to change these
	owner.remove_client_colour("kissed")
	owner.SetSleeping(50)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.adjust_confusion(10)
	return ..()

/atom/movable/screen/alert/status_effect/kissed
	name = "血吻迷醉"
	desc = "愉悦感充盈了你的全身！"
	icon_state = "in_love" //would be good to give this it's own icon eventually

/datum/client_colour/brightened
	priority = CLIENT_COLOR_IMPORTANT_PRIORITY
	color = list(1.15,0,0,0,1.15,0,0,0,1.15,0,0,0)

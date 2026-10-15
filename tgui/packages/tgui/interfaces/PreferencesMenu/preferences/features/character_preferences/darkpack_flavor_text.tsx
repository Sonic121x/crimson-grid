// THIS IS A DARKPACK UI FILE
import {
  type Feature,
  FeatureTextInput,
} from '../base';

export const flavor_text: Feature<string> = {
  name: '外观描述',
  description: "他人查看角色时显示，仅在身份可辨认时可见（戴上防毒面具就能遮蔽身份）。",
  component: FeatureTextInput,
};

export const war_form_flavor_text: Feature<string> = {
  name: '外观描述（战斗形态）',
  description: "角色处于变形者的战斗形态（Crinos）时，他人查看角色会看到这段文字，替代通常的外观描述。",
  component: FeatureTextInput,
};

export const feral_form_flavor_text: Feature<string> = {
  name: '外观描述（野兽形态）',
  description: "角色处于变形者的巨兽或野兽形态（Hispo/Lupus）时，他人查看角色会看到这段文字，替代通常的外观描述。",
  component: FeatureTextInput,
};

export const nsfw_flavor_text: Feature<string> = {
  name: '外观描述（成人内容）',
  description: "他人查看角色时显示，仅在身份可辨认时可见（戴上防毒面具就能遮蔽身份）。",
  component: FeatureTextInput,
};

export const character_notes: Feature<string> = {
  name: '角色备注',
  description:
    '关于这个角色的角色外信息，例如你是否希望人类角色成为血仆或接受初拥。',
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: '玩家备注（成人内容）',
  description: '填写你希望其他玩家了解的信息，例如参与对抗剧情的意愿、会让你本人感到不适的内容等。',
  component: FeatureTextInput,
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const criminal_record: Feature<string> = {
  name: '犯罪档案',
  description: '拥有安保权限者可查看。用于填写犯罪记录、逮捕经历等。',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: '医疗档案',
  description: '拥有医疗权限者可查看。用于填写病史、处方、拒绝心肺复苏指示等。',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: '可利用情报',
  description:
    '可填写角色内或角色外信息，特定对抗角色及幽灵可查看。通常包括 \
  弱点、长处、重要背景、触发词等，也可以填写 \
  对抗剧情偏好，例如是否愿意卷入冲突、希望与谁互动、接受哪些手段等。',
  component: FeatureTextInput,
};

export const background_info: Feature<string> = {
  name: '背景档案',
  description: '仅自己和幽灵可查看。可以自由填写，用来梳理角色的身份、身世与经历。',
  component: FeatureTextInput,
};

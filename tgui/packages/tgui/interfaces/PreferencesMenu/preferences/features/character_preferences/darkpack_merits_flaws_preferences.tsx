// THIS IS A DARKPACK UI FILE
import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const territorial: FeatureChoiced = {
  name: '领地',
  description: '角色的狩猎领地。',
  component: FeatureDropdownInput,
};

export const prey_exclusion: FeatureChoiced = {
  name: '猎物禁忌',
  description: '角色拒绝捕食的猎物类型。',
  component: FeatureDropdownInput,
};

export const missing_arm: FeatureChoiced = {
  name: '缺失的手臂',
  component: FeatureDropdownInput,
};

export const lame_leg: FeatureChoiced = {
  name: '瘸腿',
  component: FeatureDropdownInput,
};

export const acute_sense: FeatureChoiced = {
  name: '敏锐感官',
  component: FeatureDropdownInput,
};

export const fetish_merit: FeatureChoiced = {
  name: '灵器',
  description: '选择灵器。',
  component: FeatureDropdownInput,
};

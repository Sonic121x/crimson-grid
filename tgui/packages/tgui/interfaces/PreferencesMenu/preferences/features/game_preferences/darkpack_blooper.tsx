// THIS IS A DARKPACK UI FILE
import { CheckboxInput, type FeatureToggle, FeatureSliderInput, type FeatureNumeric } from '../base';

export const blooper_hear: FeatureToggle = {
  name: '启用角色说话音效',
  category: 'SOUND',
  description: `启用后，可以听见其他角色的说话音效。`,
  component: CheckboxInput,
};

export const sound_blooper_volume: FeatureNumeric = {
  name: '角色说话音效音量',
  category: 'SOUND',
  description: '角色说话音效的播放音量。',
  component: FeatureSliderInput,
};

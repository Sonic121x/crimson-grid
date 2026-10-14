import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureToggle,
} from '../base';
import {
  FeatureDropdownInput,
  FeatureIconnedDropdownInput,
} from '../dropdowns';

export const language: FeatureChoiced = {
  name: '语言',
  component: FeatureIconnedDropdownInput,
};

export const language_speakable: FeatureToggle = {
  name: '能够使用该语言',
  description: `取消勾选后，你只能理解这种语言，
    无法用它说话。`,
  component: CheckboxInput,
};

export const language_skill: FeatureChoiced = {
  name: '语言熟练度',
  description: '你能理解这种语言的百分比。',
  component: FeatureDropdownInput,
};

export const csl_strength: FeatureChoiced = {
  name: '语言熟练度',
  description: '你能理解通用语的百分比。',
  component: FeatureDropdownInput,
};

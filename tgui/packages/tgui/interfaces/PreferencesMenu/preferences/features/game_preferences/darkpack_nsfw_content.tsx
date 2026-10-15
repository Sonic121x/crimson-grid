import { CheckboxInput, type FeatureToggle } from '../base';

export const nsfw_content_pref: FeatureToggle = {
  name: '启用成人内容',
  category: 'GAMEPLAY',
  description: '允许查看含成人内容的外观描述。',
  component: CheckboxInput,
};

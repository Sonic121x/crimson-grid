import { CheckboxInput, type FeatureToggle } from '../base';

export const show_flavor_text_when_masked: FeatureToggle = {
  name: '蒙面时显示身份',
  description:
    '启用后，即使蒙面，其他人仍可查看你的外观描述，认识你的人也能看到你的名字。',
  component: CheckboxInput,
};

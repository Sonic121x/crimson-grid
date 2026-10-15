import { CheckboxInput, type FeatureToggle } from '../base';

export const ranged_click_to_melee: FeatureToggle = {
  name: '点击远处时发动近战攻击',
  category: 'GAMEPLAY',
  description: `
    点击攻击范围外的地块时，朝该方向挥击或发动定向攻击。
  `,
  component: CheckboxInput,
};

import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const adjective_preference: FeatureChoiced = {
  name: '外貌形容词',
  description: '用一个词描述角色的外貌。',
  component: FeatureDropdownInput,
};

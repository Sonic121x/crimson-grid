// THIS IS A DARKPACK UI FILE

import type { FeatureToggle } from '../base';
import { CheckboxInput } from '../base';

export const looc_admin_pref: FeatureToggle = {
  name: 'See admin LOOC',
  category: 'ADMIN',
  description:
    'Toggles whether you want to see LOOC anywhere as an admin or not.',
  component: CheckboxInput,
};

export const enable_looc_runechat: FeatureToggle = {
  name: '在头顶显示本地角色外聊天',
  category: 'RUNECHAT',
  description:
    "启用后，本地角色外聊天（LOOC）会同时显示在聊天栏和说话者头顶。",
  component: CheckboxInput,
};

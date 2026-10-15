import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureToggle,
} from '../base';
import {
  FeatureDropdownInput,
  FeatureIconnedDropdownInput,
} from '../dropdowns';
export const darkpackLanguageNames: Record<string, string> = { Arabic: '阿拉伯语', Armenian: '亚美尼亚语', Cantonese: '粤语', Czech: '捷克语', English: '英语', Persian: '波斯语', French: '法语', German: '德语', Greek: '希腊语', Hebrew: '希伯来语', Irish: '爱尔兰语', Italian: '意大利语', Japanese: '日语', Korean: '朝鲜语', Latin: '拉丁语', Mandarin: '普通话', Polish: '波兰语', Russian: '俄语', Scottish: '苏格兰盖尔语', Español: '西班牙语', Tagalog: '他加禄语', Ukrainian: '乌克兰语', Welsh: '威尔士语', 'Garou Tongue': '狼人语', 'Primal Tongue': '原始语' };
export const language: FeatureChoiced = {
  name: '语言',
  component: (props) => <FeatureIconnedDropdownInput {...props} serverData={props.serverData && { ...props.serverData, display_names: { ...props.serverData.display_names, ...darkpackLanguageNames } }} />,
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

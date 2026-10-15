import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const garou_fur_color: FeatureChoiced = {
  name: '狼人毛色',
  component: (props) => <FeatureDropdownInput {...props} serverData={props.serverData && { ...props.serverData, display_names: Object.fromEntries(props.serverData.choices.map((choice) => [choice, ({ black: '黑色', gray: '灰色', red: '红色', white: '白色', ginger: '姜黄色', brown: '棕色' } as Record<string, string>)[choice] ?? choice])) }} />,
};

export const corax_fur_color: FeatureChoiced = {
  name: '渡鸦变形者羽色',
  component: (props) => <FeatureDropdownInput {...props} serverData={props.serverData && { ...props.serverData, display_names: Object.fromEntries(props.serverData.choices.map((choice) => [choice, ({ black: '黑色', brown: '棕色', white: '白色', green: '绿色', red: '红色', gray: '灰色' } as Record<string, string>)[choice] ?? choice])) }} />,
};


export const garou_hair: FeatureChoiced = {
  name: '狼人毛发',
  component: (props) => <FeatureDropdownInput {...props} serverData={props.serverData && { ...props.serverData, display_names: Object.fromEntries(props.serverData.choices.map((choice) => [choice, ({ None: '无', Mohawk: '莫霍克发型', Long: '长发', Undercut: '两侧剃短', Beard: '胡须' } as Record<string, string>)[choice] ?? choice])) }} />,
};

export const garou_body: FeatureChoiced = {
  name: '狼人身体特征',
  component: (props) => <FeatureDropdownInput {...props} serverData={props.serverData && { ...props.serverData, display_names: Object.fromEntries(props.serverData.choices.map((choice) => [choice, ({ None: '无', 'Right Eye Scar': '右眼伤疤', 'Left Eye Scar': '左眼伤疤', 'Nose Scar': '鼻部伤疤', 'Chest Scar': '胸部伤疤', 'Leg Scar': '腿部伤疤', 'Head Scar': '头部伤疤', 'Shoulder Scar': '肩部伤疤', 'Right Artificial Arm': '右臂义肢', 'Left Artificial Arm': '左臂义肢' } as Record<string, string>)[choice] ?? choice])) }} />,
};

export const garou_clothes: FeatureChoiced = {
  name: '狼人服装',
  component: (props) => <FeatureDropdownInput {...props} serverData={props.serverData && { ...props.serverData, display_names: Object.fromEntries(props.serverData.choices.map((choice) => [choice, ({ None: '无', Loincloth: '裆布', 'Green Tribal Accessories': '绿色部族饰物', 'Beige Tribal Accessories': '米色部族饰物', 'Leather Mantle': '皮革披肩', Studs: '铆钉饰物', 'Dark Mantle': '深色披肩', 'Loincloth & Armband': '裆布与臂环', 'Skull Necklace': '骷髅项链', 'Metal Armor': '金属护甲', 'Fur Mantle': '毛皮披肩', 'Fur Necklace & Vambraces': '毛皮项链与护臂', 'Armor & Loincloth': '护甲与裆布', 'Red Cloak': '红色斗篷', 'Formal Tribal Attire': '部族礼服', '$$$ Bling': '美元金链' } as Record<string, string>)[choice] ?? choice])) }} />,
};

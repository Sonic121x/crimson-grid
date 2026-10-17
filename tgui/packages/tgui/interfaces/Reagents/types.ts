import type { Dispatch, SetStateAction } from 'react';
import type { BooleanLike } from 'tgui-core/react';

export type ReagentsData = {
  beakerSync: BooleanLike;
  bitflags: Record<string, number>;
  currentReagents: string[];
  linkedBeaker: string;
  master_reaction_list: Reaction[];
  reagent_mode_reagent: Reagent | null;
  reagent_mode_recipe: Recipe | null;
  selectedBitflags: number;
};

export type ReagentsProps = {
  pageState: [number, Dispatch<SetStateAction<number>>];
};

type Pairs = [
  [number, number],
  [number, number],
  [number, number],
  [number, number],
];

export type Recipe = {
  catalysts: Reagent[];
  explodeTemp: number;
  explosive: Pairs;
  hasProduct: BooleanLike;
  id: string;
  inversePurity: string;
  isColdRecipe: BooleanLike;
  lowerpH: number;
  minPurity: number;
  name: string;
  reactants: Reactant[];
  reagentCol: string;
  reqContainer: string | null;
  subReactIndex: number;
  subReactLen: number;
  tempMin: number;
  thermics: string;
  thermodynamics: Pairs;
  thermoUpper: number;
  upperpH: number;
};

type Reactant = {
  color: string;
  id: string;
  name: string;
  ratio: number;
  tooltip: string | null;
  tooltipBool: BooleanLike;
};

export type Reagent = {
  addictions: string[];
  desc: string;
  id: string;
  metaRate: number;
  name: string;
  OD: number;
  pH: number;
  pHCol: string;
  reagentCol: string;
};

type ReactionReagent = {
  id: string;
  name: string;
};

export type Reaction = {
  bitflags: number;
  id: string;
  name: string;
  reactants: ReactionReagent[];
};

export const bitflagInfo = [
  {
    flag: 'BRUTE',
    icon: 'gavel',
    tooltip: '生成能治疗或造成物理伤害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_brute', // future todo : just make this use ui state
  },
  {
    flag: 'BURN',
    icon: 'burn',
    tooltip: '生成能治疗或造成烧伤的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_burn',
  },
  {
    flag: 'TOXIN',
    icon: 'biohazard',
    tooltip: '生成能治疗或造成毒素伤害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_toxin',
  },
  {
    flag: 'OXY',
    icon: 'wind',
    tooltip: '生成能治疗或造成窒息伤害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_oxy',
  },
  {
    flag: 'HEALING',
    icon: 'medkit',
    tooltip: '生成治疗用试剂。',
    category: 'Type',
    toggle: 'toggle_tag_healing',
  },
  {
    flag: 'DAMAGING',
    icon: 'skull-crossbones',
    tooltip: '生成致伤试剂。',
    category: 'Type',
    toggle: 'toggle_tag_damaging',
  },
  {
    flag: 'EXPLOSIVE',
    icon: 'bomb',
    tooltip: '生成爆炸性试剂，或在反应时发生爆炸。',
    category: 'Type',
    toggle: 'toggle_tag_explosive',
  },
  {
    flag: 'OTHER',
    icon: 'question',
    tooltip: '生成具有其他附带效果的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_other',
  },
  {
    flag: 'DANGEROUS',
    icon: 'exclamation-triangle',
    tooltip: '反应可能立即产生危险效果。',
    category: 'Difficulty',
    toggle: 'toggle_tag_dangerous',
  },
  {
    flag: 'EASY',
    icon: 'chess-pawn',
    tooltip: '容易进行的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_easy',
  },
  {
    flag: 'MODERATE',
    icon: 'chess-knight',
    tooltip: '难度适中的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_moderate',
  },
  {
    flag: 'HARD',
    icon: 'chess-queen',
    tooltip: '难以进行的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_hard',
  },
  {
    flag: 'ORGAN',
    icon: 'brain',
    tooltip: '生成能治疗或造成器官损伤的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_organ',
  },
  {
    flag: 'DRINK',
    icon: 'cocktail',
    tooltip: '调制饮品，通常在酒吧中进行。',
    category: 'Type',
    toggle: 'toggle_tag_drink',
  },
  {
    flag: 'FOOD',
    icon: 'drumstick-bite',
    tooltip: '制作食物，通常在厨房中进行。',
    category: 'Type',
    toggle: 'toggle_tag_food',
  },
  {
    flag: 'SLIME',
    icon: 'microscope',
    tooltip: '与异种生物学有关的反应。',
    category: 'Type',
    toggle: 'toggle_tag_slime',
  },
  {
    flag: 'DRUG',
    icon: 'pills',
    tooltip:
      '生成兼有正面和负面效果、会使人成瘾的试剂。',
    category: 'Type',
    toggle: 'toggle_tag_drug',
  },
  {
    flag: 'UNIQUE',
    icon: 'puzzle-piece',
    tooltip: '独有或特殊的反应。',
    category: 'Type',
    toggle: 'toggle_tag_unique',
  },
  {
    flag: 'CHEMICAL',
    icon: 'flask',
    tooltip: '生成能够改变其他反应的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_chemical',
  },
  {
    flag: 'PLANT',
    icon: 'seedling',
    tooltip: '生成有益或有害于植物的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_plant',
  },
  {
    flag: 'COMPETITIVE',
    icon: 'recycle',
    tooltip: '与其他反应竞争原料的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_competitive',
  },
  {
    flag: 'COMPONENT',
    icon: 'question',
    tooltip: '生成其他反应常用的原料。',
    category: 'Type',
    toggle: 'toggle_tag_component',
  },
  {
    flag: 'ACTIVE',
    icon: 'question',
    tooltip: '反应具有即时生效的效果。',
    category: 'Type',
    toggle: 'toggle_tag_active',
  },
];

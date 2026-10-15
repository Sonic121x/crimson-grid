import type { BooleanLike } from 'tgui-core/react';
import { CATEGORY_ICONS_COOKING, CATEGORY_ICONS_CRAFTING } from './constants';
import type { CraftingData } from './types';
export const getCraftingLabel = (value: string): string => ({ 'can make': '可制作', foods: '食物', drinks: '饮品', 'weapons ranged': '远程武器', 'weapons melee': '近战武器', 'weapon ammo': '武器弹药', robotics: '机器人', misc: '杂项', tribal: '部落工艺', clothing: '服装', chemistry: '化学', atmospherics: '大气设备', structures: '建筑', tiles: '地砖', windows: '窗户', doors: '门', furniture: '家具', equipment: '设备', containers: '容器', tools: '工具', entertainment: '娱乐', 'blood cult': '血之教团', construction: '建造', tzimisce: '茨密希', appetizer: '开胃菜', bread: '面包', burger: '汉堡', burrito: '卷饼', cake: '蛋糕', candy: '糖果', condiment: '调味配菜', component: '半成品', cookie: '饼干', dessert: '甜点', frozen: '冰品', italian: '意式', japanese: '日式', lizard: '蜥蜴风味', martian: '火星风味', meat: '肉类', mexican: '墨西哥风味', mothic: '蛾人风味', noodles: '面食', pastry: '糕点', pie: '派', pizza: '披萨', rice: '米饭', salad: '沙拉', sandwich: '三明治', soup: '汤', sushi: '寿司', taco: '塔可', terran: '地球风味', uncategorized: '未分类', 'main course': '主菜', breakfast: '早餐', snack: '小吃', alcohol: '酒精', bugs: '昆虫', cloth: '衣物', dairy: '乳制品', egg: '蛋类', fried: '油炸食品', fruit: '水果', gore: '血肉脏器', grain: '谷物', gross: '恶心的食物', junkfood: '垃圾食品', nuts: '坚果', oranges: '橙子', pineapple: '菠萝', raw: '生食', seafood: '海鲜', stone: '岩石', sugar: '甜食', toxic: '有毒食物', vegetables: '蔬菜', crowbar: '撬棍', multitool: '多功能工具', screwdriver: '螺丝刀', cutters: '剪线钳', wrench: '扳手', welder: '焊接工具', analyzer: '分析仪', mining: '采矿工具', shovel: '铲子', retractor: '牵开器', hemostat: '止血钳', cautery: '烧灼器', drill: '手术钻', scalpel: '手术刀', saw: '锯子', bonesetter: '正骨器', knife: '刀', bloodfilter: '血液过滤器', 'rolling pin': '擀面杖', rustscraper: '除锈刮刀' }[value.toLowerCase()] || value);
export function findIcon(atom_id: number, data: CraftingData): string {
  let icon: string = data.icon_data[atom_id];
  if (!icon) {
    icon = `${data.mode ? 'cooking32x32' : 'crafting32x32'} a${atom_id}`;
  }

  return icon;
}

export function getFAIcon(category: string, mode: BooleanLike): string {
  const icons = mode ? CATEGORY_ICONS_COOKING : CATEGORY_ICONS_CRAFTING;
  return icons[category] || 'circle';
}

export function toggleArrayItem<T>(array: T[] | undefined, item: T): T[] {
  if (!array) return [item];
  return array.includes(item)
    ? array.filter((i) => i !== item)
    : [...array, item];
}

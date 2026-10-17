import { Button, LabeledList } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { bitflagInfo, type ReagentsData, type ReagentsProps } from './types';

export function TagBox(props: ReagentsProps) {
  const { act, data } = useBackend<ReagentsData>();
  const { bitflags, selectedBitflags } = data;

  const [page, setPage] = props.pageState;

  // first go through all bitflaginfo to find all unique categories
  const allCategories: string[] = [];
  for (const meta of bitflagInfo) {
    if (!allCategories.includes(meta.category)) {
      allCategories.push(meta.category);
    }
  }

  // then fill each category with its respective bitflags
  const categorizedBitflags: Record<string, typeof bitflagInfo> = {};
  for (const category of allCategories) {
    categorizedBitflags[category] = bitflagInfo.filter(
      (meta) => meta.category === category,
    );
  }

  return (
    <LabeledList>
      {Object.entries(categorizedBitflags).map(([category, metas]) => (
        <LabeledList.Item label={({ Affects: '影响', Type: '类型', Difficulty: '难度' } as Record<string, string>)[category] || category} key={category}>
          {metas.map((meta) => {
            const flag = bitflags[meta.flag];
            return (
              <Button
                key={meta.flag}
                selected={(selectedBitflags & flag) !== 0}
                icon={meta.icon}
                tooltip={meta.tooltip}
                onClick={() => {
                  act(meta.toggle);
                  setPage(1);
                }}
              >
                {({ BRUTE: '物理', BURN: '烧伤', TOXIN: '毒素', OXY: '窒息', HEALING: '治疗', DAMAGING: '伤害', EXPLOSIVE: '爆炸', OTHER: '其他', DANGEROUS: '危险', EASY: '简单', MODERATE: '中等', HARD: '困难', ORGAN: '器官', DRINK: '饮品', FOOD: '食物', SLIME: '史莱姆', DRUG: '药物', UNIQUE: '特殊', CHEMICAL: '化学', PLANT: '植物', COMPETITIVE: '竞争', COMPONENT: '原料', ACTIVE: '即时' } as Record<string, string>)[meta.flag] || meta.flag}
              </Button>
            );
          })}
        </LabeledList.Item>
      ))}
    </LabeledList>
  );
}

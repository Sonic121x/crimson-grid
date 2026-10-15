import {
  CheckboxInput,
  type FeatureChoiced,
  FeatureExternalInput,
  type FeatureToggle,
  type FeatureValueProps,
} from '../base';

export const clan_mark: FeatureChoiced = {
  name: '印记',
  component: (props: FeatureValueProps<string, string, { display_names?: Record<string, string> }>) => {
    return <FeatureExternalInput {...props} value={props.serverData?.display_names?.[props.value] ?? props.value} serverData={undefined} />;
  },
};

export const gargoyle_legs_and_tail: FeatureToggle = {
  name: '石像鬼双腿与尾巴',
  component: CheckboxInput,
};

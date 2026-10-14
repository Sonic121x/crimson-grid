// THIS IS A DARKPACK UI FILE
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureSliderInput,
  type FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act, data } = useBackend();

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_choice: FeatureChoiced = {
  name: '角色声音',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speed: FeatureNumeric = {
  name: '角色语速 %',
  description: '数值越低，语速越慢；数值越高，语速越快。',
  component: FeatureSliderInput,
};

export const blooper_pitch: FeatureNumeric = {
  name: '角色音调 %',
  description: '数值越低，声音越低沉；数值越高，声音越尖细。',
  component: FeatureSliderInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: '角色音调变化幅度 %',
  description:
    '数值越低，音调变化越小；数值越高，音调变化越大。',
  component: FeatureSliderInput,
};

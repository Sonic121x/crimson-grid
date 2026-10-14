// THIS IS A CRIMSON UI FILE
import { sortBy } from 'es-toolkit/compat';
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import type {
  Feature,
  FeatureChoicedServerData,
  FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

const FeaturePdaDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act } = useBackend();

  const serverData = props.serverData;
  if (!serverData) {
    return null;
  }

  const choices = sortBy<string>(serverData.choices);
  const currentIndex = choices.indexOf(props.value ?? '');
  const prevIndex = currentIndex > 0 ? currentIndex - 1 : choices.length - 1;
  const nextIndex =
    currentIndex < choices.length - 1 && currentIndex !== -1
      ? currentIndex + 1
      : 0;

  const handleBackward = () => {
    props.handleSetValue(choices[prevIndex]);
    act('play_ringtone_sound');
  };

  const handleForward = () => {
    props.handleSetValue(choices[nextIndex]);
    act('play_ringtone_sound');
  };

  return (
    <Stack>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_ringtone_sound');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} serverData={{ ...serverData, display_names: { 'Alert 1': '警报 1', 'Alert 2': '警报 2', 'Alert 3': '警报 3', 'Alert 4': '警报 4', 'Bell': '铃声', 'Beep': '哔声', 'BUZZ': '嗡鸣', 'BYOND Pager': 'BYOND 传呼机', 'BYOND Pager Down': 'BYOND 传呼机下行音', 'Bikehorn': '自行车喇叭', 'Chime': '钟鸣', 'Chord 1': '和弦 1', 'Chord 2': '和弦 2', 'Chord 3': '和弦 3', 'Codec': '编解码器', 'Ding': '叮声', 'Grandma': '奶奶', 'Horn': '喇叭', 'Maus': '鼠鼠', 'Meow 1': '猫叫 1', 'Meow 2': '猫叫 2', 'Meow 3': '猫叫 3', 'Meow 4': '猫叫 4', 'Meow (Electric)': '电子猫叫', 'Morse': '摩尔斯电码', 'Oh Hi Mark': '噢，嗨，马克', 'Mysterious Jingle': '神秘短曲', 'Normalize': '标准化', 'Not Alphys': '不是阿尔菲斯', 'Phone Chime': '电话提示音', 'Piano': '钢琴', 'Ping': '清脆提示音', 'Speaking': '说话声', 'Splat': '扑哧', 'Target': '目标', 'Terminal Notif 1': '终端通知 1', 'Weh': '呜欸' } }} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={handleBackward}
          icon="step-backward"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={handleForward}
          icon="step-forward"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const pda_ringtone_sound: Feature<string> = {
  name: '手机通知音效',
  // component: FeatureDropdownInput,
  component: FeaturePdaDropdownInput,
};

// THIS IS A CRIMSON UI FILE

import { useBackend } from 'tgui/backend';
import { Icon, Stack } from 'tgui-core/components';
import type { Data } from '.';
import { NavigableApps } from '.';

export const ScreenSoundSettingsNotificationSound = (props: {
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { setApp } = props;
  const { act, data } = useBackend<Data>();

  const { notification_sound, notification_sounds } = data;

  return (
    <Stack vertical fill backgroundColor="#ffffff" textColor="#000">
      <Stack.Item backgroundColor="#5f5f5f" textColor="#fff" p={1}>
        <Stack align="center">
          <Icon
            name="arrow-left"
            style={{ cursor: 'pointer' }}
            onClick={() => setApp(NavigableApps.SoundSettings)}
          />
          <Stack.Item grow ml={1}>
            通知音
          </Stack.Item>
        </Stack>
      </Stack.Item>

      <Stack.Item
        grow
        overflowY="auto"
        style={{
          scrollbarWidth: 'none',
          msOverflowStyle: 'none',
        }}
      >
        <Stack vertical mb="24px">
          {notification_sounds.map((sound) => {
            const selected = sound === notification_sound;

            return (
              <Stack.Item
                key={sound}
                p={1.5}
                pl={2}
                pr={2}
                onClick={() => act('set_notification_sound', { sound })}
                style={{
                  cursor: 'pointer',
                  borderBottom: '1px solid #e6e6e6',
                }}
              >
                <Stack align="center">
                  <Stack.Item width={2} mr={1.5}>
                    <Icon
                      name={selected ? 'bell' : 'music'}
                      color={selected ? '#1976d2' : '#777'}
                    />
                  </Stack.Item>

                  <Stack.Item grow>
                    <Stack vertical>
                      <Stack.Item
                        fontSize={1.05}
                        fontWeight={selected ? 'bold' : undefined}
                      >
                        {({ 'Alert 1': '警报 1', 'Alert 2': '警报 2', 'Alert 3': '警报 3', 'Alert 4': '警报 4', 'Bell': '铃声', 'Beep': '哔声', 'BUZZ': '嗡鸣', 'BYOND Pager': 'BYOND 传呼机', 'BYOND Pager Down': 'BYOND 传呼机下行音', 'Bikehorn': '自行车喇叭', 'Chime': '钟鸣', 'Chord 1': '和弦 1', 'Chord 2': '和弦 2', 'Chord 3': '和弦 3', 'Codec': '编解码器', 'Ding': '叮声', 'Grandma': '奶奶', 'Horn': '喇叭', 'Maus': '鼠鼠', 'Meow 1': '猫叫 1', 'Meow 2': '猫叫 2', 'Meow 3': '猫叫 3', 'Meow 4': '猫叫 4', 'Meow (Electric)': '电子猫叫', 'Morse': '摩尔斯电码', 'Oh Hi Mark': '噢，嗨，马克', 'Mysterious Jingle': '神秘短曲', 'Normalize': '标准化', 'Not Alphys': '不是阿尔菲斯', 'Phone Chime': '电话提示音', 'Piano': '钢琴', 'Ping': '清脆提示音', 'Speaking': '说话声', 'Splat': '扑哧', 'Target': '目标', 'Terminal Notif 1': '终端通知 1', 'Weh': '呜欸' } as Record<string, string>)[sound] || sound}
                      </Stack.Item>

                      {selected && (
                        <Stack.Item fontSize={0.85} mt={-0.4} color="#1976d2">
                          当前通知音
                        </Stack.Item>
                      )}
                    </Stack>
                  </Stack.Item>

                  <Stack.Item width={2} textAlign="right">
                    {selected && <Icon name="check" color="#1976d2" />}
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            );
          })}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

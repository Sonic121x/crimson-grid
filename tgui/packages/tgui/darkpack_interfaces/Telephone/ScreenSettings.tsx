// THIS IS A DARKPACK UI FILE
import { Icon, Stack } from 'tgui-core/components';
import { NavigableApps } from '.';

// fake phone info generated when the phone is spawned. random for now, maybe implemented later. maybe never.
const totalStorage = 128;
const storageUsed = Math.min(
  Math.floor(Math.random() * (totalStorage - 10)),
  totalStorage - 40,
); //im bad at math
const storageFree = totalStorage - storageUsed;

const batteryPercentage = Math.min(Math.floor(Math.random() * 100), 100);
const batteryDays = Math.floor(Math.random() * 3) + 1;
const batteryHours = Math.floor(Math.random() * 5) + 1;

type SettingsChoice = {
  name: string;
  description?: string;
  icon: string;
  functional: boolean;
  action: () => void;
};

export const ScreenSettings = (props: {
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { setApp } = props;

  // most of these are fake... for now
  const choices: SettingsChoice[] = [
    {
      name: '网络与互联网',
      description: '移动网络、Wi-Fi、热点',
      icon: 'wifi',
      functional: false,
      action: () => null,
    },
    {
      name: '已连接的设备',
      description: '蓝牙、配对',
      icon: 'computer',
      functional: false,
      action: () => null,
    },
    {
      name: '个性化',
      description: "更换手机壁纸",
      icon: 'image',
      functional: true,
      action: () => setApp(NavigableApps.Backgrounds),
    },
    {
      name: '显示',
      description: '深色主题、字体大小、亮度',
      icon: 'sun',
      functional: false,
      action: () => null,
    },
    {
      name: '主屏幕与锁屏',
      description: '自定义主屏幕和锁屏显示的内容',
      icon: 'phone',
      functional: false,
      action: () => null,
    },
    {
      name: '声音与振动',
      description: '音量、振动、勿扰模式、铃声', //CRIMSON GRID EDIT - ORIGINAL: description: 'Volume, vibration, Do Not Disturb',
      icon: 'volume-up',
      functional: true,
      action: () => setApp(NavigableApps.SoundSettings),
    },
    {
      name: '通知',
      description: '通知历史、会话',
      icon: 'bell',
      functional: false,
      action: () => null,
    },
    {
      name: '手势',
      description:
        '通过手势和按键快速打开常用功能',
      icon: 'hand-pointer',
      functional: false,
      action: () => null,
    },
    {
      name: '电池',
      description: `${batteryPercentage}% - ${batteryDays}天${batteryHours}小时`,
      icon: 'battery-full',
      functional: false,
      action: () => null,
    },
    {
      name: '存储空间',
      description: `已用 ${storageUsed}% - 剩余 ${storageFree} GB`,
      icon: 'hdd',
      functional: false,
      action: () => null,
    },
    {
      name: '位置',
      description: '已开启 - 3 个应用可访问位置',
      icon: 'map-marker-alt',
      functional: false,
      action: () => null,
    },
    {
      name: '无障碍',
      description: '显示、交互、音频',
      icon: 'person',
      functional: false,
      action: () => null,
    },
  ];
  return (
    <Stack vertical fill backgroundColor="#ffffff" textColor="#000">
      <Stack.Item backgroundColor="#5f5f5f" textColor="#fff" p={1}>
        <Stack align="center">
          <Icon
            name="arrow-left"
            onClick={() => setApp(null)}
            style={{ cursor: 'pointer' }}
          />
          <Stack.Item grow ml={1}>
            设置
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item
        grow
        overflowY="auto"
        style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
      >
        <Stack vertical mb={5}>
          {choices.map((choice, index) => (
            <Stack.Item
              key={index}
              p={1}
              onClick={choice.action}
              className={
                choice.functional ? 'Telephone__ContactsElement' : null
              } // only working apps are clickable
            >
              <Stack align="center" mb={1}>
                <Stack.Item ml={2} mr={2} width={2}>
                  <Icon name={choice.icon} size={1.5} />
                </Stack.Item>
                <Stack.Item grow ml={1.2} mr={2}>
                  <Stack vertical>
                    <Stack.Item fontSize={1.3}>{choice.name}</Stack.Item>
                    {choice.description ? (
                      <Stack.Item fontSize={1} mt={-1} opacity={0.7}>
                        {choice.description}
                      </Stack.Item>
                    ) : null}
                  </Stack>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

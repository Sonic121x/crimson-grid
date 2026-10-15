import { Suspense, useEffect, useState } from 'react';
import { exhaustiveCheck } from 'tgui-core/exhaustive';
import { fetchRetry } from 'tgui-core/http';

import { resolveAsset } from '../../assets';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { logger } from '../../logging';
import { LoadingScreen } from '../common/LoadingScreen';
import { CharacterPreferenceWindow } from './CharacterPreferences';
import { GamePreferenceWindow } from './GamePreferences';
import {
  GamePreferencesSelectedPage,
  type PreferencesMenuData,
  PrefsWindow,
  type ServerData,
} from './types';
import { RandomToggleState } from './useRandomToggleState';
import { ServerPrefs } from './useServerPrefs';

export function PreferencesMenu(props) {
  return (
    <Window width={920} height={770}>
      <Window.Content>
        <Suspense fallback={<LoadingScreen />}>
          <PrefsWindowInner />
        </Suspense>
      </Window.Content>
    </Window>
  );
}

/** We're abstracting this by one level to use Suspense */
function PrefsWindowInner(props) {
  const { data } = useBackend<PreferencesMenuData & { server_preferences?: ServerData }>(); // KUKU：读取后端随界面下发的共享偏好数据
  const { window } = data;

  const [serverData, setServerData] = useState<ServerData>();
  const randomization = useState(false);

  useEffect(() => { if (data.server_preferences) return; // KUKU：已有共享数据时跳过独立文件请求，保留旧后端兼容
    fetchRetry(resolveAsset('preferences.json'))
      .then((response) => response.json())
      .then((data) => {
        setServerData(data);
      })
      .catch((error) => {
        logger.log('Failed to fetch preferences.json', error);
      });
  }, [data.server_preferences]); // KUKU：共享数据更新后同步停止使用下载回退

  let content;
  let title;
  switch (window) {
    case PrefsWindow.Character:
      content = <CharacterPreferenceWindow />;
      title = 'Character Preferences';
      break;
    case PrefsWindow.Game:
      content = <GamePreferenceWindow />;
      title = 'Game Preferences';
      break;
    case PrefsWindow.Keybindings:
      content = (
        <GamePreferenceWindow
          startingPage={GamePreferencesSelectedPage.Keybindings}
        />
      );
      title = 'Keybindings';
      break;
    default:
      exhaustiveCheck(window);
  }

  return (
    <ServerPrefs.Provider value={data.server_preferences || serverData}> {/* KUKU：优先使用可靠的界面数据，恢复四个角色创建页面 */}
      <RandomToggleState.Provider value={randomization}>
        {content}
      </RandomToggleState.Provider>
    </ServerPrefs.Provider>
  );
}

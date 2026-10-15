import { createContext, useContext } from 'react';

import type { ServerData } from './types';

export const ServerPrefs = createContext<ServerData | undefined>({
  jobs: { display_names: {}, // KUKU：提供职业中文名称映射的空默认值，与共享数据类型一致
    departments: {},
    jobs: {},
    jobs_sorted: [],
  },
  names: {
    types: {},
  },
  quirks: {
    max_positive_quirks: -1,
    quirk_info: {},
    quirk_blacklist: [],
    points_enabled: false,
  },
  personality: {
    personalities: [],
    personality_incompatibilities: {},
  },
  random: {
    randomizable: [],
  },
  loadout: {
    loadout_tabs: [],
  },
  species: {},
   // DARKPACK EDIT START
  splats: {},
  disciplines: {},
  // DARKPACK EDIT END
});

export function useServerPrefs() {
  return useContext(ServerPrefs);
}

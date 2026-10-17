import {
  AnimatedNumber,
  Button,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  health: number;
  scanning: BooleanLike;
  target: BooleanLike;
};

export const HealthSensor = (props) => {
  const { act, data } = useBackend<Data>();
  const { health, scanning, target } = data;

  return (
    <Window width={360} height={115}>
      <Window.Content>
        <Section
          title="健康传感器"
          buttons={
            <>
              <Button
                icon={scanning ? 'power-off' : 'times'}
                content={scanning ? '已开启' : '已关闭'}
                selected={scanning}
                onClick={() => act('scanning')}
              />
              <Button
                icon={target ? 'skull' : 'heartbeat'}
                color="red"
                content={target ? '监测死亡' : '监测危重'}
                onClick={() => act('target')}
              />
            </>
          }
        >
          {health !== undefined && (
            <ProgressBar
              value={scanning ? health / 100 : 0}
              ranges={{
                good: [0.5, Infinity],
                average: [0.2, 0.5],
                bad: [-Infinity, 0.2],
              }}
            >
              {scanning ? <AnimatedNumber value={health} /> : '已关闭'}
            </ProgressBar>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};

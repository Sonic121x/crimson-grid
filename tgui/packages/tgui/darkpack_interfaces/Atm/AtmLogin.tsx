import { useState } from 'react';
import { Button, Input, LabeledList, Section } from 'tgui-core/components';
import { useBackend } from '../../backend';

import type { ATMData } from './types';

export const AtmLogin = (props) => {
  const { act, data } = useBackend<ATMData>();
  const [entered_code, setEnteredCode] = useState('');

  const handleLogin = () => {
    act('login', { bank_pin: entered_code });
  };
  return (
    <Section title="请输入银行卡密码">
      <LabeledList>
        <LabeledList.Item label="密码">
          <Input
            value={entered_code}
            placeholder="在此输入密码"
            onChange={setEnteredCode}
          />
        </LabeledList.Item>
        <LabeledList.Item>
          <Button onClick={handleLogin}>登录</Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

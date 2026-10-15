import { useState } from 'react';
import { Box, Button, Input, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';

import type { ATMData } from './types';

export const AtmMain = (props) => {
  const { act, data } = useBackend<ATMData>();
  const [withdrawAmount, setWithdrawAmount] = useState('');
  const [newPin, setNewPin] = useState('');

  const { account_holder, atm_balance, account_balance } = data;

  const handleLogout = () => {
    act('logout');
  };

  const handleWithdraw = () => {
    act('withdraw', { withdraw_amount: withdrawAmount });
  };

  const handleDeposit = () => {
    act('deposit');
  };

  const handleChangePin = () => {
    act('change_pin', { new_pin: newPin });
  };

  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="账户持有人">
          {account_holder}
        </LabeledList.Item>
        <LabeledList.Item label="账户余额">{account_balance}</LabeledList.Item>
        <LabeledList.Item label="取款机剩余现金">{atm_balance}</LabeledList.Item>
      </LabeledList>
      <Box mt={2}>
        <Box className="Atm__atm-column">
          <Box className="Atm__atm-row">
            <Button
              onClick={handleWithdraw}
              className="Atm__atm-button"
            >
              取款
            </Button>
            <Input
              value={withdrawAmount}
              onChange={setWithdrawAmount}
              placeholder="取款金额"
              style={{ flex: 3 }}
            />
          </Box>

          <Box className="Atm__atm-row">
            <Button onClick={handleChangePin} className="Atm__atm-button">
              修改密码
            </Button>
            <Input
              value={newPin}
              onChange={setNewPin}
              placeholder="新密码"
              style={{ flex: 3 }}
            />
          </Box>

          <Box className="Atm__atm-row">
            <Button onClick={handleDeposit} className="Atm__atm-button">
              存款
            </Button>
          </Box>

          <Box className="Atm__atm-row">
            <Button onClick={handleLogout} className="Atm__atm-button">
              退出登录
            </Button>
          </Box>
        </Box>
      </Box>
    </Section>
  );
};

// THIS IS A DARKPACK UI FILE

import { Box, Button, Stack } from 'tgui-core/components';

const DEFAULT_BODY = "修改重要角色信息（氏族、年龄等）会清空所有现有律能。此操作无法撤销。确定要继续吗？";

type Props = {
  title?: string;
  body?: string;
  onConfirm: () => void;
  onCancel: () => void;
};

export function ConfirmModal(props: Props) {
  const { title = '修改角色信息？', body = DEFAULT_BODY, onConfirm, onCancel } = props;

  return (
    <Box
      style={{
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        background: 'rgba(0,0,0,0.75)',
        zIndex: 9999,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <Box
        style={{
          background: '#1b1b1b',
          border: '1px solid #555',
          padding: '20px',
          maxWidth: '380px',
          width: '90%',
        }}
      >
        <Box bold textAlign="center" fontSize={1.1} mb={1} mt={-1}>
          {title}
        </Box>
        <Box color="label" mb={2}>
          {body}
        </Box>
        <Stack textAlign="center" justify="center">
          <Stack.Item>
            <Button textAlign="center" onClick={onCancel}>
              取消
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button textAlign="center" color="bad" onClick={onConfirm}>
              继续
            </Button>
          </Stack.Item>
        </Stack>
      </Box>
    </Box>
  );
}

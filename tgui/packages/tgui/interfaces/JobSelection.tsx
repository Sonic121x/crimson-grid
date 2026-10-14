import { toMerged } from 'es-toolkit';
import { Color } from 'tgui-core/color';
import {
  Box,
  Button,
  Icon,
  NoticeBox,
  Section,
  Stack,
  StyleableSection,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  LobbyNotices,
  type LobbyNoticesType,
} from './common/crimson/LobbyNotices';

type Job = {
  unavailable_reason: string | null;
  command: BooleanLike;
  open_slots: number;
  used_slots: number;
  prioritized: BooleanLike;
  description: string; display_name: string;
  jobIcon: string;
};

type Department = {
  color: string;
  jobs: Record<string, Job>;
  open_slots: number;
};

type Data = {
  departments_static: Record<string, Department>;
  departments: Record<string, Department>;
  alert_state: string;
  shuttle_status: string;
  disable_jobs_for_non_observers: BooleanLike;
  priority: BooleanLike;
  round_duration: string;
  selected_character?: string; // CRIMSON EDIT ADDITION - CHANGE_CHARACTER_SLOT
  notices: LobbyNoticesType; // CRIMSON EDIT ADDITION - lobby_notices
};

type JobEntryProps = {
  jobName: string;
  job: Job;
  department: Department;
  jobIcon: string;
  onClick: () => void;
};

function JobEntry(props: JobEntryProps) {
  const { jobName, job, department, jobIcon, onClick } = props;

  return (
    <Button
      fluid
      style={{
        // Try not to think too hard about this one.
        backgroundColor: job.unavailable_reason
          ? '#949494' // Grey background
          : job.prioritized
            ? '#16fc0f' // Bright green background
            : Color.fromHex(department.color).darken(10).toString(),
        color: job.unavailable_reason
          ? '#616161' // Dark grey font
          : Color.fromHex(department.color).darken(90).toString(),
        fontSize: '1.1rem',
        cursor: job.unavailable_reason ? 'initial' : 'pointer',
      }}
      tooltip={
        job.unavailable_reason ||
        (job.prioritized ? (
          <>
            <p style={{ marginTop: '0px' }}>
              <b>人事主管希望更多人担任此职业！</b>
            </p>
            {job.description}
          </>
        ) : (
          job.description
        ))
      }
      tooltipPosition="top"
      onClick={() => {
        !job.unavailable_reason && onClick();
      }}
    >
      <Stack fill>
        {jobIcon && (
          <Stack.Item>
            <Icon name={jobIcon} />
          </Stack.Item>
        )}
        <Stack.Item grow>{job.command ? <b>{jobName}</b> : jobName}</Stack.Item>
        <Stack.Item>
          <span
            style={{
              whiteSpace: 'nowrap',
            }}
          >
            {job.used_slots} / {job.open_slots}
          </span>
        </Stack.Item>
      </Stack>
    </Button>
  );
}

type DepartmentEntryProps = {
  name: string;
  department: Department;
};

function DepartmentEntry(props: DepartmentEntryProps) {
  const { name, department } = props;
  const { act } = useBackend<Data>();

  return (
    <Box minWidth="30%">
      <StyleableSection
        title={
          <>
            {({ Prince: '亲王', Camarilla: '密党', Clinic: '诊所', Church: '教会', 'Strip Club': '脱衣舞俱乐部', Anarch: '自由派', Giovanni: '乔凡尼', Chantry: '秘所', Manor: '庄园', Sabbat: '魔宴同盟', 'Garou Nation': '狼人国度', Pentex: '潘特克斯', Warehouse: '仓库', Police: '警局', 'Society of Leopold': '圣利奥波德协会', 'City Services': '城市服务', Citizen: '市民', 'Chinese Triad': '三合会' } as Record<string, string>)[name] ?? name}
            <span
              style={{
                fontSize: '1rem',
                whiteSpace: 'nowrap',
                position: 'absolute',
                right: '1em',
                color: Color.fromHex(department.color).darken(60).toString(),
              }}
            >
              {department.open_slots +
                (department.open_slots === 1 ? ' 个' : ' 个') +
                '空缺'}
            </span>
          </>
        }
        style={{
          backgroundColor: department.color,
          marginBottom: '1em',
          breakInside: 'avoid-column',
        }}
        titleStyle={{
          'border-bottom-color': Color.fromHex(department.color)
            .darken(50)
            .toString(),
        }}
        textStyle={{
          color: Color.fromHex(department.color).darken(80).toString(),
        }}
      >
        <Stack vertical>
          {Object.entries(department.jobs).map(([name, job]) => (
            <Stack.Item key={name}>
              <JobEntry
                key={name}
                jobName={job.display_name ?? name}
                job={job}
                jobIcon={job.jobIcon}
                department={department}
                onClick={() => {
                  act('select_job', { job: name });
                }}
              />
            </Stack.Item>
          ))}
        </Stack>
      </StyleableSection>
    </Box>
  );
}

export function JobSelection(props) {
  const { act, data } = useBackend<Data>();
  if (!data?.departments_static) {
    return null; // Stop TGUI whitescreens with TGUI-dev!
  }

  const departments: Record<string, Department> = toMerged(
    data.departments,
    data.departments_static,
  );

  const { shuttle_status, round_duration } = data;

  return (
    <Window width={1012} height={shuttle_status ? 690 : 666 /* Hahahahahaha */}>
      <Window.Content>
        <Section
          buttons={
            // CRIMSON EDIT ADDITION - CHANGE_CHARACTER_SLOT - added "change_slot". ORIGINAL: select_job button without the parent fragment
            <>
              <Button
                onClick={() => act('change_slot')}
                tooltip="无需打开角色设置菜单，即可快速切换当前角色。"
              >
                切换角色
              </Button>
              <Button
                onClick={() => act('select_job', { job: 'Random' })}
                tooltip="随机选择一个职业。如果不满意，可以重新随机或取消。"
              >
                随机职业！
              </Button>
            </>
          }
          fill
          scrollable
          title={
            <>
              {/* CRIMSON EDIT ADDITION START - lobby_notices */}
              <LobbyNotices notices={data.notices} />
              {/* CRIMSON EDIT ADDITION END */}
              {shuttle_status && <NoticeBox info>{shuttle_status}</NoticeBox>}
              <Box as="span" color="label">
                {!!data.selected_character && (
                  <span style={{ color: 'grey' }}>
                    将以“{data.selected_character}”加入 —{' '}
                  </span>
                )}
                今夜已过去 {round_duration}。
                {/* DARKPACK EDIT CHANGE - ORIGINAL: It is currently {round_duration} into the shift. */}
                {/* CRIMSON EDIT CHANGE - CHANGE_CHARACTER_SLOT - Added "Joining as", I am not going to form an ORIGINAL, please git blame */}
              </Box>
            </>
          }
        >
          <Box style={{ columns: '20em' }}>
            {Object.entries(departments).map(([name, department]) => (
              <DepartmentEntry key={name} name={name} department={department} />
            ))}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
}

import {
  Box,
  Button,
  Chart,
  Flex,
  Icon,
  LabeledList,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

export const RecipeLookup = (props) => {
  const { recipe, bookmarkedReactions } = props;
  const { act, data } = useBackend();
  if (!recipe) {
    return <Box>尚未选择反应！</Box>;
  }

  const getReaction = (id) => {
    return data.master_reaction_list.filter((reaction) => reaction.id === id);
  };

  const addBookmark = (bookmark) => {
    bookmarkedReactions.add(bookmark);
  };

  return (
    <LabeledList>
      <LabeledList.Item bold label="配方">
        <Icon name="circle" mr={1} color={recipe.reagentCol} />
        {recipe.name}
        <Button
          icon="arrow-left"
          ml={3}
          disabled={recipe.subReactIndex === 1}
          onClick={() =>
            act('reduce_index', {
              id: recipe.name,
            })
          }
        />
        <Button
          icon="arrow-right"
          disabled={recipe.subReactIndex === recipe.subReactLen}
          onClick={() =>
            act('increment_index', {
              id: recipe.name,
            })
          }
        />
        {bookmarkedReactions && (
          <Button
            icon="book"
            color="green"
            disabled={bookmarkedReactions.has(getReaction(recipe.id)[0])}
            onClick={() => {
              addBookmark(getReaction(recipe.id)[0]);
              act('update_ui');
            }}
          />
        )}
      </LabeledList.Item>
      {recipe.products && (
        <LabeledList.Item bold label="产物">
          {recipe.products.map((product) => (
            <Button
              key={product.name}
              icon="vial"
              disabled={product.hasProduct}
              content={`${product.ratio}单位 ${product.name}`}
              onClick={() =>
                act('reagent_click', {
                  id: product.id,
                })
              }
            />
          ))}
        </LabeledList.Item>
      )}
      <LabeledList.Item bold label="反应物">
        {recipe.reactants.map((reactant) => (
          <Box key={reactant.id}>
            <Button
              icon="vial"
              color={reactant.color}
              content={`${reactant.ratio}单位 ${reactant.name}`}
              onClick={() =>
                act('reagent_click', {
                  id: reactant.id,
                })
              }
            />
            {!!reactant.tooltipBool && (
              <Button
                icon="flask"
                color="purple"
                tooltip={reactant.tooltip}
                tooltipPosition="right"
                onClick={() =>
                  act('find_reagent_reaction', {
                    id: reactant.id,
                  })
                }
              />
            )}
          </Box>
        ))}
      </LabeledList.Item>
      {recipe.catalysts && (
        <LabeledList.Item bold label="催化剂">
          {recipe.catalysts.map((catalyst) => (
            <Box key={catalyst.id}>
              {(catalyst.tooltipBool && (
                <Button
                  icon="vial"
                  color={catalyst.color}
                  content={`${catalyst.ratio}单位 ${catalyst.name}`}
                  tooltip={catalyst.tooltip}
                  tooltipPosition={'right'}
                  onClick={() =>
                    act('reagent_click', {
                      id: catalyst.id,
                    })
                  }
                />
              )) || (
                <Button
                  icon="vial"
                  color={catalyst.color}
                  content={`${catalyst.ratio}单位 ${catalyst.name}`}
                  onClick={() =>
                    act('reagent_click', {
                      id: catalyst.id,
                    })
                  }
                />
              )}
            </Box>
          ))}
        </LabeledList.Item>
      )}
      {recipe.reqContainer && (
        <LabeledList.Item bold label="容器">
          <Button
            color="transparent"
            textColor="white"
            tooltipPosition="right"
            content={recipe.reqContainer}
            tooltip="进行该反应所需的容器。"
          />
        </LabeledList.Item>
      )}
      <LabeledList.Item bold label="纯度">
        <LabeledList>
          <LabeledList.Item label="最佳pH范围">
            <Box position="relative">
              <Tooltip content="反应维持在此范围内时，产物纯度为100%。">
                {`${recipe.lowerpH}-${recipe.upperpH}`}
              </Tooltip>
            </Box>
          </LabeledList.Item>
          {!!recipe.inversePurity && (
            <LabeledList.Item label="逆转纯度">
              <Box position="relative">
                <Tooltip content="纯度低于此值时，摄入的产物会全部转化为对应的逆转试剂。">
                  {`<${recipe.inversePurity * 100}%`}
                </Tooltip>
              </Box>
            </LabeledList.Item>
          )}
          {!!recipe.minPurity && (
            <LabeledList.Item label="最低纯度">
              <Box position="relative">
                <Tooltip content="反应期间纯度低于此值会产生负面效果；若完成时仍低于此值，产物会转化为对应的失败试剂。">
                  {`<${recipe.minPurity * 100}%`}
                </Tooltip>
              </Box>
            </LabeledList.Item>
          )}
        </LabeledList>
      </LabeledList.Item>
      <LabeledList.Item bold label="速率曲线" width="10px">
        <Box
          height="50px"
          position="relative"
          style={{
            backgroundColor: 'black',
          }}
        >
          <Chart.Line
            fillPositionedParent
            data={recipe.thermodynamics}
            strokeWidth={0}
            fillColor={'#3cf072'}
          />
          {recipe.explosive && (
            <Chart.Line
              position="absolute"
              justify="right"
              top={0.01}
              bottom={0}
              right={recipe.isColdRecipe ? null : 0}
              width="28px"
              data={recipe.explosive}
              strokeWidth={0}
              fillColor={'#d92727'}
            />
          )}
        </Box>
        <Flex justify="space-between">
          <Tooltip
            content={
              recipe.isColdRecipe
                ? '低温失控阈值，温度过低会对反应产生负面效果。'
                : '反应开始所需的最低温度，超过此温度后继续加热会提高反应速率。'
            }
          >
            <Flex.Item
              position="relative"
              textColor={recipe.isColdRecipe && 'red'}
            >
              {recipe.isColdRecipe
                ? `${recipe.explodeTemp}K`
                : `${recipe.tempMin}K`}
            </Flex.Item>
          </Tooltip>

          {recipe.explosive && (
            <Tooltip
              content={
                recipe.isColdRecipe
                  ? '反应开始所需的最低温度，超过此温度后继续加热会提高反应速率。'
                  : '过热失控阈值，温度过高会对反应产生负面效果。'
              }
            >
              <Flex.Item
                position="relative"
                textColor={!recipe.isColdRecipe && 'red'}
              >
                {recipe.isColdRecipe
                  ? `${recipe.tempMin}K`
                  : `${recipe.explodeTemp}K`}
              </Flex.Item>
            </Tooltip>
          )}
        </Flex>
      </LabeledList.Item>
      <LabeledList.Item bold label="反应动力学">
        <LabeledList>
          <LabeledList.Item label="最佳速率">
            <Tooltip content="反应可达到的最高速率，单位为单位/秒，对应上方速率曲线的平顶部分。">
              <Box position="relative">{`${recipe.thermoUpper}单位/秒`}</Box>
            </Tooltip>
          </LabeledList.Item>
        </LabeledList>
        <Tooltip content="反应的热量变化：放热反应产生热量，吸热反应消耗热量。">
          <Box position="relative">{recipe.thermics}</Box>
        </Tooltip>
      </LabeledList.Item>
    </LabeledList>
  );
};

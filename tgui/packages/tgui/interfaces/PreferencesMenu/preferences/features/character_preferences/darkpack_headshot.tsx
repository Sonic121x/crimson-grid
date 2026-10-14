// THIS IS A DARKPACK UI FILE
import { type Feature, FeatureShortTextInput } from '../base';

const description =
  '请提供以 https:// 开头、以 .png、.jpeg 或 .jpg 结尾的图片链接，\
  图片需托管在 Gyazo、Imgbox 或 Catbox.moe。图片会显示在 \
  详细查看窗口中的角色预览下方。\
  大于 250x250 像素的图片会缩放至 250x250。\
  建议尽量使用 250x250 像素的图片。';

export const headshot: Feature<string> = {
  name: '角色头像',
  description: description,
  component: FeatureShortTextInput,
};

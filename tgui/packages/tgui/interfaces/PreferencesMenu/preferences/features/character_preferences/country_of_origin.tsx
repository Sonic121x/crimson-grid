// THIS IS A DARKPACK UI FILE
import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const country_of_origin: FeatureChoiced = {
    name: '原籍国家',
    component: FeatureDropdownInput,
};

export const state_of_origin: FeatureChoiced = {
    name: '原籍州',
    component: FeatureDropdownInput,
};

export const province_of_origin: FeatureChoiced = {
    name: '原籍省',
    component: FeatureDropdownInput,
};

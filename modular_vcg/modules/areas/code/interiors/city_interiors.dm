// Shops:
/area/vtm/interior/shop/arts
	name = "Art Supplies Store"
	icon_state = "shop_arts"
/area/vtm/interior/shop/arts/Initialize(mapload) { GLOB.localized_darkpack_area_names[initial(name)] = "美术用品店"; return ..(); }
/area/vtm/interior/shop/black_market
	name = "Black Market"
	icon_state = "shop_black_market"
/area/vtm/interior/shop/black_market/Initialize(mapload) { GLOB.localized_darkpack_area_names[initial(name)] = "黑市"; return ..(); }
/area/vtm/interior/shop/antiques
	name = "Antique Store"
	icon_state = "shop_antique"
/area/vtm/interior/shop/antiques/Initialize(mapload) { GLOB.localized_darkpack_area_names[initial(name)] = "古董店"; return ..(); }

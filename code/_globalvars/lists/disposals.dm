// Reference list for disposal sort junctions. Set the sortType variable on disposal sort junctions to
// the index of the sort department that you want. For example, sortType set to 2 will reroute all packages
// tagged for the Cargo Bay.

/* List of sortType codes for mapping reference
0 Waste
1 Disposals - All unwrapped items and untagged parcels get picked up by a junction with this sortType. Usually leads to the recycler.
2 Cargo Bay
3 QM Office
4 Engineering
5 CE Office
6 Atmospherics
7 Security
8 HoS Office
9 Medbay
10 CMO Office
11 Chemistry
12 Research
13 RD Office
14 Robotics
15 HoP Office
16 Library
17 Chapel
18 Theatre
19 Bar
20 Kitchen
21 Hydroponics
22 Janitor
23 Genetics
24 Experimentor Lab
25 Ordnance
26 Dormitories
27 Virology
28 Xenobiology
29 Law Office
30 Detective's Office
*/

//The whole system for the sorttype var is determined based on the order of this list,
//disposals must always be 1, since anything that's untagged will automatically go to disposals, or sorttype = 1 --Superxpdude

//If you don't want to fuck up disposals, add to this list, and don't change the order.
//If you insist on changing the order, you'll have to change every sort junction to reflect the new order. --Pete

GLOBAL_LIST_INIT(TAGGERLOCATIONS, list("废弃物处理区",
	"货舱", "军需官办公室", "工程部", "总工程师办公室",
	"大气部", "安保部", "安保主管办公室", "医疗部",
	"首席医疗官办公室", "化学室", "科研部", "科研主管办公室",
	"机器人实验室", "人事主管办公室", "图书馆", "礼拜堂", "剧院",
	"酒吧", "厨房", "水培室", "清洁间","遗传学实验室",
	"实验机实验室", "军械部", "宿舍", "病毒学实验室",
	"异种生物实验室", "律师办公室","侦探办公室"))

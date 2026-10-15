/datum/supply_pack/weapons
	group = "武器"
/datum/supply_pack/weapons/New() { . = ..(); name = list("Weapon (stake)" = "武器（木桩）", "Weapon (knife)" = "武器（小刀）", "Weapon (brass knuckles)" = "武器（黄铜指虎）", "Weapon (spiked knuckles)" = "武器（尖刺指虎）", "Weapon (tire iron)" = "武器（轮胎撬棒）", "Weapon (shovel)" = "武器（铲子）", "Weapon (baseball bat)" = "武器（棒球棍）", "Weapon (fire axe)" = "武器（消防斧）", "Weapon (rapier)" = "武器（刺剑）", "Weapon (machete)" = "武器（砍刀）", "Weapon (katana)" = "武器（武士刀）", "Weapon (sabre)" = "武器（军刀）", "Weapon (longsword)" = "武器（长剑）", "Weapon (chainsaw)" = "武器（链锯）", "Weapon (revolver)" = "武器（左轮手枪）", "Weapon (lever action rifle)" = "武器（杠杆式步枪）", "Weapon (desert eagle)" = "武器（沙漠之鹰）", "Weapon (Mclusky Special)" = "武器（麦克拉斯基特制型）", "Weapon (Brokk19)" = "武器（布洛克19）", "Weapon (Dual Elite 92G)" = "武器（双持精英92G）", "Weapon (mini uzi)" = "武器（迷你乌兹）", "Weapon (Braddock .45)" = "武器（布拉多克.45）", "Weapon (pump shotgun)" = "武器（泵动霰弹枪）", "Weapon (double barrel shotgun)" = "武器（双管霰弹枪）", "Weapon (Remington 11-87)" = "武器（雷明顿11-87）", "Weapon (Thompson)" = "武器（汤普森）", "Weapon (MP5)" = "武器（MP5）", "Weapon (AK-74)" = "武器（AK-74）", "Weapon (CAR-15)" = "武器（CAR-15）", "Weapon (AUG)" = "武器（AUG）", "Weapon (Battle Rifle)" = "武器（战斗步枪）", "Weapon (Military Battle Rifle)" = "武器（军用战斗步枪）", "Weapon (antique musket)" = "武器（古董火枪）", "Weapon (crossbow)" = "武器（弩）", "Weapon (.50 cal sniper rifle)" = "武器（.50口径狙击步枪）", "Ammo (9mm)" = "弹药（9mm）", "Ammo (12g, slug)" = "弹药（12号独头弹）", "Ammo (12g, buckshot)" = "弹药（12号鹿弹）", "Ammo (12g, silver)" = "弹药（12号银弹）", "Ammo (12g, Dragon's Breath)" = "弹药（12号龙息弹）", "Ammo (5.45)" = "弹药（5.45）", "Ammo (.44)" = "弹药（.44）", "Ammo (.45 ACP ammo)" = "弹药（.45 ACP）", "Ammo (5.56)" = "弹药（5.56）", "Ammo (9mm, silver)" = "弹药（9mm银弹）", "Ammo (.44, silver)" = "弹药（.44银弹）", "Ammo (.45, silver)" = "弹药（.45银弹）", "Ammo (5.56, silver)" = "弹药（5.56银弹）", "Ammo (.50 BMG)" = "弹药（.50 BMG）", "Ammo (.50 AE)" = "弹药（.50 AE）", "Ammo (7.62)" = "弹药（7.62）", "Ammo (5.56 incendiary)" = "弹药（5.56燃烧弹）", "Ammo (bolts)" = "弹药（弩箭）", "Cartriages (.75 Ball)" = "弹药（.75圆弹）", "Cartriages (.75 Ball Silver)" = "弹药（.75银制圆弹）", "Ammo (3x Colt M1911 magazine)" = "弹药（3个柯尔特M1911弹匣）", "Ammo (3x Brokk19 magazine)" = "弹药（3个布洛克19弹匣）", "Ammo (4x Elite 92G magazines)" = "弹药（4个精英92G弹匣）", "Ammo (3x AK74 magazines)" = "弹药（3个AK74弹匣）", "Ammo (3x desert eagle magazines)" = "弹药（3个沙漠之鹰弹匣）", "Ammo (3x Desert Eagle 50AE magazines)" = "弹药（3个沙漠之鹰50AE弹匣）", "Ammo (3x HK MP5 magazines)" = "弹药（3个HK MP5弹匣）", "Ammo (3x mini uzi magazines)" = "弹药（3个迷你乌兹弹匣）", "Ammo (3x AR-15 rifle magazine)" = "弹药（3个AR-15步枪弹匣）", "Ammo (3x AUG carbine magazine)" = "弹药（3个AUG卡宾枪弹匣）", "Ammo (2x battle rifle magazine)" = "弹药（2个战斗步枪弹匣）", "Ammo (3x Thompson magazine)" = "弹药（3个汤普森弹匣）", "Ammo (3x Braddock magazines)" = "弹药（3个布拉多克弹匣）", "Armor (3 civilian)" = "护甲（3套民用）", "Armor (police)" = "护甲（警用）", "Armor (army)" = "护甲（军用）", "Armor (EOD)" = "护甲（排爆）")[name] || name; crate_name = list("weapon crate" = "武器箱", "ammo crate" = "弹药箱", "armor crate" = "护甲箱", "crate" = "货箱")[crate_name] || crate_name; }
/datum/supply_pack/weapons/weaponstake
	name = "Weapon (stake)"
	desc = "包含3根可使用的木桩。"
	cost = 100
	contains = list(
		/obj/item/vampire_stake,
		/obj/item/vampire_stake,
		/obj/item/vampire_stake
	)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponknife
	name = "Weapon (knife)"
	desc = "包含一把小刀。"
	cost = 100
	contains = list(/obj/item/knife/vamp)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/brassknuckles
	name = "Weapon (brass knuckles)"
	desc = "包含一副黄铜指虎。"
	cost = 100
	contains = list(/obj/item/clothing/gloves/vampire/brassknuckles)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/spikedknuckles
	name = "Weapon (spiked knuckles)"
	desc = "包含一副尖刺指虎。"
	cost = 500
	contains = list(/obj/item/clothing/gloves/vampire/brassknuckles/spiked)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weapontire
	name = "Weapon (tire iron)"
	desc = "包含一根轮胎撬棒。"
	cost = 100
	contains = list(/obj/item/melee/vamp/tire)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponshovel
	name = "Weapon (shovel)"
	desc = "包含一把铲子。"
	cost = 300
	contains = list(/obj/item/shovel/vamp)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponbaseball
	name = "Weapon (baseball bat)"
	desc = "包含一根棒球棍。"
	cost = 400
	contains = list(/obj/item/melee/baseball_bat/vamp)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponfireaxe
	name = "Weapon (fire axe)"
	desc = "包含一把消防斧。"
	cost = 600
	contains = list(/obj/item/fireaxe/vamp)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponrapier
	name = "Weapon (rapier)"
	desc = "包含一把刺剑及配套剑鞘。"
	cost = 800
	contains = list(/obj/item/storage/belt/sheath/vamp/rapier)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponmachete
	name = "Weapon (machete)"
	desc = "包含一把砍刀。"
	cost = 500
	contains = list(/obj/item/claymore/machete)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponkatana
	name = "Weapon (katana)"
	desc = "包含一把武士刀。"
	cost = 1000
	contains = list(/obj/item/katana/vamp)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponsabre
	name = "Weapon (sabre)"
	desc = "包含一把军刀及配套刀鞘。"
	cost = 1200
	contains = list(/obj/item/storage/belt/sheath/vamp/sabre)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponlongsword
	name = "Weapon (longsword)"
	desc = "包含一把长剑及配套剑鞘。"
	cost = 1500
	contains = list(/obj/item/storage/belt/sheath/vamp/sword)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponchainsaw
	name = "Weapon (chainsaw)"
	desc = "包含一把链锯。"
	cost = 2000
	contains = list(/obj/item/chainsaw/vamp)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponrevolver
	name = "Weapon (revolver)"
	desc = "包含一把左轮手枪。"
	cost = 200
	contains = list(/obj/item/gun/ballistic/revolver/darkpack/magnum)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponlever
	name = "Weapon (lever action rifle)"
	desc = "包含一把杠杆式步枪。"
	cost = 1500
	contains = list(/obj/item/gun/ballistic/rifle/darkpack/lever)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weapondeagle
	name = "Weapon (desert eagle)"
	desc = "包含一把沙漠之鹰。"
	cost = 400
	contains = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle, /obj/item/ammo_box/magazine/m44)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weapondeagle50
	name = "Weapon (Mclusky Special)"
	desc = "包含一把.50口径沙漠之鹰。"
	cost = 3000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle/c50, /obj/item/ammo_box/magazine/m50)

/datum/supply_pack/weapons/glock
	name = "Weapon (Brokk19)"
	desc = "包含一把布洛克19手枪。"
	cost = 600
	contains = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/glock19)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/beretta
	name = "Weapon (Dual Elite 92G)"
	desc = "包含一对精英92G手枪。"
	cost = 900
	contains = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/beretta, /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponuzi
	name = "Weapon (mini uzi)"
	desc = "包含一把迷你乌兹。"
	cost = 1000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/uzi, /obj/item/ammo_box/magazine/darkpack9mm)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponmac10
	name = "Weapon (Braddock .45)"
	desc = "包含一把布拉多克.45冲锋枪。"
	cost = 800
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/mac10, /obj/item/ammo_box/magazine/darkpack45smg)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponshotgun
	name = "Weapon (pump shotgun)"
	desc = "包含一把泵动霰弹枪。"
	cost = 800
	contains = list(/obj/item/gun/ballistic/shotgun/vampire)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weapondbshotgun
	name = "Weapon (double barrel shotgun)"
	desc = "包含一把双管霰弹枪。"
	cost = 1000
	contains = list(/obj/item/gun/ballistic/shotgun/vampire/doublebarrel)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/remington
	name = "Weapon (Remington 11-87)"
	desc = "包含一把雷明顿11-87霰弹枪。"
	cost = 2100
	contains = list(/obj/item/gun/ballistic/shotgun/vamp_remington)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/thompson
	name = "Weapon (Thompson)"
	desc = "包含一把汤普森冲锋枪。"
	cost = 2000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/thompson)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/mp5
	name = "Weapon (MP5)"
	desc = "包含一把MP5。"
	cost = 2000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/mp5)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/ak74
	name = "Weapon (AK-74)"
	desc = "包含一把AK-74。"
	cost = 2250
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/ak74)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponrifle
	name = "Weapon (CAR-15)"
	desc = "包含一把CAR-15突击步枪。"
	cost = 2500
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/ar15, /obj/item/ammo_box/magazine/darkpack556)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponcarbine
	name = "Weapon (AUG)"
	desc = "包含一把AUG突击卡宾枪。"
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/aug, /obj/item/ammo_box/magazine/darkpackaug)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponfal
	name = "Weapon (Battle Rifle)"
	desc = "包含一把7.62口径战斗步枪。"
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/fal, /obj/item/ammo_box/magazine/darkpack762x51fal)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponfalauto
	name = "Weapon (Military Battle Rifle)"
	desc = "包含一把军用7.62口径战斗步枪。"
	cost = 4500
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/fal/automatic, /obj/item/ammo_box/magazine/darkpack762x51fal)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/musket
	name = "Weapon (antique musket)"
	desc = "包含一把.75口径古董火枪。"
	cost = 3000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/musket, /obj/item/ammo_box/darkpack/c75)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponcrossbow
	name = "Weapon (crossbow)"
	desc = "包含一把弩。"
	cost = 1000
	contains = list(/obj/item/gun/ballistic/shotgun/toy/crossbow/vampire)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponsniper
	name = "Weapon (.50 cal sniper rifle)"
	desc = "包含一把.50口径狙击步枪。"
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/darkpack/sniper)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/ammo9
	name = "Ammo (9mm)"
	desc = "包含一盒9mm弹药。"
	cost = 200
	contains = list(/obj/item/ammo_box/darkpack/c9mm, /obj/item/ammo_box/darkpack/c9mm)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo12g
	name = "Ammo (12g, slug)"
	desc = "包含一盒12号霰弹枪独头弹。"
	cost = 400
	contains = list(/obj/item/ammo_box/darkpack/c12g, /obj/item/ammo_box/darkpack/c12g)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo12gbuck
	name = "Ammo (12g, buckshot)"
	desc = "包含一盒12号00鹿弹。"
	cost = 400
	contains = list(/obj/item/ammo_box/darkpack/c12g/buck, /obj/item/ammo_box/darkpack/c12g/buck)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo12gsilver
	name = "Ammo (12g, silver)"
	desc = "包含一盒12号霰弹枪银制独头弹。"
	cost = 4000
	contains = list(/obj/item/ammo_box/darkpack/c12g/silver)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo12g/incendiary
	name = "Ammo (12g, Dragon's Breath)"
	desc = "包含一盒12号燃烧弹。"
	cost = 4000
	contains = list(/obj/item/ammo_box/darkpack/c12g/buck/incendiary)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo545
	name = "Ammo (5.45)"
	desc = "包含一盒5.45口径弹药。"
	cost = 500
	contains = list(/obj/item/ammo_box/darkpack/c545, /obj/item/ammo_box/darkpack/c545)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo44
	name = "Ammo (.44)"
	desc = "包含一盒.44口径弹药。"
	cost = 600
	contains = list(/obj/item/ammo_box/darkpack/c44, /obj/item/ammo_box/darkpack/c44)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo45
	name = "Ammo (.45 ACP ammo)"
	desc = "包含一盒.45 ACP弹药。"
	cost = 700
	contains = list(/obj/item/ammo_box/darkpack/c45acp, /obj/item/ammo_box/darkpack/c45acp)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo556
	name = "Ammo (5.56)"
	desc = "包含一盒5.56口径弹药。"
	cost = 1500
	contains = list(/obj/item/ammo_box/darkpack/c556, /obj/item/ammo_box/darkpack/c556)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo9/silver
	name = "Ammo (9mm, silver)"
	desc = "包含一盒9mm银弹。"
	cost = 2000
	contains = list(/obj/item/ammo_box/darkpack/c9mm/silver)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo44/silver
	name = "Ammo (.44, silver)"
	desc = "包含一盒.44口径银弹。"
	cost = 2000
	contains = list(/obj/item/ammo_box/darkpack/c44/silver)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo45/silver
	name = "Ammo (.45, silver)"
	desc = "包含一盒.45口径银弹。"
	cost = 2000
	contains = list(/obj/item/ammo_box/darkpack/c45acp/silver)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo556/silver
	name = "Ammo (5.56, silver)"
	desc = "包含一盒5.56口径银弹。"
	cost = 3000
	contains = list(/obj/item/ammo_box/darkpack/c556/silver)

/datum/supply_pack/weapons/ammo50
	name = "Ammo (.50 BMG)"
	desc = "包含一盒.50 BMG弹药。"
	cost = 2500
	contains = list(/obj/item/ammo_box/darkpack/c50)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo50ae
	name = "Ammo (.50 AE)"
	desc = "包含一盒.50 AE弹药。"
	cost = 1000
	contains = list(/obj/item/ammo_box/darkpack/c50ae, /obj/item/ammo_box/darkpack/c50ae)

/datum/supply_pack/weapons/ammo762
	name = "Ammo (7.62)"
	desc = "包含一盒7.62口径弹药。"
	cost = 1500
	contains = list(/obj/item/ammo_box/darkpack/c762x51mm, /obj/item/ammo_box/darkpack/c762x51mm)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo556/incendiart
	name = "Ammo (5.56 incendiary)"
	desc = "包含一盒5.56口径燃烧弹。"
	cost = 4500
	contains = list(/obj/item/ammo_box/darkpack/c556/incendiary)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammobolt
	name = "Ammo (bolts)"
	desc = "包含三盒弩箭。"
	cost = 600
	contains = list(/obj/item/ammo_box/darkpack/arrows, /obj/item/ammo_box/darkpack/arrows, /obj/item/ammo_box/darkpack/arrows)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo75
	name = "Cartriages (.75 Ball)"
	desc = "包含一袋.75口径圆弹。"
	cost = 1000
	contains = list(/obj/item/ammo_box/darkpack/c75)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/ammo75_silver
	name = "Cartriages (.75 Ball Silver)"
	desc = "包含一袋.75口径银制圆弹。"
	cost = 7000
	contains = list(/obj/item/ammo_box/darkpack/c75/silver)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_colt1911
	name = "Ammo (3x Colt M1911 magazine)"
	desc = "包含三个柯尔特M1911弹匣。"
	cost = 50
	contains = list(/obj/item/ammo_box/magazine/darkpack45acp, /obj/item/ammo_box/magazine/darkpack45acp, /obj/item/ammo_box/magazine/darkpack45acp)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_glock19
	name = "Ammo (3x Brokk19 magazine)"
	desc = "包含三个布洛克19弹匣。"
	cost = 100
	contains = list(/obj/item/ammo_box/magazine/glock9mm, /obj/item/ammo_box/magazine/glock9mm, /obj/item/ammo_box/magazine/glock9mm)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_beretta
	name = "Ammo (4x Elite 92G magazines)"
	desc = "包含四个精英92G弹匣。"
	cost = 130
	contains = list(/obj/item/ammo_box/magazine/semi9mm, /obj/item/ammo_box/magazine/semi9mm, /obj/item/ammo_box/magazine/semi9mm, /obj/item/ammo_box/magazine/semi9mm)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_ak74
	name = "Ammo (3x AK74 magazines)"
	desc = "包含三个AK74弹匣。"
	cost = 100
	contains = list(/obj/item/ammo_box/magazine/darkpack545, /obj/item/ammo_box/magazine/darkpack545, /obj/item/ammo_box/magazine/darkpack545)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_deagle
	name = "Ammo (3x desert eagle magazines)"
	desc = "包含三个沙漠之鹰弹匣。"
	cost = 100
	contains = list(/obj/item/ammo_box/magazine/m44, /obj/item/ammo_box/magazine/m44, /obj/item/ammo_box/magazine/m44)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_deagle50
	name = "Ammo (3x Desert Eagle 50AE magazines)"
	desc = "包含三个沙漠之鹰50AE弹匣。"
	cost = 1200
	contains = list(/obj/item/ammo_box/magazine/m50, /obj/item/ammo_box/magazine/m50, /obj/item/ammo_box/magazine/m50)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_mp5
	name = "Ammo (3x HK MP5 magazines)"
	desc = "包含三个HK MP5弹匣。"
	cost = 150
	contains = list(/obj/item/ammo_box/magazine/darkpack9mp5, /obj/item/ammo_box/magazine/darkpack9mp5, /obj/item/ammo_box/magazine/darkpack9mp5)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_uzi
	name = "Ammo (3x mini uzi magazines)"
	desc = "包含三个迷你乌兹弹匣。"
	cost = 200
	contains = list(/obj/item/ammo_box/magazine/darkpack9mm, /obj/item/ammo_box/magazine/darkpack9mm, /obj/item/ammo_box/magazine/darkpack9mm)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_ar15
	name = "Ammo (3x AR-15 rifle magazine)"
	desc = "包含三个AR-15步枪弹匣。"
	cost = 200
	contains = list(/obj/item/ammo_box/magazine/darkpack556, /obj/item/ammo_box/magazine/darkpack556, /obj/item/ammo_box/magazine/darkpack556)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_aug
	name = "Ammo (3x AUG carbine magazine)"
	desc = "包含三个AUG卡宾枪弹匣。"
	cost = 300
	contains = list(/obj/item/ammo_box/magazine/darkpackaug, /obj/item/ammo_box/magazine/darkpackaug, /obj/item/ammo_box/magazine/darkpackaug)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_fal
	name = "Ammo (2x battle rifle magazine)"
	desc = "包含两个战斗步枪弹匣。"
	cost = 300
	contains = list(/obj/item/ammo_box/magazine/darkpack762x51fal, /obj/item/ammo_box/magazine/darkpack762x51fal)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_thompson
	name = "Ammo (3x Thompson magazine)"
	desc = "包含三个汤普森弹匣。"
	cost = 300
	contains = list(/obj/item/ammo_box/magazine/darkpackthompson, /obj/item/ammo_box/magazine/darkpackthompson, /obj/item/ammo_box/magazine/darkpackthompson)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/magazine_mac10
	name = "Ammo (3x Braddock magazines)"
	desc = "包含三个布拉多克弹匣。"
	cost = 250
	contains = list(/obj/item/ammo_box/magazine/darkpack45smg, /obj/item/ammo_box/magazine/darkpack45smg, /obj/item/ammo_box/magazine/darkpack45smg)
	crate_name = "ammo crate"

/datum/supply_pack/weapons/armorlight
	name = "Armor (3 civilian)"
	desc = "包含3种衣物和3种轻型头部护具。"
	cost = 1000
	contains = list(
		/obj/item/clothing/suit/vampire/trench,
		/obj/item/clothing/suit/vampire/trench/alt,
		/obj/item/clothing/suit/vampire/trench/archive,
		/obj/item/clothing/head/vampire/police,
		/obj/item/clothing/head/vampire/cowboy,
		/obj/item/clothing/head/vampire/british
	)
	crate_name = "armor crate"

/datum/supply_pack/weapons/armorpolice
	name = "Armor (police)"
	desc = "包含一套完整的警用防护装备。"
	cost = 1000
	contains = list(/obj/item/clothing/suit/vampire/vest,
					/obj/item/clothing/head/vampire/helmet)
	crate_name = "armor crate"

/datum/supply_pack/weapons/armorarmy
	name = "Armor (army)"
	desc = "包含一套完整的军用防护装备。"
	cost = 1500
	contains = list(/obj/item/clothing/suit/vampire/vest/army,
					/obj/item/clothing/head/vampire/army)
	crate_name = "armor crate"

/datum/supply_pack/weapons/armoreod
	name = "Armor (EOD)"
	desc = "包含一套完整的排爆防护装备。"
	cost = 2000
	contains = list(/obj/item/clothing/suit/vampire/eod,
					/obj/item/clothing/head/vampire/eod)
	crate_name = "armor crate"

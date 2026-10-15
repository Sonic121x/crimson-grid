/obj/effect/spawner/random/structure/shipping_container/darkpack
	name = "random darkpack shipping container spawner"
	icon = 'modular_darkpack/modules/decor/icons/smallcontainers.dmi'
	icon_state = "random_container"
	loot = list(
		/obj/structure/shipping_container/darkpack/endron = 3,
		/obj/structure/shipping_container/darkpack/endron/alt = 3,
		/obj/structure/shipping_container/darkpack/endron/gas = 3,
		/obj/structure/shipping_container/darkpack/magadon = 3,
		/obj/structure/shipping_container/darkpack/kings = 3,
		/obj/structure/shipping_container/darkpack/kings/alt = 3,
		/obj/structure/shipping_container/darkpack/avalon = 3,
		/obj/structure/shipping_container/darkpack/tellus = 3,
		/obj/structure/shipping_container/darkpack/otolleys = 3,
		/obj/structure/shipping_container/darkpack/gateway = 3,
		/obj/structure/shipping_container/darkpack/gateway/alt = 3,
	)

/obj/structure/shipping_container/darkpack
	name = "shipping container"
	desc = "DONT PLACE THIS !! ITS FAKE AS HELL !!"
	icon = 'modular_darkpack/modules/decor/icons/smallcontainers.dmi'
	icon_state = "random_container"
	abstract_type = /obj/structure/shipping_container/darkpack

/obj/structure/shipping_container/darkpack/endron
	name = "\improper 安德隆集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着安德隆的标志。"
	icon_state = "endron1"

/obj/structure/shipping_container/darkpack/endron/alt
	icon_state = "endron2"

/obj/structure/shipping_container/darkpack/endron/gas
	name = "\improper 安德隆散装气体储罐"
	desc = "用于大批量运输气体的标准规格储罐，上面印着安德隆的标志，却没有注明装的是什么气体。"
	icon_state = "endron3"

/obj/structure/shipping_container/darkpack/magadon
	name = "\improper 玛加顿集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着玛加顿制药的标志。"
	icon_state = "magadon"

/obj/structure/shipping_container/darkpack/kings
	name = "\improper 国王酿酒厂集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着国王酿酒厂的标志。"
	icon_state = "kings1"

/obj/structure/shipping_container/darkpack/kings/alt
	icon_state = "kings2"

/obj/structure/shipping_container/darkpack/avalon
	name = "\improper 阿瓦隆公司集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着阿瓦隆公司的标志。"
	icon_state = "avalon"

/obj/structure/shipping_container/darkpack/tellus
	name = "\improper 忒卢斯企业集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着忒卢斯企业的标志。"
	icon_state = "tellus"

/obj/structure/shipping_container/darkpack/otolleys
	name = "\improper 奥托利集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着奥托利的标志。"
	icon_state = "otolleys"

// I just made these up because I needed some filler containers.
/obj/structure/shipping_container/darkpack/gateway
	name = "\improper 门户物流集装箱"
	desc = "用于大批量运输货物的标准规格集装箱，上面印着门户物流的标志。"
	icon_state = "gateway1"

/obj/structure/shipping_container/darkpack/gateway/alt
	icon_state = "gateway2"

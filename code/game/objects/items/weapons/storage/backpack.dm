/* Backpacks
 * Contains:
 *		Backpack
 *		Backpack Types
 *		Satchel Types
 */

/*
 * Backpack
 */

/obj/item/weapon/storage/backpack
	name = "load bearing webbing"
	desc = "A kit of load bearing gear consisting of pouches, suspenders and a belt."
	icon_state = "webbing"
	item_state = "webbing"
	w_class = 4
	slot_flags = SLOT_BACK	//ERROOOOO
	max_w_class = 3
	max_combined_w_class = 21
	storage_slots = 21
	burn_state = FLAMMABLE
	burntime = 20

/obj/item/weapon/storage/backpack/attackby(obj/item/weapon/W, mob/user, params)
	playsound(src.loc, "rustle", 50, 1, -5)
	..()
/*
 * Backpack Types
 */

/obj/item/weapon/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = "bluespace=4"
	icon_state = "holdingpack"
	max_w_class = 5
	max_combined_w_class = 35
	burn_state = FIRE_PROOF
	var/pshoom = 'sound/items/PSHOOM.ogg'
	var/alt_sound = 'sound/items/PSHOOM_2.ogg'

/obj/item/weapon/storage/backpack/holding/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is jumping into [src]! It looks like \he's trying to commit suicide.</span>")
	user.drop_item()
	user.Stun(5)
	sleep(20)
	playsound(src, "rustle", 50, 1, -5)
	qdel(user)
	return

/obj/item/weapon/storage/backpack/holding/can_be_inserted(obj/item/W, stop_messages = 0, mob/user)
	if(crit_fail)
		user << "<span class='danger'>The Bluespace generator isn't working.</span>"
		return
	return ..()

/obj/item/weapon/storage/backpack/holding/content_can_dump(atom/dest_object, mob/user)
	if(Adjacent(user))
		if(get_dist(user, dest_object) < 8)
			if(dest_object.storage_contents_dump_act(src, user))
				if(alt_sound && prob(1))
					playsound(src, alt_sound, 40, 1)
				else
					playsound(src, pshoom, 40, 1)
				user.Beam(dest_object,icon_state="rped_upgrade",icon='icons/effects/effects.dmi',time=5)
				return 1
		user << "The [src.name] buzzes."
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, 0)
	return 0

/obj/item/weapon/storage/backpack/holding/handle_item_insertion(obj/item/W, prevent_warning = 0, mob/user)
	if(istype(W, /obj/item/weapon/storage/backpack/holding) && !W.crit_fail)
		var/safety = alert(user, "You feel this may not be the best idea.", "Put in [name]?", "Proceed", "Abort")
		if(safety == "Abort" || !in_range(src, user) || !src || !W || user.incapacitated())
			return
		investigate_log("has become a singularity. Caused by [user.key]","singulo")
		user << "<span class='danger'>The Bluespace interfaces of the two devices catastrophically malfunction!</span>"
		qdel(W)
		var/obj/singularity/singulo = new /obj/singularity (get_turf(src))
		singulo.energy = 300 //should make it a bit bigger~
		message_admins("[key_name_admin(user)] detonated a bag of holding")
		log_game("[key_name(user)] detonated a bag of holding")
		qdel(src)
		singulo.process()
		return
	..()

/obj/item/weapon/storage/backpack/holding/proc/failcheck(mob/user)
	if (prob(src.reliability)) return 1 //No failure
	if (prob(src.reliability))
		user << "<span class='danger'>The Bluespace portal resists your attempt to add another item.</span>" //light failure
	else
		user << "<span class='danger'>The Bluespace generator malfunctions!</span>"
		for (var/obj/O in src.contents) //it broke, delete what was in it
			qdel(O)
		crit_fail = 1
		icon_state = "brokenpack"

/obj/item/weapon/storage/backpack/holding/singularity_act(current_size)
	var/dist = max((current_size - 2),1)
	explosion(src.loc,(dist),(dist*2),(dist*4))
	return


/obj/item/weapon/storage/backpack/santabag
	name = "Santa's Gift Bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space in Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = 4
	max_w_class = 3
	max_combined_w_class = 60

/obj/item/weapon/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"
	item_state = "backpack"

/obj/item/weapon/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "It's a backpack made by Honk! Co."
	icon_state = "clownpack"
	item_state = "clownpack"

/obj/item/weapon/storage/backpack/mime
	name = "Parcel Parceaux"
	desc = "A silent backpack made for those silent workers. Silence Co."
	icon_state = "mimepack"
	item_state = "mimepack"

/obj/item/weapon/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/security
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/captain
	name = "captain's backpack"
	desc = "It's a special backpack made exclusively for Nanotrasen officers."
	icon_state = "captainpack"
	item_state = "captainpack"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/industrial
	name = "industrial backpack"
	desc = "It's a tough backpack for the daily grind of station life."
	icon_state = "engiepack"
	item_state = "engiepack"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/botany
	name = "botany backpack"
	desc = "It's a backpack made of all-natural fibers."
	icon_state = "botpack"
	item_state = "botpack"

/obj/item/weapon/storage/backpack/chemistry
	name = "chemistry backpack"
	desc = "A backpack specially designed to repel stains and hazardous liquids."
	icon_state = "chempack"
	item_state = "chempack"

/obj/item/weapon/storage/backpack/genetics
	name = "travel pack"
	desc = "A makeshift bag, designed to carry light and the essentials."
	icon_state = "genepack"
	item_state = "genepack"

/obj/item/weapon/storage/backpack/science
	name = "science backpack"
	desc = "A specially designed backpack. It's fire resistant and smells vaguely of plasma."
	icon_state = "toxpack"
	item_state = "toxpack"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/virology
	name = "virology backpack"
	desc = "A backpack made of hypo-allergenic fibers. It's designed to help prevent the spread of disease. Smells like monkey."
	icon_state = "viropack"
	item_state = "viropack"


/*
 * Satchel Types
 */

/obj/item/weapon/storage/backpack/satchel
	name = "leather satchel"
	desc = "It's a very fancy satchel made with fine leather."
	icon_state = "leather_bag"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/satchel/withwallet/New()
	..()
	new /obj/item/weapon/storage/wallet/random( src )

/obj/item/weapon/storage/backpack/satchel_norm
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"

/obj/item/weapon/storage/backpack/satchel_eng
	name = "industrial satchel"
	desc = "A tough satchel with extra pockets."
	icon_state = "satchel-eng"
	item_state = "engiepack"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/satchel_med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"
	item_state = "medicalpack"

/obj/item/weapon/storage/backpack/satchel_vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"
	item_state = "satchel-vir"

/obj/item/weapon/storage/backpack/satchel_chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"
	item_state = "satchel-chem"

/obj/item/weapon/storage/backpack/satchel_gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"
	item_state = "satchel-gen"

/obj/item/weapon/storage/backpack/satchel_tox
	name = "scientist satchel"
	desc = "Useful for holding research materials."
	icon_state = "satchel-tox"
	item_state = "satchel-tox"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/satchel_hyd
	name = "botanist satchel"
	desc = "A satchel made of all natural fibers."
	icon_state = "satchel-hyd"
	item_state = "satchel-hyd"

/obj/item/weapon/storage/backpack/satchel_sec
	name = "security satchel"
	desc = "A robust satchel for security related needs."
	icon_state = "satchel-sec"
	item_state = "securitypack"

/obj/item/weapon/storage/backpack/satchel_cap
	name = "captain's satchel"
	desc = "An exclusive satchel for Nanotrasen officers."
	icon_state = "satchel-cap"
	item_state = "captainpack"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/satchel_flat
	name = "smuggler's satchel"
	desc = "A very slim satchel that can easily fit into tight spaces."
	icon_state = "satchel-flat"
	w_class = 3 //Can fit in backpacks itself.
	max_combined_w_class = 15
	level = 1
	cant_hold = list(/obj/item/weapon/storage/backpack/satchel_flat) //muh recursive backpacks


/obj/item/weapon/storage/backpack/satchel_flat/hide(var/intact)
	if(intact)
		invisibility = 101
		anchored = 1 //otherwise you can start pulling, cover it, and drag around an invisible backpack.
		icon_state = "[initial(icon_state)]2"
	else
		invisibility = initial(invisibility)
		anchored = 0
		icon_state = initial(icon_state)

/obj/item/weapon/storage/backpack/satchel_flat/New()
	..()
	new /obj/item/stack/tile/plasteel(src)
	new /obj/item/weapon/crowbar(src)

/obj/item/weapon/storage/backpack/spearquiver
	name = "spear quiver"
	desc = "A leather and iron quiver designed to hold throwing spears."
	icon_state = "spearquiver_3"
	item_state = "throwingholster"
	w_class = 3
	storage_slots = 6
	max_combined_w_class = 30 // Just guessing here, shouldn't be a problem?
	can_hold = list(
		/obj/item/stack/spear,
		/obj/item/weapon/restraints/legcuffs/bola
		)

/obj/item/weapon/storage/backpack/spearquiver/New()
	..()
	new /obj/item/stack/spear(src)
	new /obj/item/stack/spear(src)
	new /obj/item/stack/spear(src)
	new /obj/item/stack/spear(src)
	new /obj/item/stack/spear(src)
	new /obj/item/weapon/restraints/legcuffs/bola(src)

/obj/item/weapon/storage/backpack/dufflebag
	name = "dufflebag"
	desc = "A large dufflebag for holding extra things."
	icon_state = "duffle"
	item_state = "duffle"
	slowdown = 1
	max_combined_w_class = 30

/obj/item/weapon/storage/backpack/dufflebag/syndie
	name = "suspicious looking dufflebag"
	desc = "A large dufflebag for holding extra tactical supplies."
	icon_state = "duffle-syndie"
	item_state = "duffle-syndiemed"
	origin_tech = "syndicate=1"
	silent = 1
	slowdown = 0

/obj/item/weapon/storage/backpack/dufflebag/syndie/med
	name = "medical dufflebag"
	desc = "A large dufflebag for holding extra tactical medical supplies."
	icon_state = "duffle-syndiemed"
	item_state = "duffle-syndiemed"

/obj/item/weapon/storage/backpack/dufflebag/syndie/ammo
	name = "ammunition dufflebag"
	desc = "A large dufflebag for holding extra weapons ammunition and supplies."
	icon_state = "duffle-syndieammo"
	item_state = "duffle-syndieammo"

/obj/item/weapon/storage/backpack/dufflebag/syndie/ammo/loaded
	desc = "A large dufflebag, packed to the brim with Bulldog shotgun ammo."

/obj/item/weapon/storage/backpack/dufflebag/syndie/ammo/loaded/New()
	..()
	contents = list()
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g/buckshot(src)
	new /obj/item/ammo_box/magazine/m12g/stun(src)
	new /obj/item/ammo_box/magazine/m12g/dragon(src)
	return

/obj/item/weapon/storage/backpack/dufflebag/syndie/surgery
	name = "surgery dufflebag"
	desc = "A suspicious looking dufflebag for holding surgery tools."
	icon_state = "duffle-syndiemed"
	item_state = "duffle-syndiemed"

/obj/item/weapon/storage/backpack/dufflebag/syndie/surgery/New()
	..()
	contents = list()
	new /obj/item/weapon/scalpel(src)
	new /obj/item/weapon/hemostat(src)
	new /obj/item/weapon/retractor(src)
	new /obj/item/weapon/circular_saw(src)
	new /obj/item/weapon/surgicaldrill(src)
	new /obj/item/weapon/cautery(src)
	new /obj/item/weapon/surgical_drapes(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/device/mmi/syndie(src)
	return

/obj/item/weapon/storage/backpack/dufflebag/captain
	name = "captain's dufflebag"
	desc = "A large dufflebag for holding extra captainly goods."
	icon_state = "duffle-captain"
	item_state = "duffle-captain"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/dufflebag/med
	name = "medical dufflebag"
	desc = "A large dufflebag for holding extra medical supplies."
	icon_state = "duffle-med"
	item_state = "duffle-med"

/obj/item/weapon/storage/backpack/dufflebag/sec
	name = "security dufflebag"
	desc = "A large dufflebag for holding extra security supplies and ammunition."
	icon_state = "duffle-sec"
	item_state = "duffle-sec"

/obj/item/weapon/storage/backpack/dufflebag/engineering
	name = "industrial dufflebag"
	desc = "A large dufflebag for holding extra tools and supplies."
	icon_state = "duffle-eng"
	item_state = "duffle-eng"
	burn_state = FIRE_PROOF

/obj/item/weapon/storage/backpack/dufflebag/clown
	name = "clown's dufflebag"
	desc = "A large dufflebag for holding lots of funny gags!"
	icon_state = "duffle-clown"
	item_state = "duffle-clown"

/obj/item/weapon/storage/backpack/cloak
	name = "desert cloak"
	desc = "A worn desert cloak rigged over load bearing webbing, protects the user from the sunlight."
	icon_state = "pouch_cloak"
	item_state = "pouch_cloak"
	flags = BLOCKHAIR
	max_combined_w_class = 35

/obj/item/weapon/storage/backpack/combat_ruck
	name = "combat ruck"
	desc = "A large ruck-sack commonly issued and seen with combat armor sets. Easily interfaces to most armors without straps, allowing for chafeless comfort."
	icon_state = "combat_ruck"
	item_state = "combat_ruck"
	max_combined_w_class = 45
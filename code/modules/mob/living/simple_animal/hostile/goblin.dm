/mob/living/simple_animal/hostile/goblin
	name = "goblin"
	desc = "A short, green creature defined by its anger and hate."
	icon = 'icons/mob/creatures.dmi'
	icon_state = ""
	icon_living = ""
	icon_dead = "goblin_dead"
	mob_biotypes = list(MOB_ORGANIC)
	gender = NEUTER
	turns_per_move = 5
	speak_emote = list("growls")
	emote_see = list("growls")
	emote_taunt = list("growls")
	taunt_chance = 30
	a_intent = INTENT_HARM
	maxHealth = 75
	health = 75
	speed = 1
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "savages"
	faction = list("goblin")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	
	atmos_requirements = list("min_oxy" = 2, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 5
	minbodytemp = 0
	maxbodytemp = 1200
	
	robust_searching = 1
	gold_core_spawnable = NO_SPAWN

	guaranteed_butcher_results = list(/obj/item/stack/sheet/bone = 2)
	
	
/mob/living/simple_animal/hostile/goblin/Initialize()
	..()

	icon_state = "goblin_spawn"
	icon_living = "goblin_spawn"

	anchored = TRUE

	sleep(20)

	if(stat == DEAD)
		anchored = FALSE
		return

	var/goblin_sprite = pick("goblin_1", "goblin_2")
	icon_state = goblin_sprite
	icon_living = goblin_sprite

	anchored = FALSE

	var/atom/initialMove = pick(range(1, src))

	var/check = 20

	while(!istype(initialMove, /turf/open) && check > 0)
		check--
		if(istype(initialMove, /turf/closed) || !initialMove.loc)
			initialMove = pick(range(1, src))
			continue
		initialMove = initialMove.loc

	if(check <= 0 || stat == DEAD)
		return

	Move(initialMove)

	
/mob/living/simple_animal/hostile/goblin/death(gibbed)
	new /obj/effect/decal/cleanable/blood/splatter(get_turf(src), get_static_viruses())
	return ..()
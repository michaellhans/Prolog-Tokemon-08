/* Kelompok 8 */
/* Nama/NIM : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* Deklarasi Fakta */
increaseDamage(fire,leaves).
increaseDamage(earth,fire).
increaseDamage(earth,lightning).
increaseDamage(leaves,water).
increaseDamage(water,fire).
increaseDamage(water,earth).
increaseDamage(wind,leaves).
increaseDamage(wind,earth).
increaseDamage(lightning,water).
increaseDamage(lightning,wind).

decreaseDamage(leaves,fire).
decreaseDamage(fire,earth).
decreaseDamage(lightning,earth).
decreaseDamage(water,leaves).
decreaseDamage(fire,water).
decreaseDamage(earth,water).
decreaseDamage(leaves,wind).
decreaseDamage(earth,wind).
decreaseDamage(water,lightning).
decreaseDamage(wind,lightning).

legendary(ligator).
legendary(camellia).
legendary(phoenix).

:- dynamic(health/2).
health(ligator,630).
health(camellia,580).
health(phoenix,500).
health(sijagomerah,80).
health(rose,100).
health(aqua,130).
health(thor,90).
health(rocky,120).
health(wush,110).
health(sijagobiru,85).
health(mawar,105).
health(ades,135).
health(charge,95).
health(hulk,125).
health(aang,115).
health(sijagoungu,90).
health(melati,110).
health(pristine,140).
health(thunder,100).
health(smash,130).
health(topan,120).
health(sijagokuning,95).
health(refflesia,115).

:- dynamic(damage/2).
damage(ligator,40).
damage(camellia,57).
damage(phoenix,70).
damage(sijagomerah,22).
damage(rose,17).
damage(aqua,13).
damage(thor,19).
damage(rocky,14).
damage(wush,15).
damage(sijagobiru,23).
damage(mawar,18).
damage(ades,14).
damage(charge,20).
damage(hulk,15).
damage(aang,16).
damage(sijagoungu,24).
damage(melati,19).
damage(pristine,15).
damage(thunder,21).
damage(smash,16).
damage(topan,17).
damage(sijagokuning,25).
damage(refflesia,20).

type(ligator,water).
type(camellia,leaves).
type(phoenix,fire).
type(sijagomerah,fire).
type(rose,leaves).
type(aqua,water).
type(thor,lightning).
type(rocky,earth).
type(wush,wind).
type(sijagobiru,fire).
type(mawar,leaves).
type(ades,water).
type(charge,lightning).
type(hulk,earth).
type(aang,wind).
type(sijagoungu,fire).
type(melati,leaves).
type(pristine,water).
type(thunder,lightning).
type(smash,earth).
type(topan,wind).
type(sijagokuning,fire).
type(refflesia,leaves).

normal(sijagomerah).
normal(rose).
normal(aqua).
normal(thor).
normal(rocky).
normal(wush).
normal(sijagobiru).
normal(mawar).
normal(ades).
normal(charge).
normal(hulk).
normal(aang).
normal(sijagoungu).
normal(melati).
normal(pristine).
normal(thunder).
normal(smash).
normal(topan).
normal(sijagokuning).
normal(refflesia).

skill(water,hydropump). % damage = 50
skill(earth,earthquake). % damage = 75
skill(wind,roost). % health +20
skill(leaves,absorb). % health +(200%)*damage
skill(lightning,bolt). % damage = 90
skill(fire,eruption). % damage = 110. syarat = abis pake skill ini, damage berkurang menjadi 60% nya

:- dynamic(playerposition/2).
playerposition(1,1).

/* Deklarasi Rules */
start :-
    write('Once upon a time, long long ago....'),nl,
    write('There lied a magnificent land behind the mountains, but hidden from the rest of the world.'),nl,
    write('In this place named Tokemon Land, there were many creatures called tokemons.'),nl,
    write('Tokemons and humans had been living together in harmony and peace, for the longest time ever.'),nl,
    write('But, there was a man whose greed could never be satisfied. And he went by the name Dead Eye.'),nl,
    write('His ambition was to rule the world by using the Legendary Tokemons, who were really powerful.'),nl,
    write('Worst of all, he succeeded in collecting all of the Legendary Tokemons.'),nl,
    write('One day, he stood above the valley and shouted,'),nl,
    nl,
    write('EKUSUPUROSHION !!!'),nl,
    write('DUAR DUAR DUAR !!!'),nl,
    nl,
    write('What once was a peaceful life, had become a tragedy.'),nl,
    write('As one of the talented Tokemon trainers, you were sent to save the country.'),nl,
    write('Defeating all of the Legendary Tokemons who were being controlled by Dead Eye was the key.'),nl,
    write('But of course, you could not do that by your own.'),nl,
    write('You have to form your own power.'),nl,
    write('And you can only do that with the help of Normal Tokemons who roamed in your country.'),nl,
    write('Beware and we wish you the best of luck, Trainer!'),nl,
    nl,
    help.

help :-
    write('Available commands: '),nl,
    write('start. -- start the game!'),nl,
    write('help. -- show available commands'),nl,
    write('quit. -- quit the game'),nl,
    write('n. s. e. w. -- move'),nl,
    write('map. -- look at the map'),nl,
    write('heal -- cure Tokemon in inventory if you are in gym center'),nl, 
    write('status. -- show your status'),nl,
    write('save(Filename). -- save your game'),nl,
    write('load(Filename). -- load previously saved game'),nl.
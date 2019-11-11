/* Kelompok 8 */
/* Nama/NIM : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

:- include('map.pl').
:- include('db.pl').
:- include('attack.pl').

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
    write('specialattack. -- summon skill'),nl,
    write('save(Filename). -- save your game'),nl,
    write('load(Filename). -- load previously saved game'),nl.
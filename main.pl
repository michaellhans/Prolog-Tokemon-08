/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

:- include('map.pl').
:- include('attack.pl').
:- include('inventory.pl').
:- include('test.pl').

:- dynamic(playerposition/2).
playerposition(2,1).

:- dynamic(isstart/1).
isstart(0).

/* Deklarasi Rules */

startOrNo :-
    retract(isstart(X)),
    ((X=:=0 -> write('You have not started the game yet. Please input the start command!'),nl);
    write('The game starts from here.'),nl).

checkCommand(cmd) :-
    retract(isstart(X)),
    retract(fightOrNo(Y)),
    ((X=:=0,
    (cmd==help; cmd==w; cmd==a; cmd==s; cmd==d; cmd==map; cmd==heal; cmd==status; 
    cmd==specialattack; cmd=save; cmd==load; cmd=fight; cmd=run) -> 
    write('You cannot use this command, since the game has not started yet!'),nl);
    (X=:=1, cmd==start -> write('You cannot use this command, since the game has started yet.'),nl);
    (X=:=1, Y=:=1, 
    (cmd==start, cmd==help, cmd==quit, cmd==w, cmd==a, cmd==s, cmd==d, 
    cmd==save, cmd==load, cmd==map, cmd==heal, cmd==status) -> write('You cannot use this command, since you are in the middle of the fight!'),nl)
    ).

start :-
    startOrNo,
    art,
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
    retract(isstart(0)).
    assertz(isstart(1)). 

help :-
    write('Available commands: '),nl,
    write('start. -- start the game!'),nl,
    write('help. -- show available commands'),nl,
    write('quit. -- quit the game'),nl,
    write('w. a. s. d. -- move'),nl,
    write('map. -- look at the map'),nl,
    write('heal -- cure Tokemon in inventory if you are in gym center'),nl,
    write('status. -- show your status'),nl,
    write('specialattack. -- summon skill'),nl,
    write('save(Filename). -- save your game'),nl,
    write('load(Filename). -- load previously saved game'),nl.

art :-
    write('        ______   _______    __  __    ______    ___  ___    _______    __  __     '),nl,
    write('       (_    _) (   _   )  (  )/  )  (  ____)  (   \\/   )  (   _   )  (  \\(  )  '),nl,
    write('         )  (    ) ( ) (    )    (    ) __)     )      (    ) ( ) (    )    (     '),nl,
    write('        (____)  (_______)  (__)\\__)  (______)  (__/\\/\\__)  (_______)  (__)\\__)'),nl,nl,
    write('         ______    ______    _______      __       ___      _______    _____      '),nl,
    write('        (   __ \\  (   __ \\  (   _   )    (  )     (   )    (   _   )  /  ___)   '),nl,
    write('         ) ____/   )     /   ) ( ) (     / _\\/     ) (__    ) ( ) (  (  (__-.    '),nl,
    write('        (___)     (__)\\__)  (_______)   (___/\\    (_____)  (_______)  \\_____/  '),nl,nl,nl,nl.

quit :- halt.

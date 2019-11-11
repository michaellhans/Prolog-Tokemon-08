/* IF2121 - Logika Komputasional */
/* Kelompok 8 */
/* Nama/NIM : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

:- include('db.pl').

:- dynamic(me/6).
:- dynamic(enemy/6).
:- dynamic(available/1).
me(wush,110,15,wind,roost,21).
enemy(sijagobiru,85,23,fire,overheat,5).
available(hydropump). % damage = 50
available(earthquake). % damage = 75
available(roost). % health +20
available(absorb). % health +(*damage
available(bolt). % damage = 90
available(eruption). % damage = 110. syarat = abis pake skill ini, damage berkurang menjadi 60% nya

/* Attack attribute */
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

/* Weakness attribute type */
/* weakness(strong,weak) */
weakness(fire,leaves).
weakness(earth,fire).
weakness(earth,lightning).
weakness(leaves,water).
weakness(water,fire).
weakness(water,earth).
weakness(wind,leaves).
weakness(wind,earth).
weakness(lightning,water).
weakness(lightning,wind).

/* Resistance attribute type */
/* resistance(weak,strong) */
resistance(leaves,fire).
resistance(fire,earth).
resistance(lightning,earth).
resistance(water,leaves).
resistance(fire,water).
resistance(earth,water).
resistance(leaves,wind).
resistance(earth,wind).
resistance(water,lightning).
resistance(wind,lightning).

pick(X) :- 
        write(X),
        write(' I choose you'),nl.

fight :-
        write('Choose your Tokemon'),nl.

attack :-
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        write('Tokemonku - '), write(Name1),nl,
        write('Health : '), write(Hp1),nl,
        write('Type : '),write(Type1),nl,nl,
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        write('Musuh - '),write(Name2),nl,
        write('Health : '),write(Hp2),nl,
        write('Type : '),write(Type2),nl,nl,
        ((increaseDamage(Type1,Type2) -> write('You attack with double damage!'),nl,nl,NewHp2 is Hp2-2*Dmg1);
        (decreaseDamage(Type1,Type2) -> write('You attack with half damage!'),nl,nl,NewHp2 is Hp2-Dmg1/2);
        (write('You attack with normal damage!'),nl,nl,NewHp2 is Hp2-Dmg1)),
        assertz(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        (((NewHp2 =< 0) -> Dead is 0, 
        write('Musuh telah mati.'),nl,
        write('Musuh - '),write(Name2),nl,
        write('Health : '),write(Dead),nl,
        write('Type : '),write(Type2),nl,nl,
        assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));
        (write('Musuh - '),write(Name2),nl,
        write('Health : '),write(NewHp2),nl,
        write('Type : '),write(Type2),nl,nl,
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)))).

defend :-
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        write('Tokemonku - '), write(Name1),nl,
        write('Health : '), write(Hp1),nl,
        write('Type : '),write(Type1),nl,nl,
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        write('Musuh - '),write(Name2),nl,
        write('Health : '),write(Hp2),nl,
        write('Type : '),write(Type2),nl,nl,
        ((increaseDamage(Type2,Type1) -> write('Enemy attack with double damage!'),nl,nl,NewHp1 is Hp1-2*Dmg2);
        (decreaseDamage(Type2,Type1) -> write('Enemy attack with half damage!'),nl,nl,NewHp1 is Hp1-Dmg2/2);
        (write('Enemy attack with normal damage!'),nl,nl,NewHp1 is Hp1-Dmg2)),
        assertz(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        (((NewHp1 =< 0) -> Dead is 0, 
        write('Tokemonmu telah mati.'),nl,
        write('Tokemonku - '), write(Name1),nl,
        write('Health : '), write(Dead),nl,
        write('Type : '),write(Type1),nl,nl,
        assertz(me(Name1,Dead,Dmg1,Type1,Skill1,Id1)));
        (write('Tokemonku - '), write(Name1),nl,
        write('Health : '), write(NewHp1),nl,
        write('Type : '),write(Type1),nl,nl,
        assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1)))).

specialSkill :-
        me(Name1,Hp1,Dmg1,Type1,Skill1,Id1),
        write('Tokemonku - '), write(Name1),nl,
        write('Health : '), write(Hp1),nl,
        write('Type : '),write(Type1),nl,
        (available(Skill1) -> available(Skill1),
        write('Available skill : '),
        write(Skill1),nl,nl;
        write('Available skill : - '),nl,nl),
        enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2),
        write('Musuh - '),write(Name2),nl,
        write('Health : '),write(Hp2),nl,
        write('Type : '),write(Type2),nl,nl,
        activateSkill(Skill1).


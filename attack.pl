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

pick(X) :-
        retract(inventory(X,Health,Damage,Type,Skill,Id)),
        assertz(me(X,Health,Damage,Type,Skill,Id)),
        write(X),
        write(' I choose you!'),nl.

fight :-
        write('Choose your Tokemon.'),nl.

attack :-
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(Hp1),nl,
        write('Type : '),write(Type1),nl,nl,
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(Hp2),nl,
        write('Type : '),write(Type2),nl,nl,
        ((increaseDamage(Type1,Type2) -> write('You attacked with double damage!'),nl,nl,NewHp2 is Hp2-2*Dmg1);
        (decreaseDamage(Type1,Type2) -> write('You attacked with half damage!'),nl,nl,NewHp2 is Hp2-Dmg1/2);
        (write('You attacked with normal damage!'),nl,nl,NewHp2 is Hp2-Dmg1)),
        assertz(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        ((NewHp2 =< 0) -> Dead is 0, 
        write('Congratulations, you have defeated your enemy!'),nl,
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(Dead),nl,
        write('Type : '),write(Type2),nl,nl,
        write('Do you want to pick this tokemon? It will replace your oldest tokemon you have!'),nl,
        read(Response),nl,
        ((Response == yes; Response == y) -> addtolist(Name2);
        assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));
        (write('Enemy - '),write(Name2),nl,
        write('Health : '),write(NewHp2),nl,
        write('Type : '),write(Type2),nl,nl,
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)))).

defend :-
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(Hp1),nl,
        write('Type : '),write(Type1),nl,nl,
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        write('Musuh - '),write(Name2),nl,
        write('Health : '),write(Hp2),nl,
        write('Type : '),write(Type2),nl,nl,
        ((increaseDamage(Type2,Type1) -> write('Enemy attacked with double damage!'),nl,nl,NewHp1 is Hp1-2*Dmg2);
        (decreaseDamage(Type2,Type1) -> write('Enemy attacked with half damage!'),nl,nl,NewHp1 is Hp1-Dmg2/2);
        (write('Enemy attacked with normal damage!'),nl,nl,NewHp1 is Hp1-Dmg2)),
        assertz(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        (((NewHp1 =< 0) -> Dead is 0, 
        write('You lost your Tokemon!'),nl,
        write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(Dead),nl,
        write('Type : '),write(Type1),nl,nl,
        assertz(me(Name1,Dead,Dmg1,Type1,Skill1,Id1)));
        (write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(NewHp1),nl,
        write('Type : '),write(Type1),nl,nl,
        assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1)))).

specialSkill :-
        me(Name1,Hp1,_,Type1,Skill1,_),
        write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(Hp1),nl,
        write('Type : '),write(Type1),nl,
        (available(Skill1) -> available(Skill1),
        write('Available skill : '),
        write(Skill1),nl,nl;
        write('Available skill : - '),nl,nl),
        enemy(Name2,Hp2,_,Type2,_,_),
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(Hp2),nl,
        write('Type : '),write(Type2),nl,nl,
        activateSkill(Skill1).

activateSkill(NameSkill) :-
    ((NameSkill == hydropump) -> write('You used hydropump skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 50,
    write('Enemy took heavy damage from your Tokemon!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('COngratulations, you have defeated your enemy!'),nl,
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));

    (NameSkill == earthquake) -> write('You used earthquake skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 75,
    write('Enemy took heavy damage from your Tokemon!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Congratulations, you have defeated your enemy!'),nl,
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));
    
    (NameSkill == roost) -> write('You used roost skill'),nl,
    retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
    NewHp1 is Hp1 + 20,
    write('Skill Activated!'),nl,
    write('My Tokemon - '), write(Name1),nl,
    write('Health : '), write(NewHp1),nl,
    write('Type : '),write(Type1),nl,nl,
    assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1));

    (NameSkill == absorb) -> write('You used absorb skill'),nl,
    retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
    NewHp1 is Hp1 + 2*Dmg1,
    write('Skill Activated!'),nl,
    write('Tokemonku - '), write(Name1),nl,
    write('Health : '), write(NewHp1),nl,
    write('Type : '),write(Type1),nl,nl,
    assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1));

    (NameSkill == bolt) -> write('You use bolt skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 90,
    write('Enemy took heavy damage from your Tokemon!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Congratulations, you have defeated your enemy!'),nl,
    write('Enemy - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Enemy - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));

    (NameSkill == eruption) -> write('You use eruption skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 110,
    write('Enemy took heavy damage from your Tokemon!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Congratulations, you have defeated your enemy!'),nl,
    write('Enemy - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Enemy - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));

    write('You have no skill to use'),nl).
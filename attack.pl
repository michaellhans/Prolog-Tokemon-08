/* IF2121 - Logika Komputasional */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

:- include('db.pl').

:- dynamic(me/6).
:- dynamic(enemy/6).
:- dynamic(available/1).
enemy(sijagobiru,85,23,fire,overheat,5).

/* Available skill */
available(hydropump). % damage = 50
available(leafstorm).
available(blastburn).
available(flamethower).
available(overheat).
available(sacredfire).
available(eruption). % damage = 110. syarat = abis pake skill ini, damage berkurang menjadi 60% nya
available(woodhammer).
available(absorb). % health +(*damage
available(leechseed).
available(gigadrain).
available(tidalwave).
available(hurricane).
available(absolutezero).
available(thorhammer).
available(discharge).
available(bolt). % damage = 90
available(fissure).
available(earthquake). % damage = 75
available(superpower).
available(roost). % health +20
available(skyattack).
available(aerialace).

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
        command(initstart,A),
        command(initfight,B),
        command(initpick,C),
        ((A=:=0 -> write('You even have not started the game yet.'),nl);
        (A=:=1, B=:=1, C=:=1 -> write('You are in the middle of fighting. You cannot use this option!'),nl);
        (A=:=1, B=:=1, C=:=0 ->
        retract(inventory(X,Health,Damage,Type,Skill,Id)),
        assertz(me(X,Health,Damage,Type,Skill,Id)),
        write(X),
        write(' I choose you!'),nl),
        retract(command(initpick,0)),assertz(command(initpick,1))).

fight :-
        command(initstart,A),
        command(inittokemonappear,B),
        ((A=:=0 -> write('You even have not started the game yet.'),nl);
        (A=:=1, B=:=0 -> write('You have not met any Tokemon!'));
        (A=:=1, B=:=1 -> write('Choose your Tokemon!'),nl,
        retract(command(initfight,0)), assertz(command(initfight,1)),
        nl,write('Available Tokemons: '),nl,
        findall(X,inventory(X,_,_,_,_,_),Result),
        printinventory(Result))).

attack :-
        command(initstart,X),
        command(initfight,Y),
        command(initpick,Z),
        command(initenemydead,A),
        ((X=:=0 -> write('You even have not started the game yet.'),nl);
        (X=:=1, Y=:=1, Z=:=0 -> write('You must choose a Tokemon first!'),nl);
        (X=:=1, Y=:=0 -> write('You are not fighting right now. You cannot use this option!'),nl);
        (X=:=1, Y=:=1, Z=:=1 -> retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
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
        ((Response == yes; Response == y) -> 
        retract(command(initenemydead,0)),assertz(command(initenemydead,1)),capture;
        assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));
        (write('Enemy - '),write(Name2),nl,
        write('Health : '),write(NewHp2),nl,
        write('Type : '),write(Type2),nl,nl,
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)))))).

defend :-
        command(initstart,X),
        command(initfight,Y),
        ((X=:=0 -> write('You even have not started the game yet.'),nl);
        (X=:=1, Y=:=0 -> write('You are not fighting right now. You cannot use this option!'),nl);
        (X=:=1, Y=:=1 -> retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
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
        write('Your Tokemon is dead!'),nl,
        write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(Dead),nl,
        write('Type : '),write(Type1),nl,nl,
        retract(command(initfight,1)), assertz(command(initfight,0)),
        retract(command(inittokemonappear,1)),assertz(command(inittokemonappear,0)),
        assertz(me(Name1,Dead,Dmg1,Type1,Skill1,Id1)));
        (write('My Tokemon - '), write(Name1),nl,
        write('Health : '), write(NewHp1),nl,
        write('Type : '),write(Type1),nl,nl,
        assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1)))))).

specialSkill :-
        command(initstart,X),
        command(initfight,Y),
        command(inittokemonappear,Z),
        ((X=:=0 -> write('You even have not started the game yet.'),nl);
        (X=:=1, Y=:=0, Z=:=0 -> write('You are not fighting right now. You cannot use this option!'),nl);
        (X=:=1, Y=:=1, Z=:=1 -> me(Name1,Hp1,_,Type1,Skill1,_),
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
        activateSkill(Skill1))).

activateSkill(NameSkill) :-
        ((NameSkill==eruption) -> activateSkillToEnemy(NameSkill),activateSkillToMe(NameSkill));
        ((NameSkill==hydropump;
        NameSkill==earthquake;
        NameSkill==bolt) -> activateSkillToEnemy(NameSkill);
        (NameSkill==roost;
        NameSkill==absorb) -> activateSkillToMe(NameSkill)).

activateSkillToEnemy(NameSkill) :-
        write('You used '),
        write(NameSkill),
        write(' skill. Show it what you got!'),nl,
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        ((NameSkill==flamethower -> NewHp2 is Hp2-70);
        (NameSkill==woodhammer -> NewHp2 is Hp2-65);
        (NameSkill==tidalwave -> NewHp2 is Hp2-60);
        (NameSkill==hurricane -> NewHp2 is Hp2-60);
        (NameSkill==bolt -> NewHp2 is Hp2-90);
        (NameSkill==fissure -> NewHp2 is Hp2-75);
        (NameSkill==earthquake -> NewHp2 is Hp2-75)),
        (NewHp2 =< 0 -> Dead is 0,
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(Dead),nl,
        write('Type : '),write(Type2),nl,
        write('Enemy took heavy damage from your Tokemon!'),nl,
        write('Congratulations, you have defeated your enemy!'),nl,nl,
        assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
        write('Enemy took heavy damage from your Tokemon!'),nl,
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(NewHp2),nl,
        write('Type : '),write(Type2),nl,nl,
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2))).

activateSkillToEnemy(NameSkill) :-
        write('You used '),
        write(NameSkill),
        write(' skill. Show it what you got!'),nl,
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        ((NameSkill==hydropump -> NewHp2 is Hp2-2*Dmg1, NewDmg1 is Dmg1*0.6);
        (NameSkill==leafstorm -> NewHp2 is Hp2-2*Dmg1, NewDmg1 is Dmg1*0.6);
        (NameSkill==blastburn -> NewHp2 is Hp2-2*Dmg1, NewDmg1 is Dmg1*0.6);
        (NameSkill==overheat -> NewHp2 is Hp2-4*Dmg1, NewDmg1 is Dmg1*0.5);
        (NameSkill==eruption -> NewHp2 is Hp2-110, NewDmg1 is Dmg1*0.6);
        (NameSkill==absolutezero -> NewHp2 is Hp2-80, NewDmg1 is Dmg1*0.8);
        (NameSkill==discharge -> NewHp2 is Hp2-90, NewDmg1 is Dmg1*0.75);
        (NameSkill==superpower -> NewHp2 is Hp2-4*Dmg1, NewDmg1 is Dmg1*0.6);
        (NameSkill==skyattack -> NewHp2 is Hp2-110, NewDmg1 is Dmg1*0.5);
        (NameSkill==aerialace -> NewHp2 is Hp2-50, NewDmg1 is Dmg1*1.2)),
        (NewHp2 =< 0 -> Dead is 0,
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(Dead),nl,
        write('Type : '),write(Type2),nl,
        write('Enemy took heavy damage from your Tokemon!'),nl,
        write('Congratulations, you have defeated your enemy!'),nl,nl,
        assertz(me(Name1,Hp1,NewDmg1,Type1,Skill1,Id1)),
        assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
        write('Enemy took heavy damage from your Tokemon!'),nl,
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(NewHp2),nl,
        write('Type : '),write(Type2),nl,nl,
        write('But, your tokemon damage is reduced!'),nl,
        assertz(me(Name1,Hp1,NewDmg1,Type1,Skill1,Id1)),
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2))).

activateSkillToMe(NameSkill) :-
        write('You chose to use '),
        write(NameSkill),
        write(' skill. Smart choice!'), nl,
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        ((NameSkill==leechseed -> NewHp2 is Hp2-25, NewHp1 is Hp1+15);
        (NameSkill==gigadrain -> NewHp2 is Hp2-40,NewHp1 is Hp1+8);
        (NameSkill==sacredfire -> NewHp2 is Hp2-2.5*Dmg1,NewHp1 is Hp1+5);
        (NameSkill==thorhammer -> NewHp2 is Hp2-110,NewHp1 is Hp1-30);
        (NameSkill==roost -> NewHp2 is Hp2,NewHp1 is Hp1+20);
        (NameSkill==absorb -> NewHp2 is Hp2-Dmg1, NewHp1 is Hp1+Dmg1)),
        write('You are healed and cause some damage to the enemy'),nl,
        write('My Tokemon - '), write(Name1), nl,
        write('Health : '), write(NewHp1), nl,
        write('Type : '), write(Type1), nl, nl,
        write('Enemy - '), write(Name2), nl,
        write('Health : '), write(NewHp2), nl,
        write('Type : '), write(Type1), nl, nl,
        assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1)),
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2));
        write('You have no skill to use.'),nl.

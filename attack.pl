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

/* Rules-Rules */
/* fight -> digunakan untuk memulai pertarungan dengan tokemon enemy */
fight :-
        command(initstart,A),
        command(inittokemonappear,B),
        (       /* Kondisi belum pernah memulai permainan */      
                (A=:=0 -> 
                        write('You even have not started the game yet.'),nl);

                /* Kondisi belum pernah bertemu dengan tokemon */
                (A=:=1, B=:=0 -> 
                        write('You have not met any Tokemon!'));

                /* Kondisi sudah mulai permainan fight dengan tokemon */
                (A=:=1, B=:=1 -> 
                        write('Choose your Tokemon!'),nl,
                        retract(command(initfight,0)), assertz(command(initfight,1)),
                        nl,write('Available Tokemons: '),nl,
                        findall(X,inventory(X,_,_,_,_,_),Result),
                        printinventory(Result))
        ).

/* attack -> digunakan untuk mengeksekusi aksi attack dari me ke enemy dengan beberapa ketentuan tertentu */
/* Jika fakta (increasedamage(Type1,Type2)) ada, maka damage me dikalikan dengan 1.5 */
/* Jika fakta (decreasedamage(Type1,Type2)) ada, maka damage me dikalikan dengan 0.5 */
/* Jika tidak ada kedua fakta tersebut, maka damage me dikalikan dengan 1.5 */
attack :-
        command(initstart,X),
        command(initfight,Y),
        command(initpick,Z),
        command(initenemydead,A),

        (
                (X=:=0 -> 
                        write('You even have not started the game yet.'),nl);
                (X=:=1, Y=:=1, Z=:=0 -> 
                        write('You must choose a Tokemon first!'),nl);
                (X=:=1, Y=:=0 -> 
                        write('You are not fighting right now. You cannot use this option!'),nl);
                (X=:=1, Y=:=1, Z=:=1 -> 
                        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
                        write('My Tokemon - '), write(Name1),nl,
                        write('Health : '), write(Hp1),nl,
                        write('Type : '),write(Type1),nl,nl,
                        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
                        write('Enemy - '),write(Name2),nl,
                        write('Health : '),write(Hp2),nl,
                        write('Type : '),write(Type2),nl,nl,
        
                (       
                        (increaseDamage(Type1,Type2) -> write('You attacked with double damage!'),nl,nl,NewHp2 is Hp2-2*Dmg1);
                        (decreaseDamage(Type1,Type2) -> write('You attacked with half damage!'),nl,nl,NewHp2 is Hp2-Dmg1/2);
                        (write('You attacked with normal damage!'),nl,nl,NewHp2 is Hp2-Dmg1)
                ),

                assertz(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
                (
                        (NewHp2 =< 0) -> Dead is 0,
                                write('Congratulations, you have defeated your enemy!'),nl,
                                write('Enemy - '),write(Name2),nl,
                                write('Health : '),write(Dead),nl,
                                write('Type : '),write(Type2),nl,nl,
                                retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
                                assertz(inventory(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
                                retract(command(initfight,1)), assertz(command(initfight,0)),
                                retract(command(inittokemonappear,1)),assertz(command(inittokemonappear,0)),
                                resetSkill,
                                write('Do you want to pick this tokemon? It will replace your oldest tokemon you have!'),nl,
                                read(Response),nl,
                                ((Response == yes; Response == y) -> 
                                retract(command(initenemydead,0)),assertz(command(initenemydead,1)),capture;
                                retract(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));

                                (write('Enemy - '),write(Name2),nl,
                                write('Health : '),write(NewHp2),nl,
                                write('Type : '),write(Type2),nl,nl,
                                assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)))
                        )
                )
        ).

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
        (
                (X=:=0 -> 
                        write('You even have not started the game yet.'),nl);
                (X=:=1, Y=:=0, Z=:=0 -> 
                        write('You are not fighting right now. You cannot use this option!'),nl);
                (X=:=1, Y=:=1, Z=:=1 -> 
                        me(Name1,Hp1,_,Type1,Skill1,_),
                        write('My Tokemon - '), write(Name1),nl,
                        write('Health : '), write(Hp1),nl,
                        write('Type : '),write(Type1),nl,
                        (
                                available(Skill1) -> 
                                        write('Available skill : '),
                                        write(Skill1),nl,nl;
                                /* not(available(Skill1)) */      
                                        write('Available skill : - '),nl,nl
                        ),
                        enemy(Name2,Hp2,_,Type2,_,_),
                        write('Enemy - '),write(Name2),nl,
                        write('Health : '),write(Hp2),nl,
                        write('Type : '),write(Type2),nl,nl,
                        available(Skill1),activateSkill(Skill1)
                )
        ),!.
        
activateSkill(NameSkill) :-
        checkValidity1(NameSkill),
        write('You used '),
        write(NameSkill),
        write(' skill. Show it what you got!'),nl,
        retract(available(NameSkill)),
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        (
                (NameSkill==flamethower -> NewHp2 is Hp2-70);
                (NameSkill==woodhammer -> NewHp2 is Hp2-65);
                (NameSkill==tidalwave -> NewHp2 is Hp2-60);
                (NameSkill==hurricane -> NewHp2 is Hp2-60);
                (NameSkill==bolt -> NewHp2 is Hp2-90);
                (NameSkill==fissure -> NewHp2 is Hp2-75);
                (NameSkill==earthquake -> NewHp2 is Hp2-75)
        ),
        (
                NewHp2 =< 0 -> 
                        Dead is 0,
                        write('Enemy - '),write(Name2),nl,
                        write('Health : '),write(Dead),nl,
                        write('Type : '),write(Type2),nl,
                        write('Enemy took heavy damage from your Tokemon!'),nl,
                        enemyIsDown;
                /* NewHp2 > 0 */
                        write('Enemy took heavy damage from your Tokemon!'),nl,
                        write('Enemy - '),write(Name2),nl,
                        write('Health : '),write(NewHp2),nl,
                        write('Type : '),write(Type2),nl,nl,
                        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2))
        ).

activateSkill(NameSkill) :-
        checkValidity2(NameSkill),
        write('You used '),
        write(NameSkill),
        write(' skill. Show it what you got!'),nl,
        retract(available(NameSkill)),
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
        retract(initfight(1)), assertz(initfight(0)),
        assertz(inventory(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        retract(command(initfight,1)), assertz(command(initfight,0)),
        retract(command(inittokemonappear,1)),assertz(command(inittokemonappear,0)),
        resetSkill,
        write('Congratulations, you have defeated your enemy!'),nl,
        write('Do you want to pick this tokemon? It will replace your oldest tokemon you have!'),nl,
        read(Response),nl,
        ((Response == yes; Response == y) -> capture;
        retract(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));
        write('Enemy took heavy damage from your Tokemon!'),nl,
        write('Enemy - '),write(Name2),nl,
        write('Health : '),write(NewHp2),nl,
        write('Type : '),write(Type2),nl,nl,
        write('But, your tokemon damage is reduced!'),nl,
        assertz(me(Name1,Hp1,NewDmg1,Type1,Skill1,Id1)),
        assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2))).

activateSkill(NameSkill) :-
        checkValidity3(NameSkill),
        write('You chose to use '),
        write(NameSkill),
        write(' skill. Smart choice!'), nl,
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
        retract(available(NameSkill)),
        tokemon(_,HpDB,_,_,_,Id1),
        ((NameSkill==leechseed -> NewHp2 is Hp2-25, NewHp1 is Hp1+15);
        (NameSkill==gigadrain -> NewHp2 is Hp2-40,NewHp1 is Hp1+8);
        (NameSkill==sacredfire -> NewHp2 is Hp2-2.5*Dmg1,NewHp1 is Hp1+5);
        (NameSkill==thorhammer -> NewHp2 is Hp2-110,NewHp1 is Hp1-30);
        (NameSkill==roost -> NewHp2 is Hp2,NewHp1 is Hp1+20);
        (NameSkill==absorb -> NewHp2 is Hp2-Dmg1, NewHp1 is Hp1+Dmg1)),
        (NewHp1 > HpDB, NewHp2 =< 0 -> Dead is 0, write('Your health is full'),nl,write('And your enemy is dead'),nl,
        write('My Tokemon - '), write(Name1), nl,
        write('Health : '), write(HpDB), nl,
        write('Type : '), write(Type1), nl, nl,
        write('Enemy - '), write(Name2), nl,
        write('Health : '), write(Dead), nl,
        write('Type : '), write(Type1), nl,
        retract(initfight(1)), assertz(initfight(0)),
        assertz(inventory(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        resetSkill,
        retract(command(inittokemonappear,1)),assertz(command(inittokemonappear,0)),
        write('Congratulations, you have defeated your enemy!'),nl,
        write('Do you want to pick this tokemon? It will replace your oldest tokemon you have!'),nl,
        read(Response),nl,
        ((Response == yes; Response == y) -> 
        assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1)),
        retract(command(initenemydead,0)),assertz(command(initenemydead,1)),capture;
        retract(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));
        NewHp1 > HpDB -> write('Your health is full'),nl,
        write('My Tokemon - '), write(Name1), nl,
        write('Health : '), write(HpDB), nl,
        write('Type : '), write(Type1), nl, nl,
        write('Enemy - '), write(Name2), nl,
        write('Health : '), write(NewHp2), nl,
        write('Type : '), write(Type1), nl,nl,
        assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1)),
        assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)));
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

resetSkill :-
        retract(command(initpick,1)),assertz(command(initpick,0)),
        retractall(available),
        assertz(available(hydropump)),
        assertz(available(leafstorm)),
        assertz(available(blastburn)),
        assertz(available(flamethower)),
        assertz(available(overheat)),
        assertz(available(sacredfire)),
        assertz(available(eruption)),
        assertz(available(woodhammer)),
        assertz(available(absorb)),
        assertz(available(leechseed)),
        assertz(available(gigadrain)),
        assertz(available(tidalwave)),
        assertz(available(hurricane)),
        assertz(available(absolutezero)),
        assertz(available(thorhammer)),
        assertz(available(discharge)),
        assertz(available(bolt)),
        assertz(available(fissure)),
        assertz(available(earthquake)),
        assertz(available(superpower)),
        assertz(available(roost)),
        assertz(available(skyattack)),
        assertz(available(aerialace)).

checkValidity1(NameSkill) :-
        (
                NameSkill==flamethower;
                NameSkill==woodhammer;
                NameSkill==tidalwave;
                NameSkill==hurricane;
                NameSkill==bolt;
                NameSkill==fissure;
                NameSkill==earthquake      
        ).

checkValidity2(NameSkill) :-
        (
                NameSkill==hydropump;
                NameSkill==leafstorm ;
                NameSkill==blastburn ;
                NameSkill==overheat  ;
                NameSkill==eruption  ;
                NameSkill==absolutezero;
                NameSkill==discharge ;
                NameSkill==superpower;
                NameSkill==skyattack ;
                NameSkill==aerialace
        ).

checkValidity3(NameSkill) :-
        (
                NameSkill==leechseed ;
                NameSkill==gigadrain ;
                NameSkill==sacredfire ;
                NameSkill==thorhammer ;
                NameSkill==roost ;
                NameSkill==absorb
        ).

enemyIsDown :-
        /* Memasukkan Tokemon dari list me kembali ke inventory */
        retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
        assertz(inventory(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),

        /* Mengembalikan state ke state bukan fight, dan state tidak ada tokemon */
        retract(command(initfight,1)), 
        assertz(command(initfight,0)),
        retract(command(inittokemonappear,1)),
        assertz(command(inittokemonappear,0)),

        /* Reset semua available skill yang sudah diretract sebelumnya */
        resetSkill,
        write('Congratulations, you have defeated your enemy!'),nl,
        write('Do you want to pick this tokemon? It will replace your oldest tokemon you have!'),nl,
        
        /* Membaca response berupa input dari pengguna untuk menentukan pilihan capture tokemon */
        read(Response),nl,
        ((Response == yes; Response == y) -> 
        retract(command(initenemydead,0)),assertz(command(initenemydead,1)),capture;
        retract(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2)))
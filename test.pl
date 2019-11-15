/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul Test untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* TEST */

:- dynamic(legendaryleft/1).
legendaryleft(4).

positionX(1).
positionX(2).
positionX(3).
positionX(4).
positionX(5).
positionX(6).
positionX(7).
positionX(8).
positionX(9).
positionX(10).
positionX(11).
positionX(12).
positionX(13).
positionX(14).
positionX(15).

positionY(1).
positionY(2).
positionY(3).
positionY(4).
positionY(5).
positionY(6).
positionY(7).
positionY(8).
positionY(9).
positionY(10).
positionY(11).
positionY(12).
positionY(13).
positionY(14).
positionY(15).

run(1).
run(2).
run(3).
run(4).
run(5).

/* Deklarasi Rules */
/* randomRun untuk generate kesempatan untuk run */
randomRun(LowerBound,UpperBound,R) :-
    random(LowerBound,UpperBound,R),
    run(R),
    R >= LowerBound,
    R =< UpperBound, !.

/* randomId untuk generate tokemon lawan yang muncul */
randomId(LowerBound,UpperBound,R):-
    random(LowerBound,UpperBound,R),
    tokemon(_,_,_,_,_,R),
    R >= LowerBound,
    R =< UpperBound,!.

/* checkPerimeter untuk mengecek tokemon yang muncul */
checkPerimeter :-
    (isLegendaryAppear);
    (isTokemonAppear);
    (\+isLegendaryAppear,\+isTokemonAppear).

fightLegend(Id) :-
    tokemon(Name,Hp,Dmg,Type,Skill,Id),
    assertz(enemy(Name,Hp,Dmg,Type,Skill,Id)).

/* fightNormal untuk assert Normal ke dynamic predicate enemy */
fightNormal(Id) :-
    tokemon(Name,Hp,Dmg,Type,Skill,Id),
    assertz(enemy(Name,Hp,Dmg,Type,Skill,Id)).

/* isLegendaryAppear adalah mekanisme jika bertemu dengan Legendary Tokemon */
isLegendaryAppear :-
    command(initfight,A),
    (
        /* Jika dalam keadaan akan bertarung */
        (A=:=0 -> 
            playerposition(Xpos,Ypos),
            /* Tidak berada di dalam gym */
            \+gym(Xpos,Ypos),
            /* Peluang = 10% */
            random(1,101,X),
            X > 90,
            randomId(1,4,Id),
            \+temp(Name,_,_,_,_,Id),
            tokemon(Name,_,_,_,_,Id),nl,
            write('Oh No! Legendary Tokemon Appeared!'),nl,
            write('It is an '), write(Name), nl,
            retract(command(inittokemonappear,0)),assertz(command(inittokemonappear,1)),
            retract(command(initlegendaryappear,0)),assertz(command(initlegendaryappear,1)),
            write('Fight or Run?'),nl,
            read(Response),nl,
            ((Response == run) -> run;
            (Response == fight) -> write('What a legend! Here you go'),nl,fightLegend(Id),fight;
            write('Please input the right response!')),nl,!)
    ).

/* isTokemonAppear adalah mekanisme jika bertemu dengan Normal Tokemon */
isTokemonAppear :-
    /* Jika tidak ada Legendary Tokemon yang muncul */
    \+isLegendaryAppear,
    playerposition(Xpos,Ypos),
    /* Tidak berada di dalam gym */
    \+gym(Xpos,Ypos),
    random(1,101,X),
    X >= 50,
    X =< 90,
    randomId(4,24,Id),
    \+temp(Name,_,_,_,_,Id),
    tokemon(Name,_,_,_,_,Id),nl,
    write('A Wild Tokemon Appeared!'),nl,
    write('It is an '), write(Name), nl,
    retract(command(inittokemonappear,0)),assertz(command(inittokemonappear,1)),
    retract(command(initnormalappear,0)),assertz(command(initnormalappear,1)),
    write('Fight or Run?'),nl,
    read(Response),nl,
    ((Response == run) -> run;
    (Response == fight) -> write('What a legend! Here you go'),nl,fightNormal(Id),fight;
    write('Please input the right response!'),nl),!.

run :-
    command(initstart,St),
    command(initfight,Fi),
    command(inittokemonappear,Toa),
    command(initlegendaryappear,La),
    command(initnormalappear,Na),   
    ((St=:=0 -> write('You even have not started the game yet.'),nl);
    (St=:=1, Fi=:=1, Toa=:=1 -> write('You cannot run while you are fighting!'),nl);
    (St=:=1, Fi=:=0, Toa=:=1 , La=:=1-> isLegendaryRun(Id));
    (St=:=1, Fi=:=0, Toa=:=1, Na=:=1 -> isTokemonRun(Id))).

/* isTokemonRun adalah mekanisme jika memilih run dari Normal Tokemon */
isTokemonRun(Id) :-
    randomRun(1,3,R),
    /* Peluangnya 1:2 */
    (
        /* Mekanisme jika berhasil run */
        (R =:= 1 -> 
            write('Lucky you, you successfully escaped the wild Tokemon!'),
            retract(command(inittokemonappear,1)), assertz(command(inittokemonappear,0)),
            retract(command(initnormalappear,1)), assertz(command(initnormalappear,0))
        );
        /* Mekanisme jika gagal run */
            write('Poor you, you had to fight the wild Tokemon!'),nl,
            fightNormal(Id),
            fight
    ),!.

/* isLegendaryRun adalah mekanisme jika memilih run dari Legendary Tokemon */
isLegendaryRun(Id) :-
    randomRun(1,6,R),
    /* Peluangnya 1:5 */
    (
        /* Mekanisme jika berhasil run */
        (R =:= 1 -> 
            write('Lucky you, you successfully escaped the Legendary Tokemon!'),
            retract(command(inittokemonappear,1)), assertz(command(inittokemonappear,0)),
            retract(command(initlegendaryappear,1)), assertz(command(initlegendaryappear,1))
        );
        /* Mekanisme jika gagal run */
            write('Poor you, you had to fight the Legendary Tokemon!'),nl,
            fightLegend(Id),
            fight
    ),!.

/* FILE : PROBABILITY.PL */

/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul Test untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* PROBABILITY */
:- dynamic(activeId/1).

:- dynamic(answer/1).
answer(nil).

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

/* wronginput digunakan untuk mengecek apakah response yang dimasukkan benar */
wronginput :-
    write('Fight or run?'),nl,
    read(Response),nl,
    (
        (
            (Response==fight; Response==run) -> 
                retract(answer(nil)),assertz(answer(Response))
        ); 
        (write('Please input the right response!'),nl,wronginput)
    ).

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
            assertz(activeId(Id)),
            write('Oh No! Legendary Tokemon Appears!'),nl,
            write('It is an '), write(Name), nl,
            retract(command(inittokemonappear,0)),assertz(command(inittokemonappear,1)),
            retract(command(initlegendaryappear,0)),assertz(command(initlegendaryappear,1)),
            wronginput,
            answer(Re),
            ((Re == run) -> run;
            (Re == fight) -> write('What a legend! Here you go.'),nl,
            retract(command(initlegendaryappear,1)), assertz(command(initlegendaryappear,0)),
            fightLegend(Id),fight,!),
            retract(answer(Re)),assertz(answer(nil))
        )
    ).

/* isTokemonAppear adalah mekanisme jika bertemu dengan Normal Tokemon */
isTokemonAppear :-
    command(initfight,A),
    (A=:=0 -> 
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
    assertz(activeId(Id)),
    write('A Wild Tokemon Appears!'),nl,
    write('It is an '), write(Name), nl,
    retract(command(inittokemonappear,0)),assertz(command(inittokemonappear,1)),
    retract(command(initnormalappear,0)),assertz(command(initnormalappear,1)),
    wronginput,
    answer(Re),
    ((Re == run -> run);
    (Re == fight -> write('What a legend! Here you go.'),nl,
    retract(command(initnormalappear,1)), assertz(command(initnormalappear,0)),
    fightNormal(Id),fight,!)),
    retract(answer(Re)),assertz(answer(nil))
    ).

run :-
    activeId(Id),
    command(initstart,St),
    command(initfight,Fi),
    command(inittokemonappear,Toa),
    command(initlegendaryappear,La),
    command(initnormalappear,Na),   
    (
        (St=:=0 -> write('You even have not started the game yet.'),nl);
        (St=:=1, Fi=:=1, Toa=:=1 -> write('You cannot run while you are fighting!'),nl);
        (St=:=1, Fi=:=0, Toa=:=1 , La=:=1 -> isLegendaryRun(Id));
        (St=:=1, Fi=:=0, Toa=:=1, Na=:=1 -> isTokemonRun(Id))
    ).

/* isTokemonRun adalah mekanisme jika memilih run dari Normal Tokemon */
isTokemonRun(Id) :-
    retract(command(initnormalappear,1)), assertz(command(initnormalappear,0)),
    randomRun(1,3,R),
    /* Peluangnya 1:2 */
    (
        /* Mekanisme jika berhasil run */
        (R =:= 1 -> 
            retract(activeId(Id)),
            write('Lucky you, you successfully escape the wild Tokemon!'),
            retract(command(inittokemonappear,1)), assertz(command(inittokemonappear,0))
        );
        /* Mekanisme jika gagal run */
            write('Poor you, you have to fight the wild Tokemon!'),nl,
            fightNormal(Id),
            fight
    ),!.

/* isLegendaryRun adalah mekanisme jika memilih run dari Legendary Tokemon */
isLegendaryRun(Id) :-
    retract(command(initlegendaryappear,1)), assertz(command(initlegendaryappear,0)),
    randomRun(1,6,R),
    /* Peluangnya 1:5 */
    (
        /* Mekanisme jika berhasil run */
        (R =:= 1 -> 
            retract(activeId(Id)),
            write('Lucky you, you successfully escape the Legendary Tokemon!'),
            retract(command(inittokemonappear,1)), assertz(command(inittokemonappear,0))
        );
        /* Mekanisme jika gagal run */
            write('Poor you, you have to fight the Legendary Tokemon!'),nl,
            fightLegend(Id),
            fight
    ),!.

/* Deklarasi Fakta */
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

command_loop:-
        write('Welcome to Nani Search'), nl,
        repeat,
        write('>nani> '),
        read(X),
        do(X), nl,
        end_condition(X).
        end_condition(end).

end_condition(X) :- 
        have(X),!,
        write('Congratulations').

do(X):- have(X),!.
do(end).
do(_):- write('Invalid Command').

have(X):- X==nani,!.

/* fightLegend untuk assert Legendary ke dynamic predicate enemy */
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
            tokemon(Name,_,_,_,_,Id),nl,
            write('Oh No! Legendary Tokemon Appeared!'),nl,
            write('It is an '), write(Name), nl,
            retract(command(inittokemonappear,0)),assertz(command(inittokemonappear,1)),
            write('Fight or Run?'),nl,
            read(Response),nl,
            ((Response == run) -> isLegendaryRun(Id);
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
    random(1,21,X),
    X >= 1,
    X =< 7,
    randomId(4,24,Id),
    tokemon(Name,_,_,_,_,Id),nl,
    write('A Wild Tokemon Appeared!'),nl,
    write('It is an '), write(Name), nl,
    retract(command(inittokemonappear,0)),assertz(command(inittokemonappear,1)),
    write('Fight or Run?'),nl,
    read(Response),nl,
    ((Response == run) -> isTokemonRun(Id);
    (Response == fight) -> write('What a legend! Here you go'),nl,fightNormal(Id),fight;
    write('Please input the right response!'),nl),!.

/* isTokemonRun adalah mekanisme jika memilih run dari Normal Tokemon */
isTokemonRun(Id) :-
    randomRun(1,3,R),
    /* Peluangnya 1:2 */
    (
        /* Mekanisme jika berhasil run */
        (R =:= 1 -> 
            write('Lucky you, you successfully escaped the wild Tokemon!'),
            retract(command(inittokemonappear,1)),
            assertz(command(inittokemonappear,0))
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
            retract(command(inittokemonappear,1)),
            assertz(command(inittokemonappear,0))
        );
        /* Mekanisme jika gagal run */
            write('Poor you, you had to fight the Legendary Tokemon!'),nl,
            fightLegend(Id),
            fight
    ),!.

:- include('main.pl').

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

randomRun(LowerBound,UpperBound,R) :-
    random(LowerBound,UpperBound,R),
    run(R),
    R >= LowerBound,
    R =< UpperBound, !.

randomId(LowerBound,UpperBound,R):-
    random(LowerBound,UpperBound,R),
    tokemon(_,_,_,_,_,R),
    R >= LowerBound,
    R =< UpperBound,!.

checkPerimeter :-
    isLegendaryAppear;
    isTokemonAppear.

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

isLegendaryAppear :-
    random(1,10,X),
    X =:= 5,
    randomId(1,4,Id),
    tokemon(Name,_,_,_,_,Id),nl,
    write('Oh No! Legendary Tokemon Appeared!'),nl,
    write('It is an '), write(Name), nl,
    write('Fight or Run?'),nl,
    read(Response),nl,
    ((Response == run) -> isLegendaryRun,nl;
    (Response == fight) -> write('What a legend! Here you go'),nl;
    write('Please input the right response!')),nl,!.

isTokemonAppear :-
    random(1,21,X),
    X >= 1,
    X =< 7,
    randomId(4,24,Id),
    tokemon(Name,_,_,_,_,Id),nl,
    write('A Wild Tokemon Appeared!'),nl,
    write('It is an '), write(Name), nl,
    write('Fight or Run?'),nl,
    read(Response),nl,
    ((Response == run) -> isTokemonRun,nl;
    (Response == fight) -> write('What a legend! Here you go'),nl;
    write('Please input the right response!'),nl),!.

isTokemonRun :-
    randomRun(1,3,R),
    ((R =:= 1 -> write('Lucky you, you successfully escaped the wild Tokemon!'),nl,
    retract(fightOrNo(1)), assertz(fightOrNo(0)));
    write('Poor you, you had to fight the wild Tokemon!'),nl),!.

isLegendaryRun :-
    randomRun(1,6,R),
    ((R =:= 1 -> write('Lucky you, you successfully escaped the Legendary Tokemon!'),nl.
    retract(fightOrNo(1)),assertz(fightOrNo(0)));
    write('Poor you, you had to fight the Legendary Tokemon!'),nl),!.
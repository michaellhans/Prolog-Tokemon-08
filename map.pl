/* Map */
isAbove(X,Y) :-    
    Y =:= 0,!.
    
isDown(_,Y) :-
    Y =:= 16,!.

isLeft(X,_) :-
    X =:= 0,!.

isRight(X,_) :-
    X =:= 16,!.

area(X,Y) :-
    X =\= 0,
    X =\= 16,
    Y =\= 0,
    Y =\= 16,!.

isMax(X,Y) :-
    X > 16,
    Y > 16,!.

printMap(X,Y):-
    isAbove(X,Y),
    write('X'),
    NewX is X,
    ((NewX =:= 16 -> nl,printMap(0,Y+1));
    printMap(X+1,Y)).

printMap(X,Y):-
    isDown(X,Y),
    write('X'),
    ((X =:= 16 -> nl,!);
    printMap(X+1,Y)).

printMap(X,Y):-
    isRight(X,Y),
    write('X'),nl,
    printMap(0,Y+1).

printMap(X,Y):-
    isLeft(X,Y),
    write('X'),
    printMap(X+1,Y).

printMap(X,Y):-
    area(X,Y),
    write('-'),
    printMap(X+1,Y).

showMap :- printMap(0,0).

/* Movement */
isfence(X,Y) :-
    (
        X =:= 0;
        X =:= 15;
        Y =:= 0;
        Y =:= 15
    ).

n :- 
    retract(playerposition(X,Y)),
    NewX is X,
    NewY is Y+1,
    ((\+isfence(NewX,NewY) -> write('You move to the north.'),
    assertz(playerposition(NewX,NewY)),!);
    write('Cannot move! You are near the fence.'), 
    assertz(playerposition(X,Y))).

s :-
    retract(playerposition(X,Y)),
    NewX is X,
    NewY is Y-1,
    ((\+isfence(NewX,NewY) -> write('You move to the south.'),
    assertz(playerposition(NewX,NewY)),!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))).

e :-
    retract(playerposition(X,Y)),
    NewX is X+1,
    NewY is Y,
    ((\+isfence(NewX,NewY) -> write('You move to the east.'),
    assertz(playerposition(NewX,NewY)),!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))).

w :-
    retract(playerposition(X,Y)),
    NewX is X-1,
    NewY is Y,
    ((\+isfence(NewX,NewY) -> write('You move to the west.'),
    assertz(playerposition(NewX,NewY)),!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))).
/* Map */

fence(2,2).
fence(8,2).
fence(8,3).
fence(8,4).
fence(9,4).
fence(10,4).
fence(11,4).
fence(3,10).
fence(4,10).
fence(5,10).
fence(6,10).
fence(7,10).
fence(5,6).
fence(5,7).
fence(5,8).
fence(10,7).
fence(10,8).
fence(13,13).
fence(13,14).
gym(6,13).

isAbove(_,Y) :-    
    Y =:= 0,!.
    
isDown(_,Y) :-
    Y =:= 16,!.

isLeft(X,_) :-
    X =:= 0,!.

isRight(X,_) :-
    X =:= 16,!.

area(X,Y) :-
	\+playerposition(X,Y),
	\+fence(X,Y),
    \+gym(X,Y),
    X =\= 0,
    X =\= 16,
    Y =\= 0,
    Y =\= 16,!.

isMax(X,Y) :-
    X > 16,
    Y > 16,!.
    
printMap(X,Y):-
    isAbove(X,Y),!,
    write('X'),
    NewY is Y+1,
    ((X =:= 16 -> nl,printMap(0,NewY),!);
    NewX is X+1,
    printMap(NewX,Y)).

printMap(X,Y):-
    isDown(X,Y),!,
    write('X'),
    ((X =:= 16 -> nl,!);
    NewX is X+1,
    printMap(NewX,Y)).

printMap(X,Y):-
    isRight(X,Y),!,
    write('X'),nl,
    NewY is Y+1,
    Reset is X-X,
    printMap(Reset,NewY).

printMap(X,Y):-
    isLeft(X,Y),!,
    write('X'),
    NewX is X+1,
    printMap(NewX,Y).
    
printMap(X,Y):-
    playerposition(X,Y),!,
    write('P'),
    NewX is X+1,
    printMap(NewX,Y).
    
printMap(X,Y):-
	fence(X,Y),!,
	write('X'),
    NewX is X+1,
	printMap(NewX,Y).

printMap(X,Y):-
	gym(X,Y),!,
	write('G'),
    NewX is X+1,
	printMap(NewX,Y).

printMap(X,Y):-
    area(X,Y),!,
    write('-'),
    NewX is X+1,
    printMap(NewX,Y).

map :- 
    command(initstart,X),
    command(initfight,Y),
    ((X=:=0 -> write('You even have not started the gamet yet.'),nl);
    (X=:=1, Y=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (X=:=1, Y=:=0 -> printMap(0,0))).

/* Movement */

isGym(X,Y) :-
    (
        gym(X,Y),
        X =:= 6,
        Y =:= 13
    ).

isfence(X,Y) :-
    (
        fence(X,Y);
        X =:= 0;
        X =:= 16;
        Y =:= 0;
        Y =:= 16
    ).

w :- 
    command(initstart,A),
    command(initfight,B),
    ((A=:=0 -> write('You even have not started the game yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0 -> retract(playerposition(X,Y)),
    NewX is X,
    NewY is Y-1,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the north.'),!,
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    (write('Cannot move! You are near the fence.'), 
    assertz(playerposition(X,Y)))))).

s :-
    command(initstart,A),
    command(initfight,B),
    ((A=:=0 -> write('You even have not started the game yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0 -> retract(playerposition(X,Y)),
    NewX is X,
    NewY is Y+1,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the south.'),
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))))).

d :-
    command(initstart,A),
    command(initfight,B),
    ((A=:=0 -> write('You even have not started the gamet yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0 -> retract(playerposition(X,Y)),
    NewX is X+1,
    NewY is Y,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the east.'),
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))))).

a :-
    command(initstart,A),
    command(initfight,B),
    ((A=:=0 -> write('You even have not started the game yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0 -> retract(playerposition(X,Y)),
    NewX is X-1,
    NewY is Y,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the west.'),
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))))).


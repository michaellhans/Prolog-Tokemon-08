/* dynamicinventory dan dynamicenemy */
:- dynamic(inventory/6).
inventory(refflesia,115,20,leaves,woodhammer,8).
inventory(sijagokuning,95,25,fire,eruption,7).

:- dynamic(listenemy/6).
listenemy(ligator,630,40,water,hydropump,1).
listenemy(camelia,580,57,leaves,leafstorm,2).
listenemy(phoenix,500,70,fire,blastburn,3).

/* printinventory */
printinventory([]).
printinventory([H|T]) :-
        write(H),nl,
        inventory(H,Health,_,Type,_,_),
        write('Health   : '),write(Health),nl,
        write('Type     : '),write(Type),nl,nl,
        printinventory(T).

/* enemy */
printenemy([]).
printenemy([H|T]) :-
        write(H),nl,
        listenemy(H,Health,_,Type,_,_),
        write('Health   : '),write(Health),nl,
        write('Type     : '),write(Type),nl,nl,
        printenemy(T).

/* status */
status :-
        command(initstart,A),
        ((A=:=0 -> write('You even have not started the game yet.'),nl);
        (A=:=1 ->
        findall(X,inventory(X,_,_,_,_,_),Result),
        write('Your Tokemon:'),nl,
        printinventory(Result),
        findall(X,listenemy(X,_,_,_,_,_),Result1),
        write('Your Enemy:'),nl,
        printenemy(Result1))).

healinventory([H|T]) :-
        write(H),nl,
        inventory(H,Health,_,Type,_,_),
        retract(inventory(H,Health,Damage,Type,Skill,Id)),
        tokemon(H,Hp1,Dmg1,Type1,Skill1,Id1),
        NewHealth is Hp1,
        write('Health   : '),write(NewHealth),nl,
        write('Type     : '),write(Type),nl,nl,
        asserta(inventory(H,NewHealth,Damage,Type,Skill,Id)),
        healinventory(T).

heal :-
        command(initstart,A),
        ((A=:=0 -> write('You even have not started the game yet.'),nl);
        (A=:=1 -> 
        playerposition(PosX,PosY),
        (\+gym(PosX,PosY) -> write('You cannot heal your tokemon outside Gym!'),nl;
        command(initheal,X),
        ((X =:= 0 -> retract(command(initheal,0)),
        assertz(command(initheal,1)),
        findall(X,inventory(X,_,_,_,_,_),Result),
        write('You use your only one gym ticket!'),nl,
        write('All of your tokemons have been recovered!'),nl,
        write('Your Tokemon:'),nl,
        healinventory(Result));
        (X=:=1 -> write('You do not have a ticket to the Gym!'),nl))))).
        
/* Kondisi inventory */
:- dynamic(isfull/1).
isfull(2).

capture :-
        command(initstart,A),
        command(initenemydead,B),
        ((A=:=0 -> write('You even have not started the game yet.'),nl);
        (A=:=1, B=:=1 -> 
        retract(isfull(Count)),
        ((Count<6,
        ((retract(enemy(Name,Health,Damage,Type,Skill,Id)),
        assertz(inventory(Name,Health,Damage,Type,Skill,Id)),
        NewCount is Count+1,
        asserta(isfull(NewCount)),
        write(Name), write(' is captured'),nl);(asserta(isfull(Count)))));
        (Count=:=6,
        NewCount is Count,
        asserta(isfull(NewCount)),
        write('You cannot capture another Tokemon! You have to drop one first'),nl)))).

/* pick and drop */
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

drop(X) :-
        command(initstart,A),
        ((A=:=0 -> write('You even have not started the game yet.'),nl);
        (isfull(1),write('You only have one tokemon!'),nl,!);
        ((inventory(X,_,_,_,_,_),
        write('Are you sure to drop '), write(X), write('?'),nl,
        write('yes or no'),nl,
        read(Response),
        ((Response==yes,
        retract(inventory(X,_,_,_,_,_)),
        write('Good bye '), write(X),
        retract(isfull(C)), NewC is C-1,
        assertz(isfull(NewC)));
        (Response==no,!));
        (write('You dont have '),write(X),nl)))).

/* Kondisi menang */
:- dynamic(iswin/1).
iswin(3).


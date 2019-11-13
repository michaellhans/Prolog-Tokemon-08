/* dynamicinventory dan dynamicenemy */
:- dynamic(inventory/6).
inventory(refflesia,115,20,leaves,woodhammer,8).
inventory(sijagokuning,95,25,fire,flamewheel,7).

:- dynamic(listenemy/6).
listenemy(ligator,630,40,water,hydropump,1).
listenemy(camelia,580,57,leaves,leafstorm,2).
listenemy(phoenix,500,70,fire,blastburn,3).

:- dynamic(chanceHeal/1).
chanceHeal(1).

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
        findall(X,inventory(X,_,_,_,_,_),Result),
        write('Your Tokemon:'),nl,
        printinventory(Result),
        findall(X,listenemy(X,_,_,_,_,_),Result1),
        write('Your Enemy:'),nl,
        printenemy(Result1).

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
        playerposition(PosX,PosY),
        (\+gym(PosX,PosY) -> write('You cannot heal your tokemon outside Gym!'),nl;
        chanceHeal(Num),
        (Num =:= 1 -> retract(chanceHeal(Num)),
        NewNum is 0, assertz(chanceHeal(NewNum)),
        findall(X,inventory(X,_,_,_,_,_),Result),
        write('You use your only one gym ticket!'),nl,
        write('All of your tokemons have been recovered!'),nl,
        write('Your Tokemon:'),nl,
        healinventory(Result);
        write('You do not have a ticket to the Gym!'))).
        

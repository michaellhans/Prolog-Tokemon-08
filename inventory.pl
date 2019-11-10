/* checklength digunakan untuk mengecek banyaknya tokemon yang ada pada inventory */
checklength([],0).
checklength([_|T],N) :- checklength(T,N1), N is N1+1.

/* deltokemon digunakan untuk menghapus tokemon dari list */
deltokemon(X,[X|T],T).
deltokemon(X,[A|T],[A|B]) :- deltokemon(X,T,B).

/* addtokemon digunakan untuk menambahkan tokemon ke dalam list */
addtokemon(X,[],[X]).
addtokemon(X,[H|T],[H|A]) :- addtokemon(X,T,A).

/* dynamiclist */
:- dynamic(inventory/6).
inventory(refflesia,115,20,leaves,woodhammer,8).
inventory(sijagokuning,95,25,fire,flamewheel,7).

/* printinventory */
status :-
        findall(Name,inventory(Name,Health,_,Type,_,_),Result),
        write(Result),nl,
        findall(Health,inventory(Name,Health,_,Type,_,_),Result1),
        write('Health   : '),write(Result1),nl,
        findall(Type,inventory(Name,Health,_,Type,_,_),Result2),
        write('Type     : '),write(Result2),nl.

/* removefromlist digunakan untuk menghapus tokemon dari inventory */
removefromlist(X) :- retract(inventory(OldList)), deltokemon(X,OldList,NewList), assertz(inventory(NewList)).
/* addtolist digunakan untuk menambahkan tokemon ke inventory */
addtolist(X) :- checklength(OldList,N),
                N<6, 
                retract(inventory(OldList)), 
                addtokemon(X,OldList,NewList), 
                assertz(inventory(NewList)),
                write('Congratulations, you have captured '),
                write(X),
                write('!').
addtolist(X) :- checklength(OldList,N),
                N=6,
                write('Your inventory is full!').
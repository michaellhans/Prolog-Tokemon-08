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
inventory([(refflesia,115,20,leaves,woodhammer,8),(sijagokuning,95,25,fire,flamewheel,7)]).

/* printinventory */
printinventory(inventory([(Name,Health,_,Type,_,_)])) :-
        write('Name     : '),write(Name),nl,
        write('Health   : '),write(Health),nl,
        write('Type     : '),write(Type),nl.
printinventory(inventory([(Name,Health,_,Type,_,_)|T])) :-
        write('Name     : '),write(Name),nl,
        write('Health   : '),write(Health),nl,
        write('Type     : '),write(Type),nl,
        printinventory(inventory(T)).

status :- 
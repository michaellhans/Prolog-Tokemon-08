/* checklength digunakan untuk mengecek banyaknya tokemon yang ada pada inventory */
checklength([],0).
checklength([_|T],N) :- checklength(T,N1), N is N1+1.

/* deltokemon digunakan untuk menghapus tokemon dari list */
deltokemon(X,[X|T],T).
deltokemon(X,[A|T],[A|B]) :- deltokemon(X,T,B).

/* addtokemon digunakan untuk menambahkan tokemon ke dalam list */
addtokemon(X,[],[X]).
addtokemon(X,[H|T],[H|A]) :- addtokemon(X,T,A).

/* printlist digunakan untuk menampilkan isi list */
printlist([]).
printlist([X|List]) :- write(X),nl,printlist(List).
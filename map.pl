/* FILE : MAP.PL */

/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul Map untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* MAP */

/* ============================================================================================================ */
/* DEKLARASI FAKTA-FAKTA */
/* fence -> fakta tentang keberadaan fence-fence dalam map */
/* fence merupakan suatu titik yang tidak bisa dimasuki oleh player */
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

/* gym -> fakta tentang keberadaan gym dalam map */
/* gym merupakan suatu titik yang bisa dimasuki oleh player dan bisa digunakan untuk heal seluruh inventory */
gym(6,13).

/* ============================================================================================================ */

/* RULES-RULES */
/* isAbove(_,Y) -> untuk mengecek apakah koordinat (X,Y) berada pada tepi atas map */
isAbove(_,Y) :-    
    Y =:= 0,!.

/* isDown(_,Y) -> untuk mengecek apakah koordinat (X,Y) berada pada tepi bawah map */    
isDown(_,Y) :-
    Y =:= 16,!.

/* isLeft(X,_) -> untuk mengecek apakah koordinat (X,Y) berada pada tepi kiri map */
isLeft(X,_) :-
    X =:= 0,!.

/* isRight(X,) -> untuk mengecek apakah koordinat (X,Y) berada pada tepi kanan map */
isRight(X,_) :-
    X =:= 16,!.

/* area(X,Y) -> untuk mengecek apakah koordinat (X,Y) berada pada area map           */
/* area map didefinisikan sebagai area kosong tanpa adanya player, fence, maupun gym */
area(X,Y) :-
	\+playerposition(X,Y),
	\+fence(X,Y),
    \+gym(X,Y),
    X =\= 0,
    X =\= 16,
    Y =\= 0,
    Y =\= 16,!.

/* isMax(X,Y) -> untuk mengecek apakah koordinat (X,Y) merupakan batas akhir dari map */
isMax(X,Y) :-
    X > 16,
    Y > 16,!.

/* isGym(X,Y) -> untuk mengecek apakah terdapat Gym pada koordinat (X,Y) */
isGym(X,Y) :-
    (
        gym(X,Y),
        X =:= 6,
        Y =:= 13
    ).

/* isFence(X,Y) -> untuk mengecek apakah terdapat fence pada koordinat (X,Y) */
isfence(X,Y) :-
    (
        fence(X,Y);
        X =:= 0;
        X =:= 16;
        Y =:= 0;
        Y =:= 16
    ).

/* Rules untuk Print Map */
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

/* map -> untuk menampilkan peta pada GNU Prolog dengan proses rekursif */
map :- 
    command(initstart,X),
    command(initfight,Y),
    command(initenemydead,Z),
    ((X=:=0 -> write('You even have not started the gamet yet.'),nl);
    (X=:=1, Y=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (X=:=1, Y=:=0, Z=:=1 -> write('You have to drop one of your Tokemon first.'),nl);
    (X=:=1, Y=:=0 -> printMap(0,0))).

/* Movement */
/* w -> menggerakkan player ke arah sumbu Y+ atau utara sebesar 1 satuan */
w :- 
    command(initstart,A),
    command(initfight,B),
    command(initenemydead,C),
    ((A=:=0 -> write('You even have not started the game yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0, C=:=1 -> write('You have to drop one of your Tokemon first.'),nl);
    (A=:=1, B=:=0, C=:=0 -> retract(playerposition(X,Y)),
    NewX is X,
    NewY is Y-1,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the north.'),!,
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    (write('Cannot move! You are near the fence.'), 
    assertz(playerposition(X,Y)))))).

/* s -> menggerakkan player ke arah sumbu Y- atau selatan sebesar 1 satuan */
s :-
    command(initstart,A),
    command(initfight,B),
    command(initenemydead,C),
    ((A=:=0 -> write('You even have not started the game yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0, C=:=1 -> write('You have to drop one of your Tokemon first.'),nl);
    (A=:=1, B=:=0 -> retract(playerposition(X,Y)),
    NewX is X,
    NewY is Y+1,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the south.'),
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))))).

/* d -> menggerakkan player ke arah sumbu X+ atau barat sebesar 1 satuan */
d :-
    command(initstart,A),
    command(initfight,B),
    command(initenemydead,C),
    ((A=:=0 -> write('You even have not started the game yet.'),nl);
    (A=:=1, B=:=1 -> write('You are in the middle of fighting. You cannot choose this option!'),nl);
    (A=:=1, B=:=0, C=:=1 -> write('You have to drop one of your Tokemon first.'),nl);
    (A=:=1, B=:=0 -> retract(playerposition(X,Y)),
    NewX is X+1,
    NewY is Y,
    ((isGym(NewX,NewY) -> write('You are inside the gym.'), assertz(playerposition(NewX,NewY)));
    (\+isfence(NewX,NewY) -> write('You move to the east.'),
    assertz(playerposition(NewX,NewY)),
    checkPerimeter,!);
    write('Cannot move! You are near the fence.'),
    assertz(playerposition(X,Y))))).

/* a -> menggerakkan player ke arah sumbu X- atau timur sebesar 1 satuan */
a :-
    command(initstart,A),
    command(initfight,B),
    command(initenemydead,C),
    (
        (A=:=0 -> 
            write('You even have not started the game yet.'),nl);
        (A=:=1, B=:=1 -> 
            write('You are in the middle of fighting. You cannot choose this option!'),nl);
        (A=:=1, B=:=0, C=:=1 -> write('You have to drop one of your Tokemon first.'),nl);
        (A=:=1, B=:=0 -> 
            retract(playerposition(X,Y)),
            NewX is X-1,
            NewY is Y,
            (
                (isGym(NewX,NewY) -> 
                    write('You are inside the gym.'), 
                    assertz(playerposition(NewX,NewY)));
                (\+isfence(NewX,NewY) -> 
                    write('You move to the west.'),
                    assertz(playerposition(NewX,NewY)),
                    checkPerimeter,!);

                write('Cannot move! You are near the fence.'),
                assertz(playerposition(X,Y))
            )
        )
    ).

/* ============================================================================================================ */
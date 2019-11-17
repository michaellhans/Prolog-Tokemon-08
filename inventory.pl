/* FILE : INVENTORY.PL */

/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul Inventory untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* Deklarasi Fakta */
/* inventory adalah dynamic predicate yang menampung seluruh tokemon yang dimiliki player */
:- dynamic(inventory/6).
inventory(refflesia,115,20,leaves,woodhammer,8).

/* listenemy adalah dynamic predicate yang menampung seluruh Legendary Tokemon */
:- dynamic(listenemy/6).
listenemy(ligator,630,40,water,hydropump,1).
listenemy(camelia,580,57,leaves,leafstorm,2).
listenemy(phoenix,500,70,fire,blastburn,3).

/* Kondisi inventory */
/* isfull adalah dynamic predicate yang menampung jumlah elemen pada inventory player */
:- dynamic(isfull/1).
isfull(1).

:- dynamic(temp/6).
temp(refflesia,115,20,leaves,woodhammer,8).

/* Kondisi menang */
:- dynamic(iswin/1).
iswin(3).

/* Deklarasi Rules */
/* addToTemp digunakan untuk menambahkan tokemon baru ke dalam Temp ketika tokemon enemy dicapture. */
addToTemp(Id) :-
        tokemon(Name,Health,Dmg,Type,Skill,Id),
        assertz(temp(Name,Health,Dmg,Type,Skill,Id)).

/* removeFromTemp digunakan untuk menghapus tokemon yang terdaftar dalam Temp ketika tokemon me sudah mati */
removeFromTemp(Id) :-
        tokemon(Name,Health,Dmg,Type,Skill,Id),
        retract(temp(Name,Health,Dmg,Type,Skill,Id)).

/* printinventory digunakan untuk menampilkan listing tokemon yang dimiliki */
printinventory([]).
printinventory([H|T]) :-
        write(H),nl,
        inventory(H,Health,_,Type,_,_),
        write('Health   : '),write(Health),nl,
        write('Type     : '),write(Type),nl,nl,
        printinventory(T).

/* printenemy digunakan untuk menampilkan listing enemy (Legendary Tokemon) */
printenemy([]).
printenemy([H|T]) :-
        write(H),nl,
        listenemy(H,Health,_,Type,_,_),
        write('Health   : '),write(Health),nl,
        write('Type     : '),write(Type),nl,nl,
        printenemy(T).

/* status untuk menampilkan Tokemon yang dimiliki oleh player, beserta propertinya */
status :-
        command(initstart,A),
        (
                /* Game belum dimulai */
                (A=:=0 -> 
                        write('You even have not started the game yet.'),nl
                );
                /* Game telah dimulai, baru bisa print status */
                (A=:=1 ->
                        findall(X,inventory(X,_,_,_,_,_),Result),
                        write('Your Tokemon:'),nl,
                        printinventory(Result),
                        findall(X,listenemy(X,_,_,_,_,_),Result1),
                        write('Your Enemy:'),nl,
                        printenemy(Result1)
                )
        ).

/* healInventory untuk menampilkan inventory player setelah semua tokemon di-heal */
healinventory([]).
healinventory([H|T]) :-
        write(H),nl,
        inventory(H,Health,_,Type,_,_),
        retract(inventory(H,Health,Damage,Type,Skill,Id)),
        temp(H,Hp1,_,_,_,_),
        NewHealth is Hp1,
        write('Health   : '),write(NewHealth),nl,
        write('Type     : '),write(Type),nl,nl,
        assertz(inventory(H,NewHealth,Damage,Type,Skill,Id)),
        healinventory(T).

/* heal untuk menambah semua Health pada tokemon yang dimiliki oleh player */
heal :-
        command(initstart,A),
        (
                /* Game belum dimulai */
                (A=:=0 -> 
                        write('You even have not started the game yet.'),nl);
                /* Game telah dimulai, heal di dalam gym */
                (A=:=1 -> 
                        playerposition(PosX,PosY),
                        (\+gym(PosX,PosY) -> 
                                write('You cannot heal your tokemon outside Gym!'),nl;
                        command(initheal,X),
                        (
                                (X =:= 0 -> 
                                        retract(command(initheal,0)),
                                        assertz(command(initheal,1)),
                                        findall(Y,inventory(Y,_,_,_,_,_),Result),
                                        write('You use your only one gym ticket!'),nl,
                                        write('All of your tokemons have been recovered!'),nl,
                                        write('Your Tokemon:'),nl,
                                        healinventory(Result));
                                (X=:=1 -> 
                                        write('You do not have a ticket to the Gym!'),nl
                                )
                        )
                        )
                )
        ).

/* capture digunakan untuk memasukkan Tokemon yang telah dikalahkan ke dalam inventory player */

capture :-
        command(initstart,A),
        command(initenemydead,B),
        (
                /* Game belum dimulai */
                (A=:=0 -> 
                        write('You even have not started the game yet.'),nl
                );
                /* Tidak ada Tokemon yang bisa ditangkap */
                (B=:=0 -> 
                        write('There is no Tokemon to capture'),nl
                );
                /* Game dimulai, ada tokemon yang bisa ditangkap */
                (A=:=1, B=:=1 -> 
                        retract(isfull(Count))),
                (
                        (
                                Count<6,
                                retract(enemy(Name,_,_,_,_,_)),
                                tokemon(Name,Health,Damage,Type,Skill,Id),
                                assertz(inventory(Name,Health,Damage,Type,Skill,Id)),
                                NewCount is Count+1,
                                asserta(isfull(NewCount)),
                                write(Name), write(' is captured'),nl,
                                retract(command(initenemydead,1)),assertz(command(initenemydead,0)),
                                addToTemp(Id)
                        );
                        (
                                Count=:=6,
                                retract(enemy(Name,_,_,_,_,_)),
                                NewCount is Count,
                                asserta(isfull(NewCount)),
                                write('You cannot capture another Tokemon! You have to drop one first'),nl
                        )
                )
        ).

/* pick digunakan untuk memilih Tokemon yang akan dipakai saat fight */
pick(X) :-
        command(initstart,A),
        command(initfight,B),
        command(initpick,C),
        (
                /* Game belum dimulai */
                (A=:=0 -> 
                        write('You even have not started the game yet.'),nl
                );
                /* Mekanisme jika sedang bertarung, tetapi memilih opsi ini */
                (A=:=1, B=:=1, C=:=1 -> 
                        write('You are in the middle of fighting. You cannot use this option!'),nl
                );
                /* Mekanisme jika game telah dimulai, memasuki kondisi bertarung, dan belum memilih Tokemon */
                (A=:=1, B=:=1, C=:=0 ->
                        retract(inventory(X,Health,Damage,Type,Skill,Id)),
                        assertz(me(X,Health,Damage,Type,Skill,Id)),
                        write(X),
                        write(' I choose you!'),nl,
                        retract(command(initpick,0)),assertz(command(initpick,1))
                )
        ).

/* drop digunakan untuk melepaskan Tokemon yang ada di inventory jika inventory sudah penuh */
drop(X) :-
        command(initstart,A),
        (
                (A=:=0 -> 
                        write('You even have not started the game yet.'),nl
                );
                (isfull(1),write('You only have one tokemon!'),nl,!);
                ((inventory(X,_,_,_,_,Id),
                write('Are you sure to drop '), write(X), write('?'),nl,
                write('yes or no'),nl,
                read(Response),
                ((Response==yes,
                retract(inventory(X,_,_,_,_,Id)),
                write('Good bye '), write(X),
                retract(isfull(C)), NewC is C-1,
                assertz(isfull(NewC)),removeFromTemp(Id));
                (Response==no,!));
                (write('You dont have '),write(X),nl)))
        ).
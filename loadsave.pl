/* FILE : LOADSAVE.PL */

/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul Load Save untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* Deklarasi Fakta */

/* Deklarasi Rule */
/* *** MAIN RULES *** */
load(Filename) :-
    command(initstart,X),
    command(initsave,Y),
    ((X=:=0 -> write('You even have not started the game yet.'),nl);
    (X=:=1, Y=:=0 -> write('You do not have any saved files!'),nl);
    (X=:=1, Y=:=1 ->
    clear,
    open(Filename, read, File),
    repeat,
        read(File, SavedData),
        asserta(SavedData),
    at_end_of_stream(File),
    close(File),
    retract(command(initload,0)),assertz(command(initload,1)))).

save(Filename) :-
    command(initstart,X),
    (X=:=1 ->
    open(Filename, write, File),
        save_playerposition(File),
        save_isfull(File),
        save_iswin(File),
        save_activeId(File),
        save_answer(File),
        save_command(File),
        save_inventory(File),
        save_tokemon(File),
        save_listenemy(File),
        save_temp(File),
        save_available(File),
        save_me(File),
        save_enemy(File),
    close(File),
    retract(command(initsave,0)),assertz(command(initsave,1))).

/* *** SUPPORTING RULES *** */
/* Save semua predikat */
save_playerposition(Stream) :-
    forall(playerposition(X, Y),
        (write(Stream, playerposition(X, Y)), write(Stream, '.'), nl(Stream))).

save_isfull(Stream) :-
    forall(isfull(N),
        (write(Stream, isfull(N)), write(Stream, '.'), nl(Stream))).

save_iswin(Stream) :-
    forall(iswin(N),
        (write(Stream, iswin(N)), write(Stream, '.'), nl(Stream))).

save_activeId(Stream) :-
    forall(activeId(N),
        (write(Stream, activeId(N)), write(Stream, '.'), nl(Stream))).

save_answer(Stream) :-
    forall(answer(N),
        (write(Stream, answer(N)), write(Stream, '.'), nl(Stream))).

save_command(Stream) :-
        forall(command(Cmmd, Val),
            (write(Stream, command(Cmmd, Val)), write(Stream, '.'), nl(Stream))).

save_inventory(Stream) :-
    forall(inventory(Nama, Hp, Atk, Type, SpSkill, Id),
        (write(Stream, inventory(Nama, Hp, Atk, Type, SpSkill, Id)), write(Stream, '.'), nl(Stream))).

save_tokemon(Stream) :-
    forall(tokemon(Nama, Hp, Atk, Type, SpSkill, Id),
        (write(Stream, tokemon(Nama, Hp, Atk, Type, SpSkill, Id)), write(Stream, '.'), nl(Stream))).

save_listenemy(Stream) :-
    forall(listenemy(Nama, Hp, Atk, Type, SpSkill, Id),
        (write(Stream, listenemy(Nama, Hp, Atk, Type, SpSkill, Id)), write(Stream, '.'), nl(Stream))).

save_temp(Stream) :-
    forall(temp(Nama, Hp, Atk, Type, SpSkill, Id),
        (write(Stream, temp(Nama, Hp, Atk, Type, SpSkill, Id)), write(Stream, '.'), nl(Stream))).

save_available(Stream) :-
    forall(available(SpSkill),
        (write(Stream, available(SpSkill)), write(Stream, '.'), nl(Stream))).

save_me(Stream) :-
    forall(me(Nama, Hp, Atk, Type, SpSkill, Id),
        (write(Stream, me(Nama, Hp, Atk, Type, SpSkill, Id)), write(Stream, '.'), nl(Stream))).

save_enemy(Stream) :-
    forall(enemy(Nama, Hp, Atk, Type, SpSkill, Id),
        (write(Stream, enemy(Nama, Hp, Atk, Type, SpSkill, Id)), write(Stream, '.'), nl(Stream))).
        
clear:-
    retractall(playerposition(_, _)),
    retractall(isfull(_)),
    retractall(iswin(_)),
    retractall(activeId(_)),
    retractall(answer(_)),
    retractall(command(_, _)),
    retractall(inventory(_, _, _, _, _, _)),
    retractall(tokemon(_, _, _, _, _, _)),
    retractall(listenemy(_, _, _, _, _, _)),
    retractall(temp(_, _, _, _, _, _)),
    retractall(available(_)),
    retractall(me(_, _, _, _, _, _)),
    retractall(enemy(_, _, _, _, _, _)).

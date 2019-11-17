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
    (X=:=1, Y=:=1 ->
    clear,
    loadInvt,
    loadEnmy,
    loadTemp,
    open(Filename, read, File),
    updtKoor(File),
    updtFull(File),
    updtCmmd(File),
    close(File),
    retract(command(initload,0)),assertz(command(initload,1)))).

save(Filename) :-
    command(initstart,X),
    (X=:=1 ->
    saveInvt,
    saveEnmy,
    saveTemp,
    saveSkll,
    open(Filename, write, FileGnr),
    (
        playerposition(OldX, OldY),
            writeKoor(FileGnr, OldX, OldY)
    ),
    (
        isfull(WasFull),
            write(FileGnr, WasFull), write(FileGnr,'.'), nl(FileGnr)
    ),
    (
        iswin(Won),
            write(FileGnr, Won), write(FileGnr,'.'), nl(FileGnr)
    ),
    (
        iswin(Left),
            write(FileGnr, Left), write(FileGnr,'.'), nl(FileGnr)
    ),
    forall(command(Cmmd, V),
        writeCmmd(FileGnr, Cmmd, V)),
    close(FileGnr),
    retract(command(initsave,0)),assertz(command(initsave,1))).

/* *** SUPPORTING RULES *** */
/* Processing tokemon */
writeTkmn(File, Nama, Hp, Atk, Type, SpSkill, X) :-
    write(File, Nama), write(File, ' '),
    write(File, Hp), write(File, ' '),
    write(File, Atk), write(File, ' '),
    write(File, Type), write(File, ' '),
    write(File, SpSkill), write(File, ' '),
    write(File, X), write(File, '.'),nl(File).

/* SaveLoad inventory */
saveInvt :-
    open('inventory.txt', write, FileInv),
    forall(inventory(NamaI, HpI, AtkI, TypeI, SpSkillI, XI),
        writeTkmn(FileInv, NamaI, HpI, AtkI, TypeI, SpSkillI, XI)),
    close(FileInv).

loadInvt :-
    open('inventory.txt', read, FileInv),
    updtInvt(FileInv),
    close(FileInv).

/* SaveLoad listenemy */
saveEnmy :-
    open('listenemy.txt', write, FileEnmy),
    forall(listenemy(Nama, Hp, Atk, Type, SpSkill, X),
        writeTkmn(FileEnmy, Nama, Hp, Atk, Type, SpSkill, X)),
    close(FileEnmy).

loadEnmy :-
    open('listenemy.txt', write, FileEnmy),
    updtEnmy(FileEnmy),
    close(FileEnmy).

/* SaveLoad temp */
saveTemp :-
    open('temp.txt', write, FileTemp),
    forall(temp(Nama, Hp, Atk, Type, SpSkill, X),
        writeTkmn(FileTemp, Nama, Hp, Atk, Type, SpSkill, X)),
    close(FileTemp).

loadTemp:-
    open('temp.txt', write, FileTemp),
    updtTemp(FileTemp),
    close(FileTemp).

/* SaveLoad available */
saveSkll :-
    open('available.txt', write, FileSkll),
    forall(available(Skill),
        (write(FileSkll, Skill),nl(FileSkll))),
    close(FileSkll).

loadSkll :-
    open('available.txt', read, FileSkll),
    updtSkll(FileSkll),
    close(FileSkll).

clear:-
    retract(playerposition(OldX, OldY)),
    retract(isfull(WasFull)),
    forall(inventory(A, B, C, D, E, F), retract(inventory(A, B, C, D, E, F))),
    forall(listenemy(P, Q, R, S, T, U), retract(listenemy(P, Q, R, S, T, U))),
    forall(command(Command, Z), retract(command(Command, Z))).

/* Update posisi pemain */
readKoor(StrIn, KoorX, KoorY) :-
	read_string(StrIn, ".", " ", End, StrTemp),
	split_string(StrTemp, " ", " ", [A, B | T]),
	number_codes(KoorX, A),
	number_codes(KoorY, B).

writeKoor(File, X, Y) :-
	write(File, X), write(File, ' '),
    write(File, Y), write(File, '.'),nl(File).

updtKoor(File) :-
    readKoor(File, KoorX, KoorY),
    assert(playerposition(KoorX, KoorY)).

/* Update isfull */
updtFull(File) :-
    read(File, Full),
    assert(isfull(Full)).

readTkmn(StrIn, Nama, Hp, Atk, Type, SpSkill, X) :-
    \+ at_end_of_stream(StrIn),
    read_string(StrIn, ".", " ", End, StrTemp),
    split_string(StrTemp, " ", " ", [A, B, C, D, E, F | T]),
    Nama = A,
	number_codes(Hp, B),
    number_codes(Atk, C),
    Type = D,
    SpSkill = E,
    number_codes(X, F).

updtInvt(File) :-
    readTkmn(File, Nama, Hp, Atk, Type, SpSkill, X),
    assert(inventory(Nama, Hp, Atk, Type, SpSkill, X)),
    updtInvt(File).
updtInvt(File) :-
    at_end_of_stream(File).

updtEnmy(File) :-
    readTkmn(File, Nama, Hp, Atk, Type, SpSkill, X),
    assert(listenemy(Nama, Hp, Atk, Type, SpSkill, X)),
    updtEnmy(File).
updtEnmy(File) :-
    at_end_of_stream(File).

updtTemp(FileTemp) :-
    readTkmn(File, Nama, Hp, Atk, Type, SpSkill, X),
    assert(temp(Nama, Hp, Atk, Type, SpSkill, X)),
    updtTemp(FileTemp).
updtTemp(FileTemp) :-
    at_end_of_stream(FileTemp).

/* Update Command */
writeCmmd(File, Command, Val) :-
    write(File, Command), write(File, ' '),
    write(File, Val), write(File, '.'),nl(File).

readCmmd(StrIn, Command, Val) :-
    read_string(StrIn, ".", " ", End, StrTemp),
    split_string(StrTemp, " ", " ", [A, B | T]),
    Command = A,
    number_codes(Val, B).

updtCmmd(File) :-
    readCmmd(File, Command, Val),
    assert(command(Command, Val)),
    updtCmmd(File).
updtCmmd(File) :-
    at_end_of_stream(File).

/* Update available */
updtSkll(File) :-
    read(File, Skill),
    assert(available(Skill)),
    updtSkll(File).
updtSkll(File) :-
    at_end_of_stream(File).

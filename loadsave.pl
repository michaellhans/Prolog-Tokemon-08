/* Deklarasi Fakta */

/* Deklarasi Rule */

load(Filename) :-
    open(Filename, read, File),
    clear,
    updtKoor(File),
    updtHeal(File),
    updtFull(File),
    updtCmmd(File),
    close(File),
    open('inventory.txt', read, FileInvt),
    updtInvt(FileInvt),
    close(FileInvt),
    open('listenemy.txt', read, FileEnmy),
    updtEnmy(FileEnmy),
    close(FileEnmy).

save(Filename) :-
    open(Filename, write, FileGnr),
    (
        playerposition(OldX, OldY),
            writeKoor(FileGnr, OldX, OldY)
    ),
    (
        chanceHeal(Lastchance),
            write(FileGnr, Lastchance), write(FileGnr,'.'), nl(FileGnr)
    ),
    (
        isfull(WasFull),
            write(FileGnr, WasFull), write(FileGnr,'.'), nl(FileGnr)
    ),
    forall(command(Cmmd, V), writeCmmd(FileGnr, Cmmd, V)),
    close(FileGnr),
    open('inventory.txt', write, FileInv),
    forall(inventory(Nama, Hp, Atk, Type, SpSkill, X), writeTkmn(FileInv, Nama, Hp, Atk, Type, SpSkill, X)),
    close(FileInv),
    open('listenemy.txt', write, FileEnmy),
    forall(listenemy(Nama, Hp, Atk, Type, SpSkill, X), writeTkmn(FileEnmy, Nama, Hp, Atk, Type, SpSkill, X)),
    close(FileEnmy).

clear:-
    retract(playerposition(OldX, OldY)),
    retract(chanceHeal(Lastchance)),
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

/* Update chance heal */
updtHeal(File) :-
    read(File, Heal),
    assert(chanceHeal(Heal)).

/* Update isfull */
updtFull(File) :-
    read(File, Full),
    assert(isfull(Full)).

/* Update tokemon */
writeTkmn(File, Nama, Hp, Atk, Type, SpSkill, X) :-
    write(File, Nama), write(File, ' '),
    write(File, Hp), write(File, ' '),
    write(File, Atk), write(File, ' '),
    write(File, Type), write(File, ' '),
    write(File, SpSkill), write(File, ' '),
    write(File, X), write(File, '.'),nl(File).

readTkmn(StrIn, Nama, Hp, Atk, Type, SpSkill, X) :-
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

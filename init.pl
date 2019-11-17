/* FILE : INIT.PL */

/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul INIT untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* FAKTA-FAKTA */

:- dynamic(playerposition/2).
playerposition(6,12).

:- dynamic(command/2).
command(initstart,0).
command(initmap,0).
command(initheal,0).
command(initsave,0).
command(initload,0).
command(initfight,0).
command(initpick,0).
command(inittokemonappear,0).
command(initenemydead,0).
command(initlegendaryappear,0).
command(initnormalappear,0).
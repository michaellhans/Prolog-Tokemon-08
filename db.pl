/* FILE : DB.PL */

/* IF2121 - Logika Komputasional                */
/* Tugas Besar  : Tokemon Pro and Log           */
/* Deskripsi    : Modul Database untuk Game Tokemon  */
/* Kelompok 8 */
/* NIM/Nama : */
/* 13518020 / Florencia Wijaya */
/* 13518056 / Michael Hans */
/* 13518092 / Izharulhaq */
/* 13518128 / Lionnarta Savirandy */

/* DEKLARASI DYNAMIC PREDICATE */

:- dynamic(tokemon/6).
:- dynamic(available/1).

/* ============================================================================================================ */

/* FAKTA-FAKTA */

/* Database Tokemon */
tokemon(ligator,430,40,water,hydropump,1).
tokemon(camelia,380,57,leaves,leafstorm,2).
tokemon(phoenix,320,70,fire,blastburn,3).
tokemon(sijagomerah,80,22,fire,flamethower,4).
tokemon(sijagobiru,85,23,fire,overheat,5).
tokemon(sijagoungu,90,24,fire,sacredfire,6).
tokemon(sijagokuning,95,25,fire,eruption,7).
tokemon(refflesia,115,20,leaves,woodhammer,8).
tokemon(rose,100,17,leaves,absorb,9).
tokemon(mawar,105,23,leaves,leechseed,10).
tokemon(melati,110,19,leaves,gigadrain,11).
tokemon(aqua,130,13,water,tidalwave,12).
tokemon(ades,135,14,water,hurricane,13).
tokemon(pristine,140,15,water,absolutezero,14).
tokemon(thor,90,19,lightning,thorhammer,15).
tokemon(charge,95,20,lightning,discharge,16).
tokemon(thunder,100,21,lightning,bolt,17).
tokemon(rocky,120,14,earth,fissure,18).
tokemon(hulk,125,15,earth,earthquake,19).
tokemon(smash,130,16,earth,superpower,20).
tokemon(wush,110,15,wind,roost,21).
tokemon(aang,115,16,wind,skyattack,22).
tokemon(topan,120,17,wind,aerialace,23).

/* Available skill */
available(hydropump).
available(leafstorm).
available(blastburn).
available(flamethower).
available(overheat).
available(sacredfire).
available(eruption).
available(woodhammer).
available(absorb).
available(leechseed).
available(gigadrain).
available(tidalwave).
available(hurricane).
available(absolutezero).
available(thorhammer).
available(discharge).
available(bolt).
available(fissure).
available(earthquake).
available(superpower).
available(roost).
available(skyattack).
available(aerialace).

/* Attack attribute */
/* increaseDamage(Type1, Type2) -> attack yang diberikan oleh tokemon dengan type1 akan memberikan damage sebesar 150% */
/* kepada tokemon dengan type2 */
increaseDamage(fire,leaves).
increaseDamage(fire,wind).
increaseDamage(earth,fire).
increaseDamage(earth,lightning).
increaseDamage(leaves,water).
increaseDamage(leaves,earth).
increaseDamage(water,fire).
increaseDamage(water,earth).
increaseDamage(wind,leaves).
increaseDamage(wind,earth).
increaseDamage(lightning,water).
increaseDamage(lightning,wind).

/* decreaseDamage(Type1, Type2) -> attack yang diberikan oleh tokemon dengan type1 akan memberikan damage yang berkurang sebesar 50% */
/* kepada tokemon dengan type2 */
decreaseDamage(leaves,fire).
decreaseDamage(earth,leaves).
decreaseDamage(fire,earth).
decreaseDamage(wind,fire).
decreaseDamage(lightning,earth).
decreaseDamage(water,leaves).
decreaseDamage(fire,water).
decreaseDamage(earth,water).
decreaseDamage(leaves,wind).
decreaseDamage(earth,wind).
decreaseDamage(water,lightning).
decreaseDamage(wind,lightning).

/* Tokepedia untuk melihat status tokemon */
/* Tokepedia(name) */
tokepedia(Name) :-
    (
        tokemon(Name,Health,Damage,Type,Skill,Id),
        write('Id Tokemon : '), write(Id),nl,
        write('Tokemon    : '), write(Name),nl,
        write('Type       : '), write(Type),nl,
        write('Health     : '), write(Health),nl,
        write('Damage     : '), write(Damage),nl,
        write('Skill      : '), write(Skill),nl,
        skillpedia(Skill),nl,!
    );
    ((
        Name==ligator,
        write('Id Tokemon : 1'),nl,
        write('Tokemon    : ligator'),nl,
        write('Type       : water'),nl,
        write('Health     : 430'),nl,
        write('Damage     : 40'),nl,
        write('Skill      : hydropump'),nl,
        skillpedia(hydropump),nl,!
    );
    (
        Name==camelia,
        write('Id Tokemon : 2'),nl,
        write('Tokemon    : camelia'),nl,
        write('Type       : leaves'),nl,
        write('Health     : 380'),nl,
        write('Damage     : 57'),nl,
        write('Skill      : leafstorm'),nl,
        skillpedia(leafstorm),nl,!
    );
    (
        Name==phoenix,
        write('Id Tokemon : 3'),nl,
        write('Tokemon    : phoenix'),nl,
        write('Type       : fire'),nl,
        write('Health     : 320'),nl,
        write('Damage     : 70'),nl,
        write('Skill      : blastburn'),nl,
        skillpedia(blastburn),nl,!
    ));
    (
        write(Name), write(' is not registered in tokepedia'),nl,!
    ).

/* Informasi skill yang tersedia */
skillpedia(Skill) :-
    (
        Skill==hydropump,
        write('    Power      : 2*damage of your Tokemon'),nl,
        write('    Effect     : Your damage is decreased by 40%'),nl,
        write('         Blast water attack with high pressure to enemy.'),nl,!
    );
    (
        Skill==leafstorm,
        write('    Power      : 2*damage of your Tokemon'),nl,
        write('    Effect     : Your damage is decreased by 40%'),nl,
        write('         Summon a storm with sharp leaf and deal multiple damage.'),nl,!
    );
    (
        Skill==blastburn,
        write('    Power      : 2*damage of your Tokemon'),nl,
        write('    Effect     : Your damage is decreased by 40%'),nl,
        write('         Crush ground to summon multiple fire pillar from the ground.'),nl,!
    );
    (
        Skill==overheat,
        write('    Power      : 4*damage of your Tokemon'),nl,
        write('    Effect     : Your damage is decreased by 50%'),nl,
        write('         Blast fire from tokemon with high power.'),nl,!
    );
    (
        Skill==eruption,
        write('    Power      : 110'),nl,
        write('    Effect     : Your damage is decreased by 40%'),nl,
        write('         Blast lava and deal huge damage.'),nl,!
    );
    (
        Skill==absolutezero,
        write('    Power      : 80'),nl,
        write('    Effect     : Your damage is decreased by 20%'),nl,
        write('         Freeze enemy and deal damage to enemy.'),nl,!
    );
    (
        Skill==discharge,
        write('    Power      : 90'),nl,
        write('    Effect     : Your damage is decreased by 25%'),nl,
        write('         Release high amount of electric power from tokemon.'),nl,!
    );
    (
        Skill==superpower,
        write('    Power      : 4*damage of your Tokemon'),nl,
        write('    Effect     : Your damage is decreased by 40%'),nl,
        write('         Deal high damage and decrease tokemon energy.'),nl,!
    );
    (
        Skill==skyattack,
        write('    Power      : 110'),nl,
        write('    Effect     : Your damage is decreased by 50%'),nl,
        write('         Tokemon fly with high speed and deal huge damage to enemy.'),nl,!
    );
    (
        Skill==aerialace,
        write('    Power      : 50'),nl,
        write('    Effect     : Your damage is increased by 20%'),nl,
        write('         Deal small damage and boost tokemon attack.'),nl,!
    );
    (
        Skill==leechseed,
        write('    Power      : 25'),nl,
        write('    Effect     : Heal your health by 15'),nl,
        write('         Deal small damage and recover tokemon health.'),nl,!
    );
    (
        Skill==gigadrain,
        write('    Power      : 40'),nl,
        write('    Effect     : Heal your health by 8'),nl,
        write('         Deal small damage and recover tokemon health.'),nl,!
    );
    (
        Skill==sacredfire,
        write('    Power      : 2.5*damage of your Tokemon'),nl,
        write('    Effect     : Heal your health by 5'),nl,
        write('         Deal damage and heal your tokemon health.'),nl,!
    );
    (
        Skill==thorhammer,
        write('    Power      : 60'),nl,
        write('    Effect     : Heal your health by 8'),nl,
        write('         Summon a huge hammer and blast enemy with huge electric damage.'),nl,!
    );
    (
        Skill==absorb,
        write('    Power      : Equal with your damage'),nl,
        write('    Effect     : Heal your health equal to your damage'),nl,
        write('         Deal damage and heal your tokemon health based on tokemon damage.'),nl,!
    );
    (
        Skill==flamethower,
        write('    Power      : 70'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Blast normal fire damage.'),nl,!
    );
    (
        Skill==woodhammer,
        write('    Power      : 65'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Summon hammer and deal normal leaves damage.'),nl,!
    );
    (
        Skill==tidalwave,
        write('    Power      : 60'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Call a huge wave and deal water damage.'),nl,!
    );
    (
        Skill==hurricane,
        write('    Power      : 60'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Summon black cloud and deal heavy damage.'),nl,!
    );
    (
        Skill==bolt,
        write('    Power      : 90'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Charge electric power and deal damage to enemy.'),nl,!
    );
    (
        Skill==fissure,
        write('    Power      : 75'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Open fissure in the ground to drop enemy.'),nl,!
    );
    (
        Skill==earthquake,
        write('    Power      : 75'),nl,
        write('    Effect     : No special effect'),nl,
        write('         Deal high power earth damage.'),nl,!
    );
    (
        Skill==roost,
        write('    Power      : 0'),nl,
        write('    Effect     : Heal your health by 20'),nl,
        write('         Rest and restore your health.'),nl,!
    );
    (
        write('Skill '), write(Skill),
        write(' is unknown'),nl,!
    ).


/* ============================================================================================================ */
/* Database Tokemon */
/* tokemon(name,health,damage,type,skill,id) */

tokemon(ligator,630,40,water,hydropump,1).
tokemon(camelia,580,57,leaves,leafstorm,2).
tokemon(phoenix,500,70,fire,blastburn,3).
tokemon(sijagomerah,80,22,fire,flamethower,4).
tokemon(sijagobiru,85,23,fire,overheat,5).
tokemon(sijagoungu,90,24,fire,sacredfire,6).
tokemon(sijagokuning,95,25,fire,flamewheel,7).
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

skill(water,hydropump). % damage = 50
skill(earth,earthquake). % damage = 75
skill(wind,roost). % health +20
skill(leaves,absorb). % health +(200%)*damage
skill(lightning,bolt). % damage = 90
skill(fire,eruption). % damage = 110. syarat = abis pake skill ini, damage berkurang menjadi 60% nya

activateSkill(NameSkill) :-
    ((NameSkill == hydropump) -> write('You use hydropump skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 50,
    write('Enemy is taken heavy damage!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Enemy is down!'),nl,
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));

    (NameSkill == earthquake) -> write('You use earthquake skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 75,
    write('Enemy is taken heavy damage!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Enemy is down!'),nl,
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));
    
    (NameSkill == roost) -> write('You use roost skill'),nl,
    retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
    NewHp1 is Hp1 + 20,
    write('Skill Activated!'),nl,
    write('Tokemonku - '), write(Name1),nl,
    write('Health : '), write(NewHp1),nl,
    write('Type : '),write(Type1),nl,nl,
    assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1));

    (NameSkill == absorb) -> write('You use absorb skill'),nl,
    retract(me(Name1,Hp1,Dmg1,Type1,Skill1,Id1)),
    NewHp1 is Hp1 + 2*Dmg1,
    write('Skill Activated!'),nl,
    write('Tokemonku - '), write(Name1),nl,
    write('Health : '), write(NewHp1),nl,
    write('Type : '),write(Type1),nl,nl,
    assertz(me(Name1,NewHp1,Dmg1,Type1,Skill1,Id1));

    (NameSkill == bolt) -> write('You use bolt skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 90,
    write('Enemy is taken heavy damage!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Enemy is down!'),nl,
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));

    (NameSkill == eruption) -> write('You use eruption skill'),nl,
    retract(enemy(Name2,Hp2,Dmg2,Type2,Skill2,Id2)),
    NewHp2 is Hp2 - 110,
    write('Enemy is taken heavy damage!'),nl,
    (NewHp2 =< 0 -> Dead is 0,
    write('Enemy is down!'),nl,
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(Dead),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,Dead,Dmg2,Type2,Skill2,Id2));
    write('Musuh - '),write(Name2),nl,
    write('Health : '),write(NewHp2),nl,
    write('Type : '),write(Type2),nl,nl,
    assertz(enemy(Name2,NewHp2,Dmg2,Type2,Skill2,Id2)));

    write('You have no skill to use'),nl).

/* Legendary Tokemon */
/* legendary(name) */
legendary(ligator).
legendary(camelia).
legendary(phoenix).
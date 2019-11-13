/* Database Tokemon */
/*  */

tokemon(ligator,630,40,water,hydropump,1).
tokemon(camelia,580,57,leaves,leafstorm,2).
tokemon(phoenix,500,70,fire,blastburn,3).
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

skill(water,hydropump). % damage = 50
skill(earth,earthquake). % damage = 75
skill(wind,roost). % health +20
skill(leaves,absorb). % health +(200%)*damage
skill(lightning,bolt). % damage = 90
skill(fire,eruption). % damage = 110. syarat = abis pake skill ini, damage berkurang menjadi 60% nya

/* Legendary Tokemon */
/* legendary(name) */
legendary(ligator).
legendary(camelia).
legendary(phoenix).
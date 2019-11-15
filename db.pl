/* Database Tokemon */
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

:- dynamic(available/1).

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
increaseDamage(earth,fire).
increaseDamage(earth,lightning).
increaseDamage(leaves,water).
increaseDamage(water,fire).
increaseDamage(water,earth).
increaseDamage(wind,leaves).
increaseDamage(wind,earth).
increaseDamage(lightning,water).
increaseDamage(lightning,wind).

/* decreaseDamage(Type1, Type2) -> attack yang diberikan oleh tokemon dengan type1 akan memberikan damage yang berkurang sebesar 50% */
/* kepada tokemon dengan type2 */
decreaseDamage(leaves,fire).
decreaseDamage(fire,earth).
decreaseDamage(lightning,earth).
decreaseDamage(water,leaves).
decreaseDamage(fire,water).
decreaseDamage(earth,water).
decreaseDamage(leaves,wind).
decreaseDamage(earth,wind).
decreaseDamage(water,lightning).
decreaseDamage(wind,lightning).

/* Legendary Tokemon */
/* legendary(name) */
legendary(ligator).
legendary(camelia).
legendary(phoenix).
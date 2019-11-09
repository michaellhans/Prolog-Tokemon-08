/* Attack attribute */

/* Weakness attribute type */
/* weakness(strong,weak) */
weakness(fire,leaves).
weakness(earth,fire).
weakness(earth,lightning).
weakness(leaves,water).
weakness(water,fire).
weakness(water,earth).
weakness(wind,leaves).
weakness(wind,earth).
weakness(lightning,water).
weakness(lightning,wind).

/* Resistance attribute type */
/* resistance(weak,strong) */
resistance(leaves,fire).
resistance(fire,earth).
resistance(lightning,earth).
resistance(water,leaves).
resistance(fire,water).
resistance(earth,water).
resistance(leaves,wind).
resistance(earth,wind).
resistance(water,lightning).
resistance(wind,lightning).

pick(X) :- 
        write(X),
        write(' I choose you'),nl.

fight :-
        write('Choose your Tokemon'),nl.



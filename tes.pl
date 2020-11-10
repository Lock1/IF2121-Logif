first_screen :-
    write('################################################'), nl,
    write('#        Welcome to your first journey         #'), nl,
    write('# 1. start   :                                 #'), nl,
    write('# 2. map     :                                 #'), nl,
    write('# 3. status  :                                 #'), nl,
    write('# 4. w       :                                 #'), nl,
    write('# 5. a       :                                 #'), nl,
    write('# 6. s       :                                 #'), nl,
    write('# 7. d       :                                 #'), nl,
    write('# 8. help    :                                 #'), nl,
    write('################################################').

choose_class :-
    write('You are born in this new world as a hero'), nl,
    write('Choose between these three!'), nl,
    write('1. Swordsman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,

    read(Choice),
    write('You have chosen '),
    (
        Choice =:= 1 ->
            write('Swordsman'), nl;
            (
                Choice =:= 2 ->
                    write('Archer'), nl;
                    (
                        Choice =:= 3 ->
                            write('Sorcerer'), nl
                    )
            )
    ), nl,
    write('You may begin your journey.').
    
    
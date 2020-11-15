/*:- dynamic(player/2) */
/*this means there is a dynamic function called player with 2 parameter/argument input*/

/*by using asserta you can add player on top of this*/
/*player(masterTanur, swordsman).*/
/*by using assertz you can add player below of this*/

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

start :-
    write('You are born in this new world as a hero'), nl,
    write('Tell me your name'), nl,
    read(Name),
    choose_class.

choose_class :-
    write('Choose between these three!'), nl,
    write('1. Swordsman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,
    write('4. See classes details'), nl,

    read(Choice),
    (   Choice =:= 1 ->
        write('You have chosen Swordsman'), nl,
        write(''), nl,
        write('            . . . .    . . .    . . . .    . . .  '), nl,
        write('                                                  '), nl,
        write('.             . .               . . .             '), nl, 
        write('    . .      . . .      .        . . .      .     '), nl,
        write('.  .        . . . .      .      . . . .           '), nl,
        write('    . .      . . .      . .      . .        .     '), nl,
        write('.  .        . . .      .          .     .:::5. .  '), nl,
        write('    . .      . . .        .      .  irirri:sX   . '), nl,
        write('.             . . .                :rii::.7qY     '), nl,
        write('            .                  :r:i::.71Xi        '), nl,
        write('.                                .rii::.ruJS:     '), nl,
        write('                                .rii::.russK.     '), nl,
        write('. .                   . .    .rii::.7usvJ2    .   '), nl,
        write('.  . . .        .      . . .   rii::.7usvY12   .  '), nl,
        write('. . . .    . .      . . .   iri::.rusLssPv  . .   '), nl,
        write('.  . . .      .        . .   iri::.7usvssK7  . .  '), nl,
        write('. . . .      .      . .   :ri::.7usvYjqi  . . .   '), nl,
        write('.  . . .               .   :ri::.7usvYuX:    . .  '), nl,
        write('    . . .                 .ri::.7usLJU5.    . . . '), nl,
        write('.  .                     .ri::.7usLJ22       .    '), nl,
        write('                        ri::.7usLJ5s              '), nl,
        write('                        rr::.7usLJK7              '), nl,
        write('.             . .      rr::.7jsLjKr               '), nl,
        write('    .        . . .    ir::.7jsYUK:   .      .   . '), nl,
        write('.           . . . .  :r::.rusY2X.   . .    .      '), nl,
        write('    . .      . . .  :7::.7jsYII    . .      . . . '), nl,
        write('.  . .          .  .7i:.7uss51    . . .        .  '), nl,
        write('            7r    7i:.rjJsXJ    . . .             '), nl,
        write('.           rXI7  ri:.rjJsK7        . .           '), nl,
        write('            .5Yj7:::.71JJKi        .              '), nl,
        write('            .j7Yv:.7ujuq:                         '), nl,
        write('            .7rvrruJUX.                           '), nl,
        write('. . .       ZIir77jII                     . .     '), nl,
        write('.  . . .     gBML:r7vv   . .               . . .  '), nl,
        write('. . . .   gQPXB5:rLi    . .    . . .    . . . .   '), nl,
        write('.  . .     gQP5gBBb77Jv  . .      . .      . . .  '), nl,
        write('. .     gQP5DBBBB.jYIr  . .      .        . . .   '), nl,
        write('.  .  s1.gQPIgBBQB  .SXr . .      . .      . . .  '), nl,
        write('.  .XYvIMXgQBQB    .i   .                   . .   '), nl,
        write('.     vu7iLBBBBB                                  '), nl,
        write('.      vJr:SBBB                                   '), nl,
        write('        7Jr:dB                                    '), nl,
        write('.        vs77.                    . .             '), nl,
        write('        71Yu   .        .      . . .              '), nl,
        write('.  . .     7Kv  . .             . . . .        .  '), nl,
        write('    . .     .  . .      . .      . . .      . .   '), nl,
        write('.    .        . . .    . .        . . .    . . .  '), nl,
        write('    . .      . . .      . .      . . . .      . . '), nl,
        write('.  . .        . . .        .    . . . .           '), nl,
        write('                                                  '), nl,
        write('You may begin your journey.'), nl;
        (
        Choice =:= 2 ->
        write('You have chosen Archer'), nl,
        write('                                                    ???????          '), nl,
        write('                                                    ????  ????       '), nl,
        write('                                                    ???   ???????    '), nl,  
        write('                                                    ??  ????         '), nl,  
        write('                                                    ?? ???           '), nl,  
        write('                                                    ?? ????          '), nl,  
        write('                                                ??????????           '), nl, 
        write('                                            ?????  ????              '), nl,
        write('                                        ?????      ???               '), nl,
        write('                                        ?????         ???            '), nl,  
        write('                                    ?????            ????            '), nl, 
        write('                                ?????               ????             '), nl,
        write('                    ?????      ?????                  ? ??           '), nl,  
        write('                    ??????  ????                    ?? ??            '), nl, 
        write('                    ?  ?????                       ?? ??             '), nl,
        write('                    ?????????                      ?? ??             '), nl,
        write('                    ???  ? ???                    ??  ??             '), nl,
        write('                ???? ???? ???                    ??? ??              '), nl,
        write('            ??????????? ??????                   ?? ? ??             '), nl,
        write('            ?????? ???????? ????                 ?? ????             '), nl,
        write('            ????????????????????               ???? ??               '), nl,
        write('                ????????????????????           ?? ?? ?               '), nl,
        write('                ??  ????????   ????????        ?? ?? ??              '), nl, 
        write('                ??                 ????????    ?? ?? ??              '), nl,  
        write('                ?                     ??????? ?? ??????              '), nl,  
        write('            ??                        ????????? ???         ?        '), nl,
        write('            ??                           ??????????          ??      '), nl,
        write('            ??                           ??  ??????          ????    '), nl, 
        write('            ??                         ???  ?? ???????       ????    '), nl, 
        write('            ??                        ???  ??????    ?????    ?????  '), nl,  
        write('        ??                       ????   ????         ????  ??????    '), nl,
        write('        ??                    ????? ??????              ?????????    '), nl,
        write('        ??                  ?????   ?????            ??????????????  '), nl,
        write('        ?              ???????  ??????            ?????????????????? '), nl,
        write('??????????????????????????????????                   ??????????????  '), nl,
        write('??????  ???????????????????????                                    ??'), nl,
        write('??? ? ?????????????????????                                          '), nl, 
        write('???? ??? ????                                                        '), nl, 
        write('??? ??  ??                                                           '), nl,
        write('????                                                                 '), nl,                                                            
        write('You may begin your journey.'), nl;       
        (
        Choice =:= 3 ->
        write('You have chosen Sorcerer'), nl,
        write('You may begin your journey.'), nl;
        (
        Choice =:= 4 ->    
        nl,
        write('CLASS DETAILS'), nl,
        write('<------------------------------------->'), nl,
        write('SWORDSMAN'), nl,
        write('Max HP: '), nl,
        write('Attack: '), nl,
        write('Defense: '), nl,
        write('<------------------------------------->'), nl,
        write('Archer'), nl,
        write('Max HP: '), nl,
        write('Attack: '), nl,
        write('Defense: '), nl,
        write('<------------------------------------->'), nl,
        write('Sorcerer'), nl,
        write('Max HP: '), nl,
        write('Attack: '), nl,
        write('Defense: '), nl,
        choose_class;
        (
        (Choice >4 ; Choice<0) -> %error handling
        nl,
        nl,
        write('************************************************'), nl,
        write('****You can only choose till 4, choose again****'), nl,
        write('************************************************'), nl,
        choose_class                                    
        )
        )
        )
        )
    ), write('Cok').
    

/*read from file*/
read_from_file(File) :-
    open(File, read, Stream),

    /*Get char from data Stream*/
    get_char(Stream, Char1),

    /*Output all characters until end_of_file*/
    process_the_stream(Char1, Stream),
    
    close(Stream).

process_the_stream(end_of_file, _) :- !.
process_the_stream(Char, Stream) :-
    write(Char),
    get_char(Stream, Char2),
    process_the_stream(Char2, Stream).

/*write to file*/
write_on_file(File, Text) :-
    open(File, write, Stream), /*file will get overwritten*/
    /*open(File, appen, Stream), file will not get overwritten*/
    write(Stream, Text), nl,
    close(Stream).


    
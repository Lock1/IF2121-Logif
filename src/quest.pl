:-include('facts.pl').

:-dynamic(countMonster1/2).
:-dynamic(countMonster2/2).
:-dynamic(countMonster3/2).


quest :-
    player(Username), randomize,
    write('Hello, '), write(Username), write('It\'s time for some adventure'), nl,
    random(1,500,Mnstr1), random(1,500,Mnstr2), random(1,500,Mnstr3),
    Mnstr1 is mod(Mnstr1, 6) + 1, Mnstr2 is mod(Mnstr2, 6) + 1, Mnstr3 is mod(Mnstr3, 6) + 1,
    random(1,1000,Cnt1), random(1,1000,Cnt2), random(1,1000,Cnt3),
    Cnt1 is mod(Cnt1, 6), Cnt2 is mod(Cnt2, 6), Cnt3 is mod(Cnt3, 6),
    write('You have to slain '), write(Cnt1), monster(Mnstr1,Name,_,_,_,_), write(Name), nl,
    write('You have to slain '), write(Cnt2), monster(Mnstr2,Name,_,_,_,_), write(Name), nl,
    write('You have to slain '), write(Cnt3), monster(Mnstr3,Name,_,_,_,_), write(Name),
    asserta(countMonster1(Name,Cnt1)),
    asserta(countMonster2(Name,Cnt2)),
    asserta(countMonster3(Name,Cnt3)).

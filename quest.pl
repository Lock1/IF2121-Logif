:-dynamic(countMonster1/2).
:-dynamic(countMonster2/2).
:-dynamic(countMonster3/2).


quest :-
    player(Userame), randomize, monster(ID,Name,_,_,_,_),
    write('Hello, '), write(Username), write('It\'s time for some adventure'), nl,
    random(1,500,Mnstr1), random(1,500,Mnstr2), random(1,500,Mnstr3), Mnstr1 is Mnstr1 mod 7, Mnstr2 is Mnstr2 mod 7, Mnstr3 is Mnstr3 mod 7,
    random(1,1000,Cnt1), random(1,1000,Cnt2), random(1,1000,Cnt3), Cnt1 is Cnt1 mod 6, Cnt2 is Cnt2 mod 6, Cnt3 is Cnt3 mod 6,
    write('You have to slain '), write(Cnt1), monster(Mnstr1,Name,_,_,_,_), write(Name), nl,
    write('You have to slain '), write(Cnt2), monster(Mnstr2,Name,_,_,_,_), write(Name), nl,
    write('You have to slain '), write(Cnt3), monster(Mnstr3,Name,_,_,_,_), write(Name),
    asserta(countMonster1(Name,Count1)),
    asserta(countMonster2(Name,Count2)),
    asserta(countMonster3(Name,Count3)).
width(25).
height(10).
:- dynamic(position/2).
:- dynamic(shop/2).
:- dynamic(unpassable/2).
:- dynamic(dragon/2).
:- dynamic(player/2).

/*Random dragon and shop*/
initObject :-
    width(W),
    height(H),
    random(5,W,Absis1),
    random(5,H,Ordinat1),
    random(5,W,Absis2),
    random(5,H,Ordinat2),
    asserta(dragon(Absis1, Ordinat1)),
    asserta(shop(Absis2, Ordinat2)).

/*R*/
setMap(X,Y) :-
    height(H),
    width(W),
    X =:= W+1,
    Y =< H+1,
    write('#'), nl,
    Y2 is Y+1,
    setMap(0, Y2).

/*L*/
setMap(X,Y) :-
    height(H),
    X =:= 0,
    Y =< H+1,
    write('#'),
    X2 is X+1,
    setMap(X2, Y).

/*T*/
setMap(X,Y) :-
    width(W),
    X > 0,
    X < W+1,
    Y =:= 0,
    write('#'),
    X2 is X+1,
    setMap(X2, Y).

/*B*/
setMap(X,Y) :-
    width(W),
    height(H),
    X > 0,
    X < W + 1,
    Y =:= H+1,
    write('#'),
    X2 is X+1,
    setMap(X2, Y).

setMap(X,Y) :-
    width(W),
    height(H),
    X > 0,
    X < W+1,
    Y > 0,
    Y < H+1,
    dragon(X, Y), !,
    write('D'),
    X2 is X+1,
    setMap(X2, Y).

/*empty*/
setMap(X,Y) :-
    width(W),
    height(H),
    X > 0,
    X < W+1,
    Y> 0,
    Y< H+1,
    write('.'),
    X2 is X+1,
    setMap(X2, Y).

map :-
    setMap(0,0), !.
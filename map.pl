width(50).
height(25).
:- dynamic(position/2).
:- dynamic(shop/2).
:- dynamic(unpassable/2).
:- dynamic(dragon/2).
:- dynamic(playerLocation/2).

/*Random dragon and shop*/
setInitialMap :-
    randomize,
    width(W),
    height(H),
    random(40,W,Absis1),
    random(20,H,Ordinat1),
    random(40,W,Absis2),
    random(1,10,Ordinat2),
    random(1,5,Absis3),
    random(1,5,Ordinat3),
    asserta(dragon(Absis1, Ordinat1)),
    asserta(shop(Absis2, Ordinat2)),
    asserta(playerLocation(Absis3, Ordinat3)).

/*R*/
setMap(X,Y) :-
    height(H),
    width(W),
    X =:= W+1,
    Y =< H+1,
    write('█'), nl,
    Y2 is Y+1,
    setMap(0, Y2),!.

/*L*/
setMap(X,Y) :-
    height(H),
    X =:= 0,
    Y =< H+1,
    write('█'),
    X2 is X+1,
    setMap(X2, Y),!.

/*U*/
setMap(X,Y) :-
    width(W),
    X > 0,
    X < W+1,
    Y =:= 0,
    write('━'),
    X2 is X+1,
    setMap(X2, Y),!.

/*D*/
setMap(X,Y) :-
    width(W),
    height(H),
    X > 0,
    X < W + 1,
    Y =:= H+1,
    write('━'),
    X2 is X+1,
    setMap(X2, Y),!.






/* Entity */
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
    setMap(X2, Y),!.

setMap(X,Y) :-
    width(W),
    height(H),
    X > 0,
    X < W+1,
    Y > 0,
    Y < H+1,
    playerLocation(X, Y), !,
    write('@'),
    X2 is X+1,
    setMap(X2, Y),!.

/*empty*/
setMap(X,Y) :-
    width(W),
    height(H),
    X > 0,
    X < W+1,
    Y> 0,
    Y< H+1,
    write('░'),
    X2 is X+1,
    setMap(X2, Y),!.


map(X) :-
    X is 0, setMap(0,0), !;
    X is 1, setMap(0,0), !.

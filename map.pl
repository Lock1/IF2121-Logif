width(50).
height(25).
:- dynamic(position/2).
:- dynamic(shop/2).
:- dynamic(quest/2).
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
    random(20,30,Absis4),
    random(20,30,Ordinat4),
    asserta(dragon(Absis1, Ordinat1)),
    asserta(shop(Absis2, Ordinat2)),
    asserta(playerLocation(Absis3, Ordinat3)),
    asserta(quest(Absis4, Ordinat4)),
    asserta(quest(Absis3, Ordinat2)).

setMap(X,Y) :- /*Draw Right Border*/
    height(H),
    width(W),
    X =:= W+1,
    Y =< H+1,
    write('█'), nl,
    Y2 is Y+1,
    setMap(0, Y2),!;

    height(H),  /*Draw Left Border*/
    X =:= 0,
    Y =< H+1,
    write('█'),
    X2 is X+1,
    setMap(X2, Y),!;

    width(W), /*Draw Upper Border*/
    X > 0,
    X < W+1,
    Y =:= 0,
    write('━'),
    X2 is X+1,
    setMap(X2, Y),!;

    width(W), /*Draw Bottom Border*/
    height(H),
    X > 0,
    X < W + 1,
    Y =:= H+1,
    write('━'),
    X2 is X+1,
    setMap(X2, Y),!;

    width(W), /*Draw Dragon*/
    height(H),
    X > 0,
    X < W+1,
    Y > 0,
    Y < H+1,
    dragon(X, Y), !,
    write('D'),
    X2 is X+1,
    setMap(X2, Y),!;

    width(W), /*Draw quest*/
    height(H),
    X > 0,
    X < W+1,
    Y > 0,
    Y < H+1,
    quest(X, Y), !,
    write('Q'),
    X2 is X+1,
    setMap(X2, Y),!;

    width(W), /*Draw Player*/
    height(H),
    X > 0,
    X < W+1,
    Y > 0,
    Y < H+1,
    playerLocation(X, Y), !,
    write('@'),
    X2 is X+1,
    setMap(X2, Y),!;

    width(W), /*Draw Empty*/
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

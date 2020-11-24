/*harga potion berapa? anggap 10 gold*/
/*harga gacha berapa? anggap 50 gold*/


shop:-
    /*deket shop*/
    write('Perintah / gold'),nl,
    write('- potion / 10'), nl,
    write('- gacha / 50'), nl,
    write('- quit'), nl,
    write('Tuliskan g untuk gacha dan p untuk potion!'), nl,
    write('> '),
    get_key(X), nl,
    (
        X = 103,
        gacha;

        X = 112,
        beliPotion;

        X = 113
    ),
    % TODO : Print
    prompt,
    nl, !.


/*beli potion gagal, duid ga cukup*/
beliPotion:-
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    Gold < 10,
    write('Uang kamu tidak cukup, silahkan farming dulu'), nl,
    write('Pencet sembarang tombol!'), nl,
    get_key_no_echo(X),!;


/*beli potion berhasil, duid cukup*/
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    Gold > 10,
    NewGold is Gold-10,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)),
    random(1,9,P),
    /*add potion, addItem(P),*/
    write('Kamu berhasil membeli potion'),
    /*Cara Nambahin Potion ke inventory gimana? formatnya berbeda gitu*/
    shop, !.

/*Gacha Gagal, duid ga cukup*/
gacha:-
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    Gold < 50,
    write('Uang kamu tidak cukup, silahkan farming dulu'), nl;
    % write('Pencet sembarang tombol!'), nl,
    % get_key_no_echo(X),!;

/*Gacha Berhasil(uang cukup)*/
    randomize,
    statPlayer(Tipe,_,_,_,_,_,_,_,Gold),
    item(_,Tipe,_,_,_,_),
    Gold >= 50,
    findall(Y, item(_,_,_,Y,_,_), L),
    % sekarang baru ada 5 item per masing masing kategori, disusun ngurut dari yang menurut kita paling bagus
    random(1, 100, Peluang),
    (
        Peluang =< 10, Peluang > 1,
        nth(0, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        write('You get '), write(X), nl;

        Peluang =< 30, Peluang > 10,
        nth(1, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        write('You get '), write(X), nl;

        Peluang =< 55, Peluang > 30,
        nth(2, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        write('You get '), write(X), nl;

        Peluang =< 70, Peluang > 55,
        nth(3, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        write('You get '), write(X), nl;

        Peluang < 100, Peluang > 70,
        nth(4, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        write('You get '), write(X), nl;

        Peluang = 1,
        write('\33\[31\33\[1mMaaf kamu tidak beruntung, mohon untuk menghubungi truck-kun lagi :)\33\[m\n'),
        halt
    ),
    NewGold is Gold-50,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)).

/*keluar:-
    .
*/

/*gagal, shop ga pada tempatnya*/
shop:-
    \+deketshop(_),
    write('gabisa beli disini woy, gaada yang jualan. Pergi ketempat shop sono!'),!.

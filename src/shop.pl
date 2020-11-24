/*harga potion berapa? anggap 10 gold*/
/*harga gacha berapa? anggap 50 gold*/


shop:-
    /*deket shop*/
    write('Perintah / gold'),nl,
    write('- potion / 10'), nl,
    write('- gacha / (40 - 70)'), nl,
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
    random(-10,20,CostSpread),
    GachaCost is 50 + CostSpread,
    Gold >= GachaCost,
    format('You spent \33\[33m%d\33\[m gold.\n', [GachaCost]),
    findall(Y, item(_,_,_,Y,_,_), L),
    % sekarang baru ada 5 item per masing masing kategori, disusun ngurut dari yang menurut kita paling bagus
    random(1, 10000, Peluang),
    (
        Peluang =< 1000, Peluang > 1,
        nth(0, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]);

        Peluang =< 3000, Peluang > 1000,
        nth(1, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]);

        Peluang =< 5500, Peluang > 3000,
        nth(2, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]);

        Peluang =< 7000, Peluang > 5500,
        nth(3, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]);

        Peluang < 10000, Peluang > 7000,
        nth(4, L, X),
        item(Item_id, _,_, X, _, _),
        addItem(Item_id),
        format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]);

        Peluang = 1, % 0.01% chance to quit
        flush_output,
        write('\33\[31m\33\[1mMaaf kamu tidak beruntung, mohon untuk menghubungi truck-kun lagi :)\33\[m\n'),
        halt
    ),
    NewGold is Gold - GachaCost,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)).

/*keluar:-
    .
*/

/*gagal, shop ga pada tempatnya*/
shop:-
    write('gabisa beli disini woy, gaada yang jualan. Pergi ketempat shop sono!'),!.

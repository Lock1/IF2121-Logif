:- dynamic(inventory/6).
:- dynamic(statPlayer/9).

/harga potion berapa? anggap 10 gold/
/harga gacha berapa? anggap 50 gold/


shop:-
    /deket shop/
    write("Perintah , harga(gold)"),nl,
    write("-beliPotion, 10"),nl,
    write("-gacha, 50"),nl,
    write("-keluar, 0"),nl,
    write('Tuliskan perintah diakhiri tanda titik'), nl,!.


/beli potion gagal, duid ga cukup/
beliPotion:-
    statPlayer(_,_,_,_,_,_,_,_,_,Gold),
    Gold < 10,
    write("Uang kamu tidak cukup, silahkan farming dulu"),!.


/beli potion berhasil, duid cukup/
beliPotion:-
    statPlayer(_,_,_,_,_,_,_,_,_,Gold),
    Gold > 10,
    NewGold is Gold-10,
    retract(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, NewGold)),
    random(1,9,P),
    /add potion, addItem(P),/
    write('Kamu berhasil membeli potion'),
    /Cara Nambahin Potion ke inventory gimana? formatnya berbeda gitu/
    shop, !.

/Gacha Gagal, duid ga cukup/
gacha:-
    statPlayer(_,_,_,_,_,_,_,_,_,Gold),
    Gold < 50,
    write("Uang kamu tidak cukup, silahkan farming dulu"),!.

/Gacha Berhasil(uang cukup)/
gacha:-
    statPlayer(_,_,Tipe,_,_,_,_,_,_,Gold),
    Gold >= 50,
    findall(X, item(_,Tipe,_,X,_,_), L), % sekarang baru ada 5 item per masing masing kategori, disusun ngurut dari yang menurut kita paling bagus 
    random(0, 100, Peluang),
    (
        Peluang <= 10 ->
        B is nth0(0, L, X),
        item(Item_id, _,_, B, _, _),
        addItem(Item_id),
        write('You get '), write(B), nl;
        (
        Peluang <= 30, Peluang > 10 ->
        B is nth0(1, L, X),
        item(Item_id, _,_, B, _, _),
        addItem(Item_id),
        write('You get '), write(B), nl;
        (
        Peluang <= 55, Peluang > 30 ->
        B is nth0(2, L, X),
        item(Item_id, _,_, B, _, _),
        addItem(Item_id),
        write('You get '), write(B), nl;
        (
        Peluang <= 70, Peluang > 55 -> 
        B is nth0(3, L, X),
        item(Item_id, _,_, B, _, _),
        addItem(Item_id),
        write('You get '), write(B), nl;
        (
        Peluang <100, Peluang > 70 ->
        B is nth0(4, L, X),
        item(Item_id, _,_, B, _, _),
        addItem(Item_id),
        write('You get '), write(B), nl.
        )
        )
        )
        )
    ),
    NewGold is Gold-50,
    retract(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, NewGold)),
    shop.

keluar:-
    .


/gagal, shop ga pada tempatnya/
/
shop:-
    not deketshop(_)
    write('gabisa beli disini woy, gaada yang jualan. Pergi ketempat shop sono!'),!.









/*harga potion berapa? anggap 10 gold*/
/*harga gacha berapa? anggap 50 gold*/


shop:-
    /*deket shop*/
    write('\33\[37m\33\[1mSelamat datang pada tempat pembakaran\33\[m \33\[33m\33\[1muang\33\[m\33\[37m\33\[1m!'), nl,
    write('Ini adalah barang yang dapat dibeli \33\[m'),nl,
    write('• \33\[35m\33\[1mpotion\33\[m \33\[33m\33\[1m10 gold\33\[m'), nl,
    write('• \33\[35m\33\[1mgacha\33\[m  \33\[33m\33\[1m40\33\[m \33\[37m\33\[1mhingga\33\[m \33\[33m\33\[1m70 gold\33\[m'), nl,
    write('Tekan sembarang tombol untuk quit shop'), nl,
    write('Tuliskan inisial untuk membeli barang'), nl,
    write('> '),
    get_key(X), nl, nl,
    (
        X = 103,
        gacha, prompt, !;

        X = 112,
        beliPotion, prompt, !;

        !
    ),
    !.


/*beli potion gagal, duid ga cukup*/
beliPotion:-
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    Gold < 10,
    write('\33\[33m\33\[1mUang\33\[m kamu \33\[31m\33\[1mtidak cukup\33\[m, silahkan farming dulu :)'), nl;


/*beli potion berhasil, duid cukup*/
    randomize,
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    Gold > 10,
    findall(Nama, potion(_,Nama,_,_), L),
    random(1,100,Peluang),

    (
        Peluang =< 10, Peluang > 1,
        nth(0, L, Nama1),
        potion(PotionID,Nama1,_,_),
        addItem(PotionID),
        write('You get '), write(Nama1), nl;

        Peluang =< 30, Peluang > 10,
        nth(1, L, Nama1),
        potion(PotionID,Nama1,_,_),
        addItem(PotionID),
        write('You get '), write(Nama1), nl;

        Peluang =< 55, Peluang > 30,
        nth(2, L, Nama1),
        potion(PotionID,Nama1,_,_),
        addItem(PotionID),
        write('You get '), write(Nama1), nl;

        Peluang =< 70, Peluang > 55,
        nth(3, L, Nama1),
        potion(PotionID,Nama1,_,_),
        addItem(PotionID),
        write('You get '), write(Nama1), nl;

        Peluang < 100, Peluang > 70,
        nth(4, L, Nama1),
        potion(PotionID,Nama1,_,_),
        addItem(PotionID),
        write('You get '), write(Nama1), nl

    ),

    NewGold is Gold-10,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)).

/*Gacha Gagal, duid ga cukup*/ % TODO : randomizer drop
gacha:-
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    Gold < 40,
    write('\33\[33m\33\[1mUang\33\[m kamu \33\[31m\33\[1mtidak cukup\33\[m, silahkan farming dulu :)'), nl;


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
        nth(0, L, X);

        Peluang =< 3000, Peluang > 1000,
        nth(1, L, X);

        Peluang =< 5500, Peluang > 3000,
        nth(2, L, X);

        Peluang =< 7000, Peluang > 5500,
        nth(3, L, X);

        Peluang < 10000, Peluang > 7000,
        nth(4, L, X);
% TODO : More


        Peluang = 1, % 0.01% chance to quit
        flush_output,
        write('\33\[31m\33\[1mMaaf kamu tidak beruntung, mohon untuk menghubungi truck-kun lagi :)\33\[m\n'),
        halt
    ),
    item(Item_id, _,_, X, _, _),
    addItem(Item_id),
    format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]),

    NewGold is Gold - GachaCost,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)).

/*keluar:-
    .
*/

/*gagal, shop ga pada tempatnya*/
shopError:-
    write('gabisa beli disini woy, gaada yang jualan. Pergi ketempat shop sono!').

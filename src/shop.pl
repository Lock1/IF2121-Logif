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
    Gold >= 10,
    findall(Nama, potion(_,Nama,_,_), L),
    % random(1,10000,Peluang),
    % (
    %     Peluang =< 4000, Peluang > 0, nth(0, L, Nama1), !;
    %     Peluang =< 4500, Peluang > 4000, nth(1, L, Nama1), !;
    %     Peluang =< 4750, Peluang > 4500, nth(2, L, Nama1), !;
    %     % Peluang =< 5000, Peluang > 4750, nth(3, L, Nama1), !;
    %
    %     Peluang =< 9000, Peluang > 5000, nth(4, L, Nama1), !;
    %     Peluang =< 9500, Peluang > 9000, nth(5, L, Nama1), !;
    %     Peluang =< 9750, Peluang > 9500, nth(6, L, Nama1), !;
    %     Peluang =< 10000, Peluang > 9750, nth(7, L, Nama1), !
    % ),
    % random(1,7,Rx),
    random(0,9,Rx), % TODO : Extra, dunno
    nth(Rx, L, Nama1),

    potion(PotionID,Nama1,_,_),
    addItem(PotionID),
    format('You get \33\[33m\33\[1m%s\33\[m!\n',[Nama1]),
    NewGold is Gold-10,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)), !;
    write('\33\[37m\33\[1mMaaf anda tidak beruntung\33\[m\33\[2m :)\33\[m'), nl.

/*Gacha Gagal, duid ga cukup*/
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
    random(1, 15, Peluang), nth(Peluang, L, X),
    % (
    %     Peluang =< 1000, Peluang > 1,
    %     nth(0, L, X);
    %
    %     Peluang =< 3000, Peluang > 1000,
    %     nth(1, L, X);
    %
    %     Peluang =< 5500, Peluang > 3000,
    %     nth(2, L, X);
    %
    %     Peluang =< 7000, Peluang > 5500,
    %     nth(3, L, X);
    %
    %     Peluang < 10000, Peluang > 7000,
    %     nth(4, L, X);
    %
    %
    %
    %     Peluang = 1, % 0.01% chance to quit
    %     flush_output,
    %     write('\33\[31m\33\[1mMaaf kamu tidak beruntung, mohon untuk menghubungi truck-kun lagi :)\33\[m\n'),
    %     halt
    % ),



    item(Item_id, _,_, X, _, _),
    addItem(Item_id), % TODO : Random
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

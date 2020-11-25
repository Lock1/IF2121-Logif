
/* ------------------------------------- Shop Section -------------------------------------
13519170 / La Ode Rajuh Emoko
harga potion berapa? anggap 10 gold
harga gacha berapa? anggap 50 gold*/


shop:-
    /*deket shop*/
    write('\33\[37m\33\[1mSelamat datang pada tempat pembakaran\33\[m \33\[33m\33\[1muang\33\[m\33\[37m\33\[1m!'), nl,
    write('Ini adalah barang yang dapat dibeli \33\[m'),nl,
    write('• \33\[35m\33\[1mpotion\33\[m \33\[33m\33\[1m40 gold\33\[m \33\[37m\33\[1mhingga\33\[m \33\[33m\33\[1m150 gold\33\[m (\33\[36m\33\[1mb\33\[m)'), nl,
    write('• \33\[35m\33\[1mgacha potion\33\[m \33\[33m\33\[1m10 gold\33\[m (\33\[36m\33\[1mp\33\[m)'), nl,
    write('• \33\[35m\33\[1mgacha\33\[m  \33\[33m\33\[1m40\33\[m \33\[37m\33\[1mhingga\33\[m \33\[33m\33\[1m70 gold\33\[m (\33\[36m\33\[1mg\33\[m)'), nl,
    write('Tekan sembarang tombol untuk quit shop'), nl,
    write('Tuliskan inisial untuk membeli barang'), nl,
    write('\33\[32m\33\[1mShop >> \33\[m'),
    get_key(X), nl, nl,
    (
        X = 103,
        gacha, prompt, !;

        X = 112,
        beliPotion, prompt, !;

        X = 98,
        beliPotionID, prompt, !;

        !
    ),
    !.

beliPotionID :-
    write('\33\[37m\33\[1mList Potion\33\[m'), nl,
    write('┏━━━┯━━━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━┓'), nl,
    write('┃ 1 │ \33\[31m\33\[1mLesser Healing Potion\33\[m   │ \33\[33m\33\[1m 40 gold\33\[m ┃'), nl,
    write('┃ 2 │ \33\[31m\33\[1mHealing Potion\33\[m          │ \33\[33m\33\[1m 70 gold\33\[m ┃'), nl,
    write('┃ 3 │ \33\[31m\33\[1mGreater Healing Potion\33\[m  │ \33\[33m\33\[1m100 gold\33\[m ┃'), nl,
    write('┃ 4 │ \33\[31m\33\[1mAlkohol\33\[m                 │ \33\[33m\33\[1m150 gold\33\[m ┃'), nl,
    write('┃ 5 │ \33\[36m\33\[1mLesser Mana Potion\33\[m      │ \33\[33m\33\[1m 40 gold\33\[m ┃'), nl,
    write('┃ 6 │ \33\[36m\33\[1mMana Potion\33\[m             │ \33\[33m\33\[1m 70 gold\33\[m ┃'), nl,
    write('┃ 7 │ \33\[36m\33\[1mGreater Mana Potion\33\[m     │ \33\[33m\33\[1m100 gold\33\[m ┃'), nl,
    write('┃ 8 │ \33\[36m\33\[1mOkultisme\33\[m               │ \33\[33m\33\[1m150 gold\33\[m ┃'), nl,
    write('┗━━━┷━━━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━┛'), nl,

    write('Tulis angka untuk membeli potion'), nl,
    write('\33\[32m\33\[1mShop >> \33\[m'), get_key(X), nl,
    statPlayer(_,_,_,_,_,_,_,_,Gold),
    (
        X = 49, Gold >= 40, NewGold is Gold-40, addItem(16), write('\33\[33m\33\[1mLesser Healing Potion\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 50, Gold >= 70, NewGold is Gold-70, addItem(17), write('\33\[33m\33\[1mHealing Potion\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 51, Gold >= 100, NewGold is Gold-100, addItem(18), write('\33\[33m\33\[1mGreater Healing Potion\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 52, Gold >= 150, NewGold is Gold-150, addItem(19), write('\33\[33m\33\[1mAlkohol\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 53, Gold >= 40, NewGold is Gold-40, addItem(20), write('\33\[33m\33\[1mLesser Mana Potion\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 54, Gold >= 70, NewGold is Gold-70, addItem(21), write('\33\[33m\33\[1mMana Potion\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 55, Gold >= 100, NewGold is Gold-100, addItem(22), write('\33\[33m\33\[1mGreater Mana Potion\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        X = 56, Gold >= 150, NewGold is Gold-150, addItem(23), write('\33\[33m\33\[1mOkultisme\33\[m \33\[37m\33\[1mtelah dibeli!\33\[m\n'), !;
        NewGold is Gold, write('Silahkan farming dulu :)\n')
    ),

    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)),
    !.

/*beli potion gagal, duid ga cukup*/
beliPotion :-
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
    % random(0,9,Rx), % TODO : Non essential, non uniform random distribution
    % nth(Rx, L, Nama1),

    random(0,8,PotionID),
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
    % random(1, 15, Peluang), nth(Peluang, L, X),
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
    %     Peluang < 10000, Peluang > 7000, % FIXME : Taking Quest but back to command mode causing some problem
    %     nth(4, L, X);
    %
    %
    %
    %     Peluang = 1, % 0.01% chance to quit
    %     flush_output,
    %     write('\33\[31m\33\[1mMaaf kamu tidak beruntung, mohon untuk menghubungi truck-kun lagi :)\33\[m\n'),
    %     halt
    % ),


    random(1, 15, Peluang),
    item(Peluang, _,_, X, _, _),
    addItem(Peluang),
    format('You get \33\[33m\33\[1m%s\33\[m!\n',[X]),

    NewGold is Gold - GachaCost,
    retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, NewGold)).

/*keluar:-
    .
*/

/*gagal, shop ga pada tempatnya*/
shopError:-
    write('\33\[31m\33\[1mgabisa beli disini woy, gaada yang jualan. Pergi ketempat shop sono!\33\[m\n').

/* ---------------------------------------------------------------------------------------- */

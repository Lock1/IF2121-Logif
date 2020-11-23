:- dynamic(enemy/6).
:- dynamic(statPlayer/9).
:- dynamic(isEnemyAlive/1).
:- dynamic(isFighting/1).
:- dynamic(peluang/1).
:- dynamic(isRun/1).

/********Ketemu Musuh************/
encounterEnemy:-
	random(1, 7, ID),
	monster(ID, Nama, HP, Atk, Def, XP),
	asserta(enemy(ID, Nama, HP, Atk, Def, XP)),
	write('\33\[m'), flush_output,
	write('Kamu ketemu '), write(Nama), write(' !!'), nl,
	write('Apa yang akan kamu lakukan?'), nl,
	write('- Fight'), nl,
	write('- Run'), nl,
	write('Tuliskan perintah diakhiri tanda titik'), nl,
	random(1, 10, P),
	asserta(peluang(P)),
	asserta(isEnemyAlive(1)),
	battleLoop.

/********Lari*************/

/********Mau Lari tapi belum ketemu musuh******/
run :-
	\+ isEnemyAlive(_),
	write('Kamu belum ketemu musuh lho'),
	!.

/***********Gagal Lari *********/
run :-
	\+ isRun(_),
	isEnemyAlive(_),
	peluang(P),
	P =< 4,
	write('Kamu gagal run. Semangat bertarung~~'), nl,
	retract(peluang(P)),
	asserta(isRun(1)),
	fight,
	!.

/************Berhasil Lari************/
run :-
	\+ isRun(_),
	isEnemyAlive(_),
	peluang(P),
	P > 4,
	retract(peluang(P)),
	retract(isEnemyAlive(_)),
	retract(enemy(_, _, _, _, _, _)),
	!.

/*********Mau Lari tapi udah berhadapan dengan musuh******/
run :-
	isRun(_),
	write('Kamu udah gagal run lho, jangan lari lagi'), nl,
	!.

/*******************FIGHT********************/
/********Belum ketemu musuh*********/
fight :-
	\+ isEnemyAlive(_),
	write('Kamu belum ketemu musuh. Mau nyerang siapa?'), nl,
	!.

/********Berhasil Bertarung*********/
fight :-
	asserta(isRun(1)),
	asserta(isFighting(1)),
	isEnemyAlive(_),
	!.

/********Sudah ketemu musuh tapi fight lagi*******/
fight :-
	isFighting(_),
	isEnemyAlive(_),
	write('Kamu sedang melawan musuh loh'), nl,
	!.

/******************ATTACK**********************/
/********Comment kalau musuh masih belum kalah********/
attackComment :-
	enemy(_, NamaEnemy, HPEnemy, _, _, _),
	HPEnemy > 0,
	write('Darah '), write(NamaEnemy), write('tersisa '), write(HPEnemy), nl,
	enemyTurn,
	!.

/********Comment kalau musuh sudah kalah********/
attackComment :-
	enemy(_, NamaEnemy, HPEnemy, _, _, XPDrop),
	HPEnemy =< 0,
	write(NamaEnemy), write('telah kalah!'), nl,
	statPlayer(_,_,_,_,_,_,Level,XPPlayer,_),
	NewXP is (XPPlayer + XPDrop),
	retract(enemy(_,_,_,_,_,_)),
	retract(isRun(_)),
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, _, Gold)),
	asserta(statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, NewXP, Gold)),
	cekNaikLevel(Level, NewXP),
	!.

/********Belum ketemu musuh*********/
attack :-
	\+ isEnemyAlive(_),
	write('Kamu belum ketemu musuh, mau nyerang siapa?'), nl,
	!.

/*StatPlayernya belum diimplementasikan*/
/*Formatnya statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, XP, Gold)*/
/***********Attack biasa********/
attack :-
	isEnemyAlive(_),
	statPlayer(_,_,_,_,AtkPlayer,_,_,_,_),
	enemy(_, _, HPEnemy, _, DefEnemy, _),
	NewHPEnemy is (HPEnemy - (AtkPlayer - DefEnemy)),
	retract(enemy(IDenemy, NamaEnemy, HPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	asserta(enemy(IDenemy, NamaEnemy, NewHPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	write('Kamu menggunakan attack!'), nl,
	attackComment,
	!.
% TODO : Special attack using mana
% TODO : cekNaikLevel


/**********************ATTACK MUSUH***********************/
/********Comment kalau pemain masih belum kalah********/
enemyAttackComment :-
	statPlayer(_,_,HPPlayer,Mana,_,_,_,_,_,_),
	HPPlayer > 0,
	write('Darah kamu tersisa '), write(HPPlayer), write('dan Mana kamu tersisa '), write(Mana), nl,
	!.

/********Comment kalau pemain sudah kalah********/
enemyAttackComment :-
	statPlayer(_,_,HPPlayer,_,_,_,_,_,_,_),
	HPPlayer =< 0,
	write('Darah kamu sudah habis'), nl,
	write('Kamu mati'), nl,
	lose,
	!.

/*********Serangan dari musuh****************/
enemyAttack :-
	enemy(_, NamaEnemy, _, AtkEnemy,_, _),
	statPlayer(_,_,HPPlayer,_,_,DefPlayer,_,_,_,_),
	Serangan is (AtkEnemy - DefPlayer),
	NewHP is (HPPlayer - (AtkEnemy - DefPlayer)),
	write(NamaEnemy), write(' melakukan serangan sebesar '), write(Serangan), nl,
	retract(statPlayer(IDTipe, Nama, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, Gold)),
	asserta(statPlayer(IDTipe, Nama, NewHP, mana, Atk, DefPlayer, Lvl, XP, Gold)),
	enemyAttackComment,
	!.



% -------------------- Battle Loop --------------------

battleLoop :-
    repeat,
    write('> '),
    catch(read(X), error(_,_), errorMessage), (
        X = 'attack', call(attack);
        X = 'fight', call(fight);
        X = 'run', call(run);
        X = 'quit', call(quit)
    ),
    fail.


/***********************KALAH********************************/
lose :-
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(isRun(_)),
	quit.

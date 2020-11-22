:- dynamic(enemy/6).
:- dynamic(isEnemyAlive/1).
:- dynamic(isFighting/1).
:- dynamic(peluang/1).
:- dynamic(isRun/1).

/********Ketemu Musuh************/
encounterEnemy:-
	random(1, 7, ID),
	monster(ID, Nama, HP, Atk, Def, XP),
	asserta(enemy(ID, Nama, HP, Atk, Def, XP)),
	write('Kamu ketemu '), write(Nama), write('!!'), nl,
	write('Apa yang akan kamu lakukan?'), nl,
	write('-fight'), nl,
	write('-run'),
	write('Tuliskan perintah diakhiri tanda titik'),
	random(1, 10, P),
	asserta(peluang(P)),
	asserta(isEnemyAlive(1)).
	
/********Lari*************/

/********Mau Lari tapi belum ketemu musuh******/
run :-
	not isEnemyAlive(_),
	write('Kamu belum ketemu musuh lho'),
	!.
	
/***********Gagal Lari *********/
run :-
	not isRun(_),
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
	not isRun(_),
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
	write('Kamu udah gagal run lho, jangan lari lagi'),
	!.

/*******************FIGHT********************/
/********Belum ketemu musuh*********/
fight :-
	not isEnemyAlive(_),
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
	statPlayer(_,_,_,_,_,_,_,_,Level,XPPlayer),
	NewXP is (XPPlayer + XPDrop),
	retract(enemy(_,_,_,_,_,_)),
	retract(isRun(_)),
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(statPlayer(IDTipe, Nama, Tipe, HP, mana, Atk, Def, Lvl, XP, Gold)),
	asserta(statPlayer(IDTipe, Nama, Tipe, HP, mana, Atk, Def, Lvl, NewXPXP, Gold)),
	cekNaikLevel(Level, NewXP),
	!.

/********Belum ketemu musuh*********/
attack :-
	not isEnemyAlive(_),
	write('Kamu belum ketemu musuh, mau nyerang siapa?'), nl,
	!.
	
/*StatPlayernya belum diimplementasikan*/
/*Formatnya statPlayer(IDTipe, Nama, Tipe, HP, mana, Atk, Def, Lvl, XP, Gold)*/
/***********Attack biasa********/
attack :-
	isEnemyAlive(_),
	statPlayer(_,_,HPPlayer,Mana,AtkPlayer,DefPlayer,_,_,_,_),
	enemy(_, _, HPEnemy, _, DefEnemy, _),
	NewHPEnemy is (HPEnemy - (AtkPlayer - DefEnemy)),
	retract(enemy(IDenemy, NamaEnemy, HPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	asserta(enemy(IDenemy, NamaEnemy, NewHPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	write('Kamu menggunakan attack!'), nl,
	attackComment,
	!.
	
	
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
	enemy(_, NamaEnemy, HPEnemy, AtkEnemy,_, _),
	statPlayer(_,_,HPPlayer,_,_,DefPlayer,_,_,_,_),
	Serangan is (AtkEnemy - DefPlayer),
	NewHP is (HPPlayer - (AtkEnemy - DefPlayer)),
	write(NamaEnemy), write(' melakukan serangan sebesar '), write(Serangan), nl,
	retract(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, Gold)),
	asserta(statPlayer(IDTipe, Nama, Tipe, NewHP, mana, Atk, DefPlayer, Lvl, XP, Gold)),
	enemyAttackComment,
	!.
	
	
/***********************KALAH********************************/
lose :-
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(isRun(_)),
	quit.
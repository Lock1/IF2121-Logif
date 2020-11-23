:- dynamic(enemy/6).
:- dynamic(statPlayer/9).
:- dynamic(isEnemyAlive/1).
:- dynamic(isFighting/1).
:- dynamic(peluang/1).
:- dynamic(isRun/1).
:- dynamic(isBattleDone/1).

/********Ketemu Musuh************/
encounterEnemy:-
	random(1, 7, ID),
	monster(ID, Nama, HP, Atk, Def, XP),
	asserta(enemy(ID, Nama, HP, Atk, Def, XP)),
	write('\33\[m'), flush_output,
	format('Kamu ketemu \33\[31m\33\[1m%s\33\[m !!!\n',[Nama]),
	format('Darah \33\[31m\33\[1m%s\33\[m sebanyak \33\[31m%d\33\[m\n',[Nama,HP]),
	write('Apa yang akan kamu lakukan?'), nl,
	write('- fight.'), nl,
	write('- run.'), nl,
	write('Tuliskan perintah diakhiri tanda titik'), nl,
	random(1, 10, P),
	asserta(peluang(P)),
	asserta(isEnemyAlive(1)),
	battleLoop.

/********Lari*************/

/********Mau Lari tapi belum ketemu musuh******/
run :-
	\+ isEnemyAlive(_),
	write('Kamu belum ketemu musuh lho'), nl,
	!;

/***********Gagal Lari *********/

	\+ isRun(_),
	isEnemyAlive(_),
	peluang(P),
	P =< 4,
	write('Kamu gagal run. Semangat bertarung~~ (^///^)'), nl,
	retract(peluang(P)),
	asserta(isRun(1)),
	fight;

/************Berhasil Lari************/

	\+ isRun(_),
	isEnemyAlive(_),
	peluang(P),
	P > 4,
	retract(peluang(P)),
	retract(isEnemyAlive(_)),
	retract(enemy(_, _, _, _, _, _)),
	asserta(isBattleDone(1)),
	flush_output,
	write('Kamu berhasil kabur'), nl,
	sleep(1),
	write('Penakut :('),
	!;

/*********Mau Lari tapi udah berhadapan dengan musuh******/

	isRun(_),
	write('Kamu udah gagal run lho, jangan lari lagi'), nl.

/*******************FIGHT********************/
/********Belum ketemu musuh*********/
fight :-
	\+ isEnemyAlive(_),
	write('Kamu belum ketemu musuh. Mau nyerang siapa?'), nl,
	!;

/********Berhasil Bertarung*********/

	\+ isFighting(_),
	asserta(isRun(1)),
	asserta(isFighting(1)),
	isEnemyAlive(_),
	enemy(_, NamaEnemy, _, _, _, _),
	format('Kamu mencoba melawan \33\[31m\33\[1m%s\33\[m\n', [NamaEnemy]),
	write('Perintah tersedia :\n- attack.\n'); % TODO : add other information

/********Sudah ketemu musuh tapi fight lagi*******/

	isFighting(_),
	isEnemyAlive(_),
	write('Kamu sedang melawan musuh loh'), nl.

/******************ATTACK**********************/
/********Comment kalau musuh masih belum kalah********/
attackComment :-
	enemy(_, NamaEnemy, HPEnemy, _, _, _),
	HPEnemy > 0,
	format('Darah \33\[31m\33\[1m%s\33\[m tersisa \33\[31m%d\33\[m\n',[NamaEnemy,HPEnemy]),
	enemyTurn,
	!;

/********Comment kalau musuh sudah kalah********/

	enemy(_, NamaEnemy, HPEnemy, _, _, XPDrop),
	HPEnemy =< 0,
	format('\33\[31m\33\[1m%s\33\[m telah kalah!\n',[NamaEnemy]),
	statPlayer(_,_,_,_,_,_,Level,XPPlayer,_),
	NewXP is (XPPlayer + XPDrop), % TODO : Random gold drop
	retract(enemy(_,_,_,_,_,_)),
	retract(isRun(_)),
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, _, Gold)),
	format('Kamu dapat \33\[32m%d XP\33\[m!\n\n',[XPDrop]),
	asserta(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, NewXP, Gold)),
	write('Tekan sembarang tombol untuk melanjutkan\n'), sleep(2),
	get_key_no_echo(user_input,_),
	asserta(isBattleDone(1)),
	% cekNaikLevel(Level, NewXP), % TODO : cekNaikLevel
	!.

/********Belum ketemu musuh*********/
attack :-
	\+ isEnemyAlive(_),
	write('Kamu belum ketemu musuh, mau nyerang siapa?'), nl,
	!;

/*Formatnya statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, XP, Gold)*/
/***********Attack biasa********/

	isEnemyAlive(_),
	statPlayer(_,_,_,_,AtkPlayer,_,_,_,_),
	enemy(_, _, HPEnemy, _, DefEnemy, _),
	NewHPEnemy is (HPEnemy - (AtkPlayer - DefEnemy)),
	retract(enemy(IDenemy, NamaEnemy, HPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	asserta(enemy(IDenemy, NamaEnemy, NewHPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	write('\nKamu menggunakan attack!'), nl,
	attackComment,
	!.
% TODO : Special attack using mana
% TODO : cekNaikLevel


/**********************ATTACK MUSUH***********************/
/********Comment kalau pemain masih belum kalah********/
enemyAttackComment :-
	statPlayer(_,_,HPPlayer,Mana,_,_,_,_,_),
	HPPlayer > 0,
	format('Darah \33\[31m\33\[1mkamu\33\[m tersisa \33\[31m%d\33\[m dan mana tersisa \33\[34m%d\33\[m\n',[HPPlayer,Mana]), !;
	% write('Darah kamu tersisa '), write(HPPlayer), write('dan Mana kamu tersisa '), write(Mana), nl,;

/********Comment kalau pemain sudah kalah********/

	statPlayer(_,_,HPPlayer,_,_,_,_,_,_),
	HPPlayer =< 0,
	sleep(1),
	write('Darah kamu sudah habis'), nl,
	sleep(1),
	write('Kamu mati'), nl,
	sleep(1),
	lose, !.

/*********Serangan dari musuh****************/
enemyTurn :-
	enemy(_, NamaEnemy, _, AtkEnemy,_, _),
	statPlayer(_,_,HPPlayer,_,_,DefPlayer,_,_,_),
	Serangan is (AtkEnemy - DefPlayer),
	NewHP is (HPPlayer - (AtkEnemy - DefPlayer)),
	format('\33\[31m\33\[1m%s\33\[m melakukan serangan sebesar \33\[31m%d\33\[m\n',[NamaEnemy,Serangan]),
	retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
	asserta(statPlayer(IDTipe, Nama, NewHP, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
	enemyAttackComment.



% -------------------- Battle Loop --------------------

battleLoop :-
	isBattleDone(_), retract(isBattleDone(_)), clear, !;
	write('Battle >> '),
    catch(read(X), error(_,_), errorMessage), (
        X = 'fight', call(fight);
        X = 'run', call(run);
        X = 'quit', call(quit); % TODO : Complete battle sequence
		isFighting(_), (
			X = 'attack', call(attack)
		)
    ),
    battleLoop, !. % FIXME : Weird behaviour with random command


/***********************KALAH********************************/
lose :-
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(isRun(_)),
	quit.

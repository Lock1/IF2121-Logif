:- dynamic(enemy/6).
:- dynamic(statPlayer/9).
:- dynamic(isEnemyAlive/1).
:- dynamic(isFighting/1).
:- dynamic(peluangLari/1).
:- dynamic(isRun/1).
:- dynamic(isBattleDone/1).

/********Ketemu Musuh*********/
% TODO : Extra, gameloop for legacy version
encounterEnemy(_) :-
	random(1, 7, ID),
	monster(ID, Nama, HP, Atk, Def, XP),
	asserta(enemy(ID, Nama, HP, Atk, Def, XP)),
	write('\33\[m'), sideStatus, write('\33\[1000A\33\[1000D'), flush_output,
	format('\33\[36m\33\[1mKamu\33\[m ketemu \33\[31m\33\[1m%s\33\[m !!!\n',[Nama]),
	format('Darah \33\[31m\33\[1m%s\33\[m sebanyak \33\[31m%d\33\[m\n',[Nama,HP]),
	sleep(0.2),
	write('Apa yang akan \33\[36m\33\[1mkamu\33\[m lakukan?'), nl,
	write('• fight (\33\[31m\33\[1mf\33\[m)'), flush_output, nl,
	write('• status (\33\[36m\33\[1ms\33\[m)'), flush_output, nl,
	write('• run (\33\[33m\33\[1mr\33\[m)'), flush_output, nl,
	write('Tuliskan inisial dari command'), nl,
	random(1, 10, P),
	asserta(peluangLari(P)),
	asserta(isEnemyAlive(1)),
	call(battleLoop).

/********Lari********/

/********Mau Lari tapi belum ketemu musuh******/
run :-
	\+ isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m belum ketemu musuh lho'), nl,
	!;
	/***********Gagal Lari *********/
	\+ isRun(_),
	isEnemyAlive(_),
	peluangLari(P),
	P =< 4,
	write('\33\[36m\33\[1mKamu\33\[m \33\[31m\33\[1mgagal\33\[m run. Semangat bertarung~~ (^///^)'), nl,
	retract(peluangLari(P)),
	asserta(isRun(1)),
	fight;
	/************Berhasil Lari************/
	\+ isRun(_),
	isEnemyAlive(_),
	peluangLari(P),
	P > 4,
	retract(peluangLari(P)),
	retract(isEnemyAlive(_)),
	retract(enemy(_, _, _, _, _, _)),
	asserta(isBattleDone(1)),
	flush_output,
	write('\33\[36m\33\[1mKamu\33\[m \33\[32m\33\[1mberhasil\33\[m kabur'), nl,
	prompt,
	!;
	/*********Mau Lari tapi udah berhadapan dengan musuh******/
	isRun(_),
	write('\33\[36m\33\[1mKamu\33\[m udah gagal run lho, jangan lari lagi'), nl, nl.

/*******************FIGHT********************/
/********Belum ketemu musuh*********/
fight :-
	\+ isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m belum ketemu musuh. Mau nyerang siapa?'), nl, nl,
	!;
	/********Berhasil Bertarung*********/ % TODO : Player crit
	\+ isFighting(_),
	% asserta(isRun(1)), % DEBUG
	asserta(isFighting(1)),
	isEnemyAlive(_),
	enemy(_, NamaEnemy, _, _, _, _),
	format('\33\[36m\33\[1mKamu\33\[m mencoba melawan \33\[31m\33\[1m%s\33\[m\n', [NamaEnemy]),
	write('Perintah tersedia :\n'),
	write('• attack (\33\[31m\33\[1ma\33\[m)'), nl,
	write('• skill (\33\[34m\33\[1mc\33\[m)'), nl,
	write('• status (\33\[36m\33\[1ms\33\[m)'), nl,
	write('• potion (\33\[35m\33\[1me\33\[m)'), nl,
	write('• run (\33\[33m\33\[1mr\33\[m)'), nl, nl;
	% TODO : Extra, status sidebar
	/********Sudah ketemu musuh tapi fight lagi*******/
	isFighting(_), \+ isRun(_),
	isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m sedang melawan musuh loh'), nl, nl.

/******************ATTACK**********************/
/********Comment kalau musuh masih belum kalah********/
attackComment :-
	enemy(_, NamaEnemy, HPEnemy, _, _, _),
	HPEnemy > 0,
	format('Darah \33\[31m\33\[1m%s\33\[m tersisa \33\[31m%d\33\[m\n',[NamaEnemy,HPEnemy]),
	enemyTurn,
	!;
	/********Comment kalau musuh sudah kalah********/
	enemy(EnemyID, NamaEnemy, HPEnemy, _, _, XPDrop),
	HPEnemy =< 0,
	format('\33\[31m\33\[1m%s\33\[m telah kalah!\n',[NamaEnemy]),
	statPlayer(_,_,_,_,_,_,_,XPPlayer,GoldPlayer),
	MaxGoldDrop is 25+XPDrop//2,
	random(5,MaxGoldDrop,GoldDrop),
	random(-5,5,XPSpread),
	NewXP is (XPPlayer + XPDrop + XPSpread),
	NewGold is (GoldPlayer + GoldDrop),
	retract(enemy(_,_,_,_,_,_)),
	% retract(isRun(_)),
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, _, _)),
	format('\n\33\[36m\33\[1mKamu\33\[m dapat \33\[32m\33\[1m%d XP\33\[m!\n',[XPDrop]),
	format('\33\[36m\33\[1mKamu\33\[m dapat \33\[33m\33\[1m%d Gold\33\[m!\n\n',[GoldDrop]),
	asserta(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, NewXP, NewGold)),
	asserta(isBattleDone(1)),
	isQuestDone(EnemyID),
	checkLevelUp,
	prompt, !.
% TODO : Extra, auto fight for qol
/********Belum ketemu musuh*********/
attack :-
	\+ isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m belum ketemu musuh, mau nyerang siapa?'), nl, nl,
	!;

	/*Formatnya statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, XP, Gold)*/
	/***********Attack biasa********/

	isEnemyAlive(_),
	statPlayer(_,_,_,_,BaseAtkPlayer,_,_,_,_),
	enemy(_, _, HPEnemy, _, DefEnemy, _),
	random(-7,5,AtkSpread),
	AtkPlayer is BaseAtkPlayer + AtkSpread,
	NewHPEnemy is (HPEnemy - (AtkPlayer - DefEnemy)),
	retract(enemy(IDenemy, NamaEnemy, HPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	asserta(enemy(IDenemy, NamaEnemy, NewHPEnemy, AtkEnemy, DefEnemy, XPDrop)),
	write('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1mattack\33\[m!'), nl,
	format('Serangan dengan \33\[31m%d\33\[m damage!',[AtkPlayer]), nl,
	call(attackComment),
	!.
% TODO : Special attack using mana


/**********************ATTACK MUSUH***********************/
/********Comment kalau pemain masih belum kalah********/
enemyAttackComment :-
	statPlayer(_,_,HPPlayer,Mana,_,_,_,_,_),
	HPPlayer > 0,
	format('Darah \33\[36m\33\[1mkamu\33\[m tersisa \33\[31m%d\33\[m dan mana tersisa \33\[36m%d\33\[m\n\n',[HPPlayer,Mana]), !;
	/********Comment kalau pemain sudah kalah********/
	statPlayer(_,_,HPPlayer,_,_,_,_,_,_),
	HPPlayer =< 0,
	sleep(0.3),
	write('\33\[31m\33\[1m'),
	flush_output,
	write('Darah kamu sudah habis'), nl,
	sleep(1),
	write('██╗░░░██╗░█████╗░██╗░░░██╗  ██████╗░██╗███████╗██████╗░░░░'), nl,
	write('╚██╗░██╔╝██╔══██╗██║░░░██║  ██╔══██╗██║██╔════╝██╔══██╗░░░'), nl,
	write('░╚████╔╝░██║░░██║██║░░░██║  ██║░░██║██║█████╗░░██║░░██║░░░'), nl,
	write('░░╚██╔╝░░██║░░██║██║░░░██║  ██║░░██║██║██╔══╝░░██║░░██║░░░'), nl,
	write('░░░██║░░░╚█████╔╝╚██████╔╝  ██████╔╝██║███████╗██████╔╝██╗'), nl,
	write('░░░╚═╝░░░░╚════╝░░╚═════╝░  ╚═════╝░╚═╝╚══════╝╚═════╝░╚═╝'), nl,
	write('\33\[m'),
	flush_output,
	sleep(1),
	lose, !.

/*********Serangan dari musuh****************/
enemyTurn :-
	enemy(_, NamaEnemy, _, AtkEnemy,_, _),
	statPlayer(_,_,HPPlayer,_,_,DefPlayer,_,_,_),
	random(-3,4,AtkSpread),
	Serangan is (AtkEnemy - DefPlayer + AtkSpread),
	(
		NewHP is (HPPlayer - (AtkEnemy - DefPlayer)), NewHP =< HPPlayer, !;
		NewHP is HPPlayer, !
	),
	format('\33\[31m\33\[1m%s\33\[m melakukan serangan sebesar \33\[31m%d\33\[m\n',[NamaEnemy,Serangan]),
	retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
	asserta(statPlayer(IDTipe, Nama, NewHP, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
	enemyAttackComment.



% -------------------- Battle Loop --------------------

battleLoop :-
	isBattleDone(_), retract(isBattleDone(_)), !;
	(
		write('\33\[32m\33\[1mBattle >> \33\[m'),
		get_key(X), nl,
		(
	    % % catch(read(X), error(_,_), errorMessage), (
	        X = 102, call(fight), battleLoop, !; % f key
	        X = 114, call(run), battleLoop, !; % r key
	        X = 115, \+status, battleLoop, !; % s key

	        X = 41, call(quit), !; % 1 key
			isFighting(_), (
				X = 97, call(attack), battleLoop, !, % a key
		 		X = 101, call(drinkPot), get_key_no_echo(_), battleLoop, !; % e key
				X = 99, call(specialAttack), battleLoop, ! % c
			);
			write('Tombol tidak diketahui\n\n'), battleLoop, !
	    )
	).



/***********************KALAH********************************/
lose :-
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(isRun(_)),
	halt.

isQuestDone(EnemyID) :-
	questList(EnemyID,Cnt),
	(
	Cnt is 1,
	retract(questList(EnemyID, Cnt)),
	statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, CurrentXP, CurrentGold),
	random(-10,30,XPSpread), random(-25,40,GoldSpread),
	NewXP is CurrentXP + XPSpread + Cnt*10, NewGold is CurrentGold + GoldSpread + 25 + Cnt*30,
	retract(statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, CurrentXP, CurrentGold)),
	asserta(statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, NewXP, NewGold)),
	monster(EnemyID, EnemyName, _, _, _, _),
	format('\33\[33m\33\[1mQuest %s sudah selesai!\33\[m\n',[EnemyName]);

	NewCnt is Cnt-1,
	retract(questList(EnemyID, Cnt)),
	asserta(questList(EnemyID, NewCnt))
	); !.

specialAttack :-
	isEnemyAlive(_),
	statPlayer(Class,Nama,HP,Mana,Atk,Def,Lvl,XP,Gold),
	enemy(_,_,HPEnemy,_,DefEnemy,_),
	special_skill(Class, SName, SMana),
	NewMana is Mana - SMana,
	(
		NewMana >= 0,
		(
			Class = 'swordsman',
			NewDef is Def+999,

			retract(statPlayer(Class, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, Atk, NewDef, Lvl, XP, Gold)),
			format('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1m%s\33\[m!\n',[SName]),
			enemyAttackComment,
			retract(statPlayer(Class, Nama, HP, NewMana, Atk, NewDef, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, Atk, Def, Lvl, XP, Gold));

			Class = 'archer',
			format('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1m%s\33\[m!\n',[SName]),
			% attack, % TODO : Attack split
			attack;

			Class = 'sorcerer',
			SantetAtk is Atk+150,
			retract(statPlayer(Class, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, SantetAtk, Def, Lvl, XP, Gold)),
			format('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1m%s\33\[m!\n',[SName]),
			\+attack,
			retract(statPlayer(Class, Nama, HP, NewMana, SantetAtk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, Atk, Def, Lvl, XP, Gold))
		), !;
		ManaNeeded is (-1)*NewMana,
		format('Kurang \33\[36m\33\[1m%d mana\33\[m untuk \33\[33m\33\[1m%s\33\[m\n', [ManaNeeded,SName]),
		enemyTurn, !
	).
	% NewMana is Mana - SMana,

	%

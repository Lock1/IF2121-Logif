/* ------------------------------------ Battle Section ------------------------------------
13519178 / Akeyla Pradia Naufal
13519214 / Tanur Rizaldi Rahardjo
*/
:- dynamic(enemy/6).
:- dynamic(statPlayer/9).
:- dynamic(isEnemyAlive/1).
:- dynamic(isFighting/1).
:- dynamic(peluangLari/1).
:- dynamic(isRun/1).
:- dynamic(isBattleDone/1).
:- dynamic(isCrit/1).
:- dynamic(turnCount/1).

/********Ketemu Musuh*********/
% TODO : Non essential, gameloop for legacy version
encounterEnemy(_) :-
	random(1, 7, ID),
	asserta(turnCount(1)),
	monster(ID, Nama, HP, Atk, Def, XP),
	asserta(enemy(ID, Nama, HP, Atk, Def, XP)),
	write('\33\[m'), sideStatus, write('\33\[1000A\33\[1000D'), flush_output,
	enemyHPBar,
	format('\33\[36m\33\[1mKamu\33\[m ketemu \33\[31m\33\[1m%s\33\[m !!!\n',[Nama]),
	% format('Darah \33\[31m\33\[1m%s\33\[m sebanyak \33\[31m\33\[1m%d\33\[m\n',[Nama,HP]),
	sleep(0.2),
	battleStartHelp,

	random(1, 10, P),
	asserta(peluangLari(P)),
	asserta(isEnemyAlive(1)),
	call(battleLoop).


encounterDragon(_) :-
	% asserta(enemy(99, tubesDuragon, 999, 99, 99, 1000)),
	monster(99, Name, HP, Atk, Def, XPGain),
	asserta(enemy(99, Name, HP, Atk, Def, XPGain)),
	asserta(turnCount(1)),
	write('\33\[31m\33\[1m'),
	write(' ░░       ░░░▒▒▒▒░░                                                     '),nl,
	write('░░▒▒▒▒▒▒░      ░▒▒▒▒▒▒░                                                 '),nl,
	write('      ░▒▒▒▓▓▒░      ░▒▒▓▓▒▒░                                            '),nl,
	write('            ░░▒▒▒▒░░    ░▒▓▓▓▒▒░                                        '),nl,
	write('                 ░░▒▒▒▒░    ▒▓▓▓▓▒░  ▒▒▒                                '),nl,
	write('                      ▒▒▓▒░   ▒▓▓▓██▓▒▒▒▓▓▒                             '),nl,
	write('                ░░       ░▓██▒     ███   ░▓▒                            '),nl,
	write('                ░░    ░░░   ██      ▒▓▓▓░  ░▓▒░                         '),nl,
	write('             ░░░░░░░      ░  ▓█░             ▒▒▒░                       '),nl,
	write('             ▒▒   ░░▒▒▒▒▒░    █▓    ▒▒   ░░░   ░▒▓▒                     '),nl,
	write('             ▒░         ░▒▓▓▒  ▓▒░░▒░░▒▒░         ▒░▒▒                  '),nl,
	write('          ░▓▓  ░▒▒▒▒▒▒▒░    ▒▓▒▓█▓▒▒▓░  ▒▓▒░     ░ ▓    ▒░              '),nl,
	write('            ░▓       ░▒▒▒▓▓▒  ▓█░▒▒▒ ▒▓▓▒▒▒▒▓▓▓▓▓▒░█  ▒▓▓░              '),nl,
	write('             ▒▒            ██░        ▒▓ ░░▒████░   ░ ▒▓▒░              '),nl,
	write('            ░▒  ░░░▒▒▒▒▒▒▒▒▓      ▒        ░░░░░▒▒▒▒░    ░▒░            '),nl,
	write('             ░▒           █▓      ▒█░              ▒▓▓▒    ░░░░░░       '),nl,
	write('               ▒   ░▒▒▒▒▒▒▓█     ▓▓  ░░▒▓▒░██▓▒▒        ▒▒ ░░▒▒ ░▒▒     '),nl,
	write('              ░▓▒▒▓▒▒▒▒▒▒▒▒██   ▓▓  ▓ ░▓░ ░▓░░█░▒▓▒░      ▓░░░░▒░ ░▒▒░░ '),nl,
	write('              ░░            ▓█▒ ▓  ░█▒ ▒▒  ▓  ▓▒ ▓▓█▓▒    ▓░░▒▒ ▒▒    ▒▒'),nl,
	write('                              ▒▒░   ▓█  █  ▓▒ ░░ ░░░▓██▓▒     ░▒ ░░▒  ▓ '),nl,
	write('                                  ░  ░░▒▒▒▒▒▒▒▒▓▒▒░░   ▓█▒         ░ ▓░ '),nl,
	write('                                   ░░░░░░░░       ░░▒░░  ▒▒▒▒         ▒ '),nl,
	write('                                                       ░    ░▒▒▒▒░░░▒▒▒▒'),nl,
	write('                                                              ░▒▓▓▓▓▓▒░ '),nl,
	write('        █████████████████████████████████████████▀███████████'),nl,
	write('        █▄─▄████▀▄─██─▄▄▄▄█─▄─▄─███▄─▄▄─█▄─▄█─▄▄▄▄█─█─█─▄─▄─█'),nl,
	write('        ██─██▀██─▀─██▄▄▄▄─███─██████─▄████─██─██▄─█─▄─███─███'),nl,
	write('        ▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▀▄▄▄▀▀▀▀▄▄▄▀▀▀▄▄▄▀▄▄▄▄▄▀▄▀▄▀▀▄▄▄▀▀'),nl,
	write('\33\[31m\33\[1m\33\[m'),
	battleStartHelp,
	% TODO : Non essential, Special UI
	random(1, 10, P1),
	asserta(peluangLari(P1)),
	asserta(isEnemyAlive(1)),
	call(battleLoop), !.
/********Lari********/

/********Mau Lari tapi belum ketemu musuh******/
run :-
	\+ isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m belum ketemu musuh lho'), nl, nl,
	!;
	/***********Gagal Lari *********/
	\+ isRun(_),
	isEnemyAlive(_),
	peluangLari(P),
	P =< 4,
	write('\33\[36m\33\[1mKamu\33\[m \33\[31m\33\[1mgagal\33\[m run. Semangat bertarung~~ (^///^)'), nl,
	retract(peluangLari(P)),
	asserta(isRun(1)),
	prompt,
	fight, !;
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
	write('\33\[36m\33\[1mKamu\33\[m udah gagal run lho, jangan lari lagi'), nl, nl. % FIXME : Extra, multiple run

/*******************FIGHT********************/
/********Belum ketemu musuh*********/
fight :-
	\+ isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m belum ketemu musuh. Mau nyerang siapa?'), nl, nl,
	!;
	/********Berhasil Bertarung*********/
	\+ isFighting(_),
	% asserta(isRun(1)),
	asserta(isFighting(1)),
	isEnemyAlive(_);
	% enemy(_, NamaEnemy, _, _, _, _),
	% format('\33\[36m\33\[1mKamu\33\[m mencoba melawan \33\[31m\33\[1m%s\33\[m\n', [NamaEnemy]),
	% attackHelp;
	/********Sudah ketemu musuh tapi fight lagi*******/
	isFighting(_), \+ isRun(_),
	isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m sedang melawan musuh loh'), nl, nl.

/******************ATTACK**********************/
/********Comment kalau musuh masih belum kalah********/
attackComment :-
	enemy(_, NamaEnemy, HPEnemy, _, _, _),
	HPEnemy > 0,
	% enemyHPBar,
	incrementTurnCounter,
	% format('Darah \33\[31m\33\[1m%s\33\[m tersisa \33\[31m%d\33\[m\n',[NamaEnemy,HPEnemy]),
	enemyTurn,
	!;
	/********Comment kalau musuh sudah kalah********/
	enemy(EnemyID, NamaEnemy, HPEnemy, _, _, XPDrop),
	HPEnemy =< 0,
	% clear, battleUIDraw,
	format('\33\[31m\33\[1m%s\33\[m telah kalah!\n',[NamaEnemy]),
	statPlayer(_,_,_,_,_,_,_,XPPlayer,GoldPlayer),
	MaxGoldDrop is 25+XPDrop//2,
	random(5,MaxGoldDrop,GoldDrop),
	random(-5,5,XPSpread),
	NewXP is (XPPlayer + XPDrop + XPSpread),
	NewGold is (GoldPlayer + GoldDrop),
	write('\33\[100A\33\[100D'), battleUIDraw,
	retract(enemy(_,_,_,_,_,_)),
	% retract(isRun(_)),
	retract(isEnemyAlive(_)),
	retract(isFighting(_)),
	retract(turnCount(_)),
	retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, _, _)),
	write('\33\[100A\33\[100D\33\[18B'),
	format('\n\33\[36m\33\[1mKamu\33\[m dapat \33\[32m\33\[1m%d XP\33\[m!\n',[XPDrop]),
	format('\33\[36m\33\[1mKamu\33\[m dapat \33\[33m\33\[1m%d Gold\33\[m!\n\n',[GoldDrop]),
	asserta(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, NewXP, NewGold)),
	asserta(isBattleDone(done)),
	isQuestDone(EnemyID),
	isQuestCompleted,
	checkLevelUp,
	write('\33\[37m\33\[2mTekan sembarang tombol mengakhiri battle\33\[m\n'),
	get_key_no_echo(_), !.
% TODO : Extra, auto fight for qol
/********Belum ketemu musuh*********/
normalAttack :-
	\+ isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m belum ketemu musuh, mau nyerang siapa?'), nl, nl,
	!;
	/*Formatnya statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, XP, Gold)*/
	/***********Attack biasa********/
	isEnemyAlive(_),
	write('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1mattack\33\[m!'), nl,
	attack,
	call(attackComment),
	!.


attack :-
	isEnemyAlive(_),
	statPlayer(ClassType,_,_,_,BaseAtkPlayer,_,_,_,_),
	enemy(_, _, HPEnemy, _, DefEnemy, _),
	randomize,
	random(-2,2,AtkSpread),
	random(-5,5,ChanceSpread),
	random(1,100,HitRoll),
	critChance(CritChance),
	hitChance(RawHitChance),
	HitChance is RawHitChance + ChanceSpread,

	% Hit branch
	HitRoll =< HitChance, (
		% Critical Roll
		(
			ClassType = 'swordsman',
			random(1,100,CritRoll), CritRoll =< CritChance,
			asserta(isCrit(1)),
			AtkPlayer is BaseAtkPlayer*4//3 + AtkSpread, !; % 1,3~ x multiplier

			ClassType = 'archer',
			random(1,100,CritRoll), CritRoll =< CritChance,
			asserta(isCrit(1)),
			AtkPlayer is BaseAtkPlayer*5 + AtkSpread, !;	% 4 x multiplier

			ClassType = 'sorcerer',
			random(1,100,CritRoll), CritRoll =< CritChance,
			asserta(isCrit(1)),
			AtkPlayer is BaseAtkPlayer*3//2 + AtkSpread; % 1,5 x multiplier

			AtkPlayer is BaseAtkPlayer + AtkSpread, !
		),
		TotalDamage is AtkPlayer - DefEnemy,

		(
			isCrit(1), (
				TotalDamage > 0,
				format('\33\[33m\33\[1mCritical Hit!\33\[m dengan \33\[33m\33\[1m%d\33\[m damage!',[TotalDamage]), nl,
				NewHPEnemy is (HPEnemy - TotalDamage), retract(isCrit(1)), !;

				write('\33\[33m\33\[1mCritical Hit!\33\[m dengan \33\[33m\33\[1m0\33\[m damage!'), nl,
				NewHPEnemy is HPEnemy,
				retract(isCrit(1)), !
			), !;

			(
				TotalDamage > 0,
				format('Serangan dengan \33\[33m\33\[1m%d\33\[m damage!',[TotalDamage]), nl,
				NewHPEnemy is (HPEnemy - TotalDamage), !;

				write('Serangan dengan \33\[33m\33\[1m0\33\[m damage!'), nl,
				NewHPEnemy is HPEnemy, !
			), !
		),

		retract(enemy(IDenemy, NamaEnemy, HPEnemy, AtkEnemy, DefEnemy, XPDrop)),
		asserta(enemy(IDenemy, NamaEnemy, NewHPEnemy, AtkEnemy, DefEnemy, XPDrop))
	), !;
	% Miss branch
	write('\33\[31m\33\[1mMiss!\33\[m\n'), !.

% TODO : Player HP Cap

/**********************ATTACK MUSUH***********************/
/********Comment kalau pemain masih belum kalah********/
enemyAttackComment :-
	statPlayer(_,_,HPPlayer,_,_,_,_,_,_),
	HPPlayer > 0, !;
	/********Comment kalau pemain sudah kalah********/
	statPlayer(_,_,HPPlayer,_,_,_,_,_,_),
	HPPlayer =< 0,
	sleep(0.3),
	write('\33\[100A\33\[100D\33\[22B'), flush_output,
	battleUIDraw,
	write('\33\[100A\33\[100D\33\[22B'), flush_output,
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
	random(-2,2,DodgeSpread),
	random(1,100,DodgeRoll),
	dodgeChance(RawDodgeChance),
	DodgeChance is RawDodgeChance + DodgeSpread,
	DodgeRoll > DodgeChance, (
		Serangan is (AtkEnemy - DefPlayer + AtkSpread),
		(
			NewHP is (HPPlayer - Serangan), NewHP =< HPPlayer,
			format('\n\33\[31m\33\[1m%s\33\[m melakukan serangan sebesar \33\[31m%d\33\[m\n',[NamaEnemy,Serangan]), !;

			NewHP is HPPlayer,
			format('\n\33\[31m\33\[1m%s\33\[m melakukan serangan sebesar \33\[31m0\33\[m\n',[NamaEnemy]), !
		),

		retract(statPlayer(IDTipe, Nama, HPPlayer, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
		asserta(statPlayer(IDTipe, Nama, NewHP, Mana, Atk, DefPlayer, Lvl, XP, Gold)),
		enemyAttackComment
	), !;
	write('\n\33\[33m\33\[1mDodged!\33\[m\n'), enemyAttackComment, !.



% -------------------- Battle Loop --------------------

battleLoop :-
	isBattleDone(O), retract(isBattleDone(O)), !;
	(

		turnCount(P), (
			P > 1,
			write('\33\[100A\33\[100D'), flush_output, battleUIDraw,
			write('\33\[32m\33\[1mBattle >>                      \33\[m\33\[21D'), !;

			P = 1,
			write('\33\[32m\33\[1mBattle >>                      \33\[m\33\[21D'),
			flush_output, !

			% write('\33\[32m\33\[1mBattle >> \33\[m'), !
		),
		get_key(X),
		(
	    % % catch(read(X), error(_,_), errorMessage), (
	        X = 102, nl, call(fight), clear, battleUIDraw, battleLoop, !; % f key
	        X = 114, clear, battleUIDraw, call(run), clear, battleUIDraw, battleLoop, !; % r key
	        X = 120, nl, \+status, battleLoop, !; % x key

	        X = 41, call(quit), !; % 1 key
			isFighting(_), clear, battleUIDraw, write('\33\[32m\33\[1mBattle >> \33\[m\n'), (
				X = 97,  call(normalAttack), battleLoop, !; % a key
		 		X = 101, call(drinkPot), incrementTurnCounter, enemyTurn, battleLoop, !; % e key, Not Skyrim mode
				X = 99, call(specialAttack), battleLoop, ! % c
			), !;
			write('\nTombol tidak diketahui\n\n'), battleLoop, !
	    ), !
	).

incrementTurnCounter :-
	turnCount(X),
	retract(turnCount(X)),
	Nx is X + 1,
	asserta(turnCount(Nx)), !.


/***********************KALAH********************************/
lose :-
	% retract(isEnemyAlive(_)),
	% retract(isFighting(_)),
	% retract(isRun(_)),
	halt.

isQuestDone(EnemyID) :-
	questList(EnemyID,Cnt),
	(
		Cnt is 1,
		retract(questList(EnemyID, Cnt)),
		statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, CurrentXP, CurrentGold),
		random(-10,30,XPSpread), random(-25,40,GoldSpread),
		XPBounty is XPSpread + Cnt*10, GoldBounty is GoldSpread + 15 + Cnt*20,
		NewXP is CurrentXP + XPBounty, NewGold is CurrentGold + GoldBounty,
		retract(statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, CurrentXP, CurrentGold)),
		asserta(statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, NewXP, NewGold)),
		monster(EnemyID, EnemyName, _, _, _, _),
		format('\33\[33mBagian quest %s sudah selesai!\33\[m\n',[EnemyName]),
		format('Kamu mendapatkan \33\[32m\33\[1m%d XP\33\[m dan \33\[33m\33\[1m%d gold\33\[m!\n',[XPBounty,GoldBounty]);

		NewCnt is Cnt-1,
		retract(questList(EnemyID, Cnt)),
		asserta(questList(EnemyID, NewCnt))
	), !;
	!.


isQuestCompleted :-
	\+questList(_,_),
	(
		retract(isQuest(_)),
		statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, CurrentXP, CurrentGold),
		random(0,70,XPSpread), random(-15,60,GoldSpread),
		XPBounty is XPSpread + 150, GoldBounty is GoldSpread + 250,
		NewXP is CurrentXP + XPBounty, NewGold is CurrentGold + GoldBounty,
		retract(statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, CurrentXP, CurrentGold)),
		asserta(statPlayer(IDTipe, Nama, HP, MP, Atk, Def, Lvl, NewXP, NewGold)),
		write('\n\33\[33m\33\[1mQuest sudah selesai!\33\[m\n'),
		questCount(X),
		retract(questCount(X)),
		Rx is X - 1,
		asserta(questCount(Rx)),
		format('Kamu mendapatkan \33\[32m\33\[1m%d XP\33\[m dan \33\[33m\33\[1m%d gold\33\[m!\n',[XPBounty,GoldBounty])
	), isEntireQuestlineCompleted, !; !.

isEntireQuestlineCompleted :-
	questCount(X),
	X is 0, statPlayer(IDTipe, PName, _, _, _, _, _, _, _), (
		nl, (
			IDTipe = 'swordsman', LegendaryID is 101, !;
			IDTipe = 'archer', LegendaryID is 102, !;
			IDTipe = 'sorcerer', LegendaryID is 103, !
		),
		item(LegendaryID, _, _, LegendaryName, _, _),
		format('Heyo \33\[32m\33\[1m%s\33\[m, thanks for clearing those pest.\n',[PName]), nl,
		sleep(1),
		format('I managed to recovered this \33\[33m\33\[1m%s\33\[m, take it.',[LegendaryName]), nl,
		write('Maybe it will help you obtaining \33\[33mamulet of yendor.\n33\[m'),
		sleep(1),
		addItem(LegendaryID), !
	), !;
	!.

multipleAttack(N) :-
	N is 0, !;
	attack, Rn is N - 1, multipleAttack(Rn), !.

specialAttack :- % FIXME : Heal Potion HP Cap
	isEnemyAlive(_),
	statPlayer(Class,Nama,HP,Mana,Atk,Def,Lvl,XP,Gold),
	enemy(_,EnemyN,_,_,_,_),
	special_skill(Class, SName, SMana, SkillModifier),
	NewMana is Mana - SMana,
	(
		NewMana >= 0,
		( % TODO : Extra, cooldown
			Class = 'swordsman',
			TotalHeal is SkillModifier,
			class(_,Class,MaxHP,_,_,_),
			HealedHP is HP + TotalHeal, (
				HealedHP > MaxHP, NewHP is MaxHP, !;
				NewHP is HealedHP, !
			),

			incrementTurnCounter,
			retract(statPlayer(Class, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, NewHP, NewMana, Atk, Def, Lvl, XP, Gold)),
			format('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1m%s\33\[m!\n',[SName]),
			format('\33\[37m\33\[1mSerangan\33\[m \33\[31m\33\[1m%s\33\[m \33\[37m\33\[1mterblock!\33\[m\n',[EnemyN]),
			format('\33\[33m\33\[1m%s\33\[m menyembuhkan HP sebanyak \33\[31m\33\[1m%d\33\[m\n',[SName,TotalHeal]),
			format('Darah \33\[36m\33\[1mkamu\33\[m menjadi \33\[31m\33\[1m%d\33\[m\n\n',[NewHP,NewMana]), !;

			Class = 'archer',
			retract(statPlayer(Class, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, Atk, Def, Lvl, XP, Gold)),
			format('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1m%s\33\[m!\n',[SName]),
			multipleAttack(SkillModifier),
			(
				enemy(_,_,NewEHP,_,_,_),
				NewEHP > 0, incrementTurnCounter, enemyTurn;
				call(attackComment)
			), !;

			Class = 'sorcerer',
			SantetAtk is Atk*SkillModifier+20,
			retract(statPlayer(Class, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, SantetAtk, Def, Lvl, XP, Gold)),
			format('\33\[36m\33\[1mKamu\33\[m menggunakan \33\[33m\33\[1m%s\33\[m!\n',[SName]),
			attack,
			retract(statPlayer(Class, Nama, HP, NewMana, SantetAtk, Def, Lvl, XP, Gold)),
			asserta(statPlayer(Class, Nama, HP, NewMana, Atk, Def, Lvl, XP, Gold)),
			(
				enemy(_,_,NewEHP,_,_,_),
				NewEHP > 0, incrementTurnCounter,
				enemyTurn, !;
				call(attackComment), !
			)
		), !;
		ManaNeeded is (-1)*NewMana,
		format('Kurang \33\[36m\33\[1m%d mana\33\[m untuk \33\[33m\33\[1m%s\33\[m\n', [ManaNeeded,SName]),
		enemyTurn, !
	).
	% NewMana is Mana - SMana,


battleStartHelp :-
	write('Apa yang akan \33\[36m\33\[1mkamu\33\[m lakukan?'), nl,
	write('• fight (\33\[31m\33\[1mf\33\[m)'), flush_output, nl,
	write('• status (\33\[36m\33\[1mx\33\[m)'), flush_output, nl,
	write('• run (\33\[33m\33\[1mr\33\[m)'), flush_output, nl,
	write('Tuliskan inisial dari command'), nl.


attackHelp :-
	write('\33\[37mPerintah tersedia :\33\[m\n'),
	write('• attack (\33\[31m\33\[1ma\33\[m)'), nl,
	write('• skill (\33\[34m\33\[1mc\33\[m)'), nl,
	write('• status (\33\[36m\33\[1mx\33\[m)'), nl,
	write('• potion (\33\[35m\33\[1me\33\[m)'), nl,
	write('• run (\33\[33m\33\[1mr\33\[m)'), nl, nl.


% Misc
% healthBarDraw :-

battleUIDraw :-
	sideStatus,
	enemyHPBar,
	attackHelp,
	% playerHPBar,
	!.
% playerHPBar :-

enemyHPBar :-
	monster(ID, Nama, MaxHP, _, _, _),
	enemy(ID, Nama, CurrentHP, _, _, _),
	write('\33\[37m\33\[1m╔═══════════╦════════════╦═══════════╗\n'),
	format('\33\[37m\33\[1m║ \33\[31m\33\[1m%9s\33\[m \33\[37m\33\[1m║ ', [Nama]),
	CurrentPercent is (CurrentHP*10)//MaxHP,
	Remain is 10 - CurrentPercent,
	(
		CurrentPercent >= 0,
		innerHPBar(CurrentPercent, Remain), !;

		write('\33\[m\33\[31m\33\[2m██████████\33\[m'), !
	),
	(
		CurrentHP >= 0,
		format(' \33\[37m\33\[1m║ %3d / %3d ║\n',[CurrentHP,MaxHP]), !;

		format(' \33\[37m\33\[1m║ %3d / %3d ║\n',[0,MaxHP]), !
	),
	write('\33\[37m\33\[1m╚═══════════╩════════════╩═══════════╝\n').

innerHPBar(C,M) :-
	C > 0,
	write('\33\[m\33\[31m\33\[1m█\33\[m'),
	Cr is C - 1,
	innerHPBar(Cr,M), !;

	M > 0,
	write('\33\[m\33\[31m\33\[2m█\33\[m'),
	Mr is M - 1,
	innerHPBar(C,Mr), !;

	!.

innerMPBar(C,M) :-
	C > 0,
	write('\33\[m\33\[36m\33\[1m█\33\[m'),
	Cr is C - 1,
	innerMPBar(Cr,M), !;

	M > 0,
	write('\33\[m\33\[36m\33\[2m█\33\[m'),
	Mr is M - 1,
	innerMPBar(C,Mr), !;

	!.
/* ---------------------------------------------------------------------------------------- */

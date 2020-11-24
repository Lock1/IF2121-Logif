/* Logika Komputasional - IF2121 K2
----------------------------------------------
------ Tugas Besar Logika Komputasional ------
------------ Kelas 2 - Kelompok 6 ------------
| 13519146        Fadel Ananda Dotty         |
| 13519170        La Ode Rajuh Emoko         |
| 13519178       Akeyla Pradia Naufal        |
| 13519214      Tanur Rizaldi Rahardjo       |
----------------------------------------------
*/

% Load file yang dibutuhkan
:- include('facts.pl').
:- include('config.pl').
:- include('map.pl').
:- include('battle.pl').
:- include('shop.pl').
:- include('infoplayer.pl').

% Inisialisasi Dynamic Predicate
:- dynamic(questList/2).
:- dynamic(isGameStarted/1).
:- dynamic(player/1).

unicode(1). % Secara default, program ditargetkan untuk mode unicode

% Inisialisasi program
:- initialization(main).

/* ------------------------- Core Loop -------------------------- */
main :-
    unicode(IsUnicodeMode),
    setInitialMap,
    randomize,
    random(37,11777,Rseed),
    set_seed(Rseed),
    (
        IsUnicodeMode is 1,
        shell('clear'),
        first_screen,
        help(IsUnicodeMode),
        printRandomizedTrivia,
        loadingBar(1), nl,
        gameLoop;

        help(IsUnicodeMode),
        printRandomizedTrivia,
        gameLoop
    ).

gameLoop :-
    repeat,
    write('> '),
    unicode(IsUnicodeMode),
    % Pembatasan input agar tidak dapat cheat :)
    catch(read(X), error(_,_), errorMessage), (
        X = 'start', call(start);
        X = 'help', call(help(IsUnicodeMode));
        X = 'clear', call(clear);
        X = 'quit', call(quit);

        isGameStarted(_), (
            X = 'map', \+map, write('\33\[m'), flush_output;
            X = 'status', call(status);
            X = 'w', call(w);
            X = 'a', call(a);
            X = 's', call(s);
            X = 'd', call(d);
            X = 'move', call(move);
            X = 'inventory', call(listInventory);
            X = 'greedisgood', call(greedisgood);
            X = 'whosyourdaddy', call(whosyourdaddy);
            X = 'hesoyam', call(hesoyam);
            X = 'y', call(addItem(2)); % DEBUG
            X = 'hidden', hidden
        )
        % TODO : Extra, Handler message

    ),
    fail.

% Useful thing : catch(call(X), error(_,_), errorMessage))
errorMessage :-
    write('Error : Input tidak dipahami\n'), halt.

/* ------------------------- Commands -------------------------- */
/* User accessible commands
start.
move.
inventory.
status.
map.
quit.
clear.
w. a. s. d.

*/

start :-
    isGameStarted(_),
    write('Gamenya sudah dimulai bambank!'), nl.

start :-
    \+isGameStarted(_),
    asserta(isGameStarted(1)),
    username_input,
    choose_class.

status :-
    statPlayer(TipeKelas, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    write('┏━━━━━━━━━┯━━━━━━━━━━━━┓'), nl,
    write('┃ Name    │ '), format('%10s',[Nama]), write(' ┃'), nl,
    write('┃ Class   │ '), format('%10s',[TipeKelas]), write(' ┃'), nl,
    write('┃ HP / MP │  '),
    format('\33\[31m\33\[1m%3d\33\[m',[HP]),flush_output,
    write(' / '),
    format('\33\[34m\33\[1m%3d\33\[m',[Mana]), flush_output, write(' ┃'), nl,
    write('┃ Attack  │ '), format('%10d',[Atk]), write(' ┃'), nl,
    write('┃ Defense │ '), format('%10d',[Def]), write(' ┃'), nl,
    write('┃ Lv / XP │   '), format('%2d / \33\[32m\33\[1m%3d\33\[m',[Lvl,XP]), write(' ┃'), nl,
    write('┃ Gold    │ '),
    format('\33\[33m\33\[1m%10d\33\[m',[Gold]), flush_output, write(' ┃'), nl,
    write('┗━━━━━━━━━┷━━━━━━━━━━━━┛'), nl,
    questStatus.

questStatus :-
    questList(ID,Ct),
    monster(ID,Name,_,_,_,_),
    write( '┏━━━━━━━━━━━┯━━━━━━━┓\n'),
    write( '┃  Monster  │ Count ┃\n'),
    write( '┠───────────┼───────┨\n'),
    format('┃ \33\[31m\33\[1m%-9s\33\[m │ %5d ┃\n',[Name,Ct]),
    write( '┗━━━━━━━━━━━┷━━━━━━━┛\n').
    % TODO : Integrate quest.
    % TODO : Extra, Filter input 'a,b'



sideStatus :-
    statPlayer(TipeKelas, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    write('\33\[100A\33\[1000D\33\[62C\33\[1m'),flush_output,
    write('┏━━━━━━━━━┯━━━━━━━━━━━━┓'),
    write('\33\[100A\33\[1000D\33\[62C\33\[1B'),flush_output,
    write('┃ Name    │ '), format('%10s',[Nama]), write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[2B'),flush_output,
    write('┃ Class   │ '), format('%10s',[TipeKelas]), write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[3B'),flush_output,
    write('┃ HP / MP │  '),
    format('\33\[31m\33\[1m%3d\33\[m',[HP]),flush_output,
    write(' / '),
    format('\33\[34m\33\[1m%3d\33\[m',[Mana]), flush_output, write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[4B'),flush_output,
    write('┃ Attack  │ '), format('%10d',[Atk]), write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[5B'),flush_output,
    write('┃ Defense │ '), format('%10d',[Def]), write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[6B'),flush_output,
    write('┃ Lv / XP │   '), format('%2d / \33\[32m\33\[1m%3d\33\[m',[Lvl,XP]), write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[7B'),flush_output,
    write('┃ Gold    │ '),
    format('\33\[33m\33\[1m%10d\33\[m',[Gold]), flush_output, write(' ┃'),
    write('\33\[100A\33\[1000D\33\[62C\33\[8B'),flush_output,
    write('┗━━━━━━━━━┷━━━━━━━━━━━━┛'),
    call(sideStatusQuest),
    write('\33\[100A\33\[1000D'),flush_output.

sideStatusQuest :-
    findall(A,questList(A,_),L),
    length(L,Size),
    % Location is Size + 12,
    questList(ID,Ct),
    monster(ID,Name,_,_,_,_),

    % findall(questList(ID,_),monster(ID,Name,_,_,_,_),P), % TODO : Extra, Create name list
    write('\33\[1000A\33\[1000D\33\[62C\33\[9B'),flush_output,
    write( '┏━━━━━━━━━━━┯━━━━━━━┓\n'),
    write('\33\[1000A\33\[1000D\33\[62C\33\[10B'),flush_output,
    write( '┃  Monster  │ Count ┃\n'),
    write('\33\[1000A\33\[1000D\33\[62C\33\[11B'),flush_output,
    write( '┠───────────┼───────┨\n'),
    write('\33\[1000A\33\[1000D\33\[62C\33\[12B'),flush_output,
    format('┃ \33\[31m\33\[1m%-9s\33\[m │ %5d ┃\n',[Name,Ct]), % TODO : Extra, Fix by print all quest
    write('\33\[1000A\33\[1000D\33\[62C\33\[13B'),flush_output,
    write( '┗━━━━━━━━━━━┷━━━━━━━┛\n'),
    write('\33\[1000A\33\[1000D\33\[62C\33\[14B'),flush_output,
    write('\33\[mCek \33\[33mstatus.\33\[m untuk info quest lengkap.');
    % format('\33\[1000A\33\[1000D\33\[62C\33\[%dB',[Location]),flush_output,

    write('\33\[100A\33\[1000D\33\[62C\33\[9B'),flush_output,
    write('Tidak ada quest').

% sideStatusQuestInner(I,Size,Name,Ct) :-
%     I is Size;
%     Index is I + 11,
%     write('\33\[1000A\33\[1000D\33\[62C\33\[%dB',[Index]),flush_output,
%     format('┃ \33\[31m\33\[1m%-7s\33\[m │ %5d ┃\n',[Name,Ct]).

% TODO : Extra, inventory sidebar
clear :-
    shell('clear').

overwriteClear :-
    write('\33\[0,0H'),
    write('\33\[200A'),
    flush_output,
    screenWipe(28),
    write('\33\[200A'),
    flush_output, !.

quit :-
    \+isGameStarted(_),
    write('KAN BELOM DIMULAI PERMAINANNYA!!!!!!!!!!!!!!!!'), nl, halt.

quit :-
    write('Yah masa baru segini quit sih, lemah!!!!'), nl, halt.


/* ----------------------- Decision branch ---------------------- */
choose_class :-
    write('(Type class name with lowercase)\n'),
    write('Choose your class: '), catch(read(ClassType), error(_,_), errorMessage), nl,
    class(ClassID, ClassType, HP, Mana, Atk, Def),
    (
        ClassID =:= 1,
        write('You have chosen Swordsman'), nl;

        ClassID =:= 2,
        write('You have chosen Archer'), nl;

        ClassID =:= 3,
        write('You have chosen Sorcerer'), nl

    ) -> (write('\nYou may begin your journey.\n'),\+map, write('\33\[m'), flush_output,
    write('Use \33\[32m\33\[1mmove.\33\[m for better movement control!'), nl),

    player(Name),
    Lvl is 1, Xp is 0, Gold is 0,
    % statPlayer(IDTipe, Nama, HP, mana, Atk, Def, Lvl, XP, Gold)
    asserta(statPlayer(ClassType, Name, HP, Mana, Atk, Def, Lvl, Xp, Gold)),
    isIDValid(ClassID),!;
    choose_class.

isIDValid(X) :-
    integer(X), X=<3.

username_input :-
    unicode(IsUnicodeMode),
    write('Hello, adventurer, welcome to our headquarter'), nl,
    sleep(0.8),
    write('Would you like to tell me your name?'), nl,
    sleep(1),
    write('Your name: '), catch(read(Name), error(_,_), errorMessage), asserta(player(Name)), nl, nl,

    write('Hello, '), write(Name), write('. in this world, you can choose between three classes'), nl,
    sleep(0.2),
    write('Each class has its own unique stats and gameplay'), nl,
    sleep(0.2),
    classScreen(IsUnicodeMode).

doQuest(X,Y) :-
    player(Username), randomize, (shell('clear'), !; overwriteClear, !),
    format('Hello, \33\[32m\33\[1m%s\33\[m! \33\[33m\33\[1mIt\'s time for some adventure!\33\[m\n', [Username]),
    random(1,500,Rmv),
    Mnstr is mod(Rmv, 6) + 1,
    random(1,1000,Rv),
    Cnt is mod(Rv, 6) + 1, monster(Mnstr,Name,_,_,_,_),
    format('You have to slain \33\[31m\33\[1m%d %s\33\[m\n',[Cnt, Name]),
    (
        questList(Mnstr,OldCt), NewCt is OldCt + Cnt, retract(questList(Mnstr,_)), asserta(questList(Mnstr,NewCt)), !;
        asserta(questList(Mnstr,Cnt)), !
    ),
    retract(quest(X,Y)),
    prompt,
    (shell('clear'), !; overwriteClear, !). % FIXME : Weird legacy behaviour

greedisgood :-
    write('\33\[33m\33\[1mResource granted\33\[m\n'),
    statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    NewXP is XP + 1000,
    NewGold is Gold + 1000,
    retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, NewXP, NewGold)),
    checkLevelUp, !.

whosyourdaddy :-
    statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    Atk >= 100000,
    NewAtk is 20,
    NewDef is 5,
    retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HP, Mana, NewAtk, NewDef, Lvl, XP, Gold)),
    write('\33\[31m\33\[1mGod mode deactivated\33\[m\n'), !;

    statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    Atk < 100000,
    NewAtk is 100000,
    NewDef is 100000,
    retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, HP, Mana, NewAtk, NewDef, Lvl, XP, Gold)),
    write('\33\[33m\33\[1mGod mode activated\33\[m\n'), !.


hesoyam :-
    write('\33\[37m\33\[1mCheat activated\33\[m\n'),
    statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    NewDef is 999,
    NewHP is 999,
    NewGold is Gold + 1000,
    retract(statPlayer(IDTipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, NewHP, Mana, Atk, NewDef, Lvl, XP, NewGold)), !.


/* -------------------------- Movement -------------------------- */
w :-
    playerLocation(TPX,TPY),
    TPY > 1,
    Move is TPY-1,
    collisionCheck(TPX,Move),
    flush_output, sideStatus,
    \+map,
    write('Kamu bergerak ke atas      '), nl.

a :-
    playerLocation(TPX,TPY),
    TPX > 1,
    Move is TPX-1,
    collisionCheck(Move,TPY),
    flush_output, sideStatus,
    \+map,
    write('Kamu bergerak ke kiri      '), nl.

s :-
    playerLocation(TPX,TPY),
    height(MaxH),
    TPY < MaxH ,
    Move is TPY+1,
    collisionCheck(TPX,Move),
    flush_output, sideStatus,
    \+map,
    write('Kamu bergerak ke bawah     '), nl.

d :-
    playerLocation(TPX,TPY),
    width(MaxW),
    TPX < MaxW,
    Move is TPX+1,
    collisionCheck(Move,TPY),
    flush_output, sideStatus,
    \+map,
    write('Kamu bergerak ke kanan     '), nl.

setLocation(X,Y) :-
    retract(playerLocation(_,_)),
    asserta(playerLocation(X,Y)). % TODO : Shop

collisionCheck(X,Y) :-
    quest(X,Y), doQuest(X,Y), !; % TODO : 3 Enemy
    dragon(X,Y), write('battle gan'), !; % TODO : Boss battle
    shop(X,Y), clear, call(shop), clear, !; % TODO : collision check and set location
    \+shop(X,Y), randomEncounter, clear, encounterEnemy(_), clearFightStatus, clear,  !;
    setLocation(X,Y).

randomEncounter :-
    randomize, (
        random(0,10000,RandValue),
        RandValue < 800
    ).

clearFightStatus :-
    retract(isFighting(_));
    retract(isRun(_));!.

prompt :-
    write('\33\[37m\33\[1mTekan sembarang tombol untuk melanjutkan\33\[m\n'),
    get_key_no_echo(user_input,_), !.

% Terminal raw mode input, non-blocking mode for more fluid play
% Press m to back to command mode
switchMove(X) :-
    X is 119, w;
    X is 97, a;
    X is 115, s;
    X is 100, d;
    X > 0, sideStatus, \+map.

move :-
    clear,
    sideStatus,
    \+map,
    write('Tekan e untuk command mode                  '), nl,

    toggleRawMode,
    write('\33\[m'),
    flush_output,
    clear,
    write('Telah Kembali ke command mode'), nl.

toggleRawMode :-
    get_key_no_echo(user_input,X),
    % overwriteClear,
    lineWipeAtPlayer,
    (X is 101, !;  switchMove(X), write('Tekan e untuk command mode                 '), nl, horizontalCursorAbsolutePosition(1), toggleRawMode, !).
    % Press e to break

/* ----------------------- Draw procedure ----------------------- */
% Layar pertama ketika dijalankan
first_screen :-
    write('\33\[32m\33\[1m'), % ANSI Formatting
    flush_output,
    write('██╗░░██╗███████╗██╗░░░░░██╗░░░░░░█████╗░░░░'), nl,
    write('██║░░██║██╔════╝██║░░░░░██║░░░░░██╔══██╗░░░'), nl,
    write('███████║█████╗░░██║░░░░░██║░░░░░██║░░██║░░░'), nl,
    write('██╔══██║██╔══╝░░██║░░░░░██║░░░░░██║░░██║██╗'), nl,
    write('██║░░██║███████╗███████╗███████╗╚█████╔╝╚█║'), nl,
    write('╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░╚════╝░░╚╝'), nl,

    write('████████╗██████╗░██╗░░░██╗░█████╗░██╗░░██╗░░░░░░██╗░░██╗██╗░░░██╗███╗░░██╗  ██╗'), nl,
    write('╚══██╔══╝██╔══██╗██║░░░██║██╔══██╗██║░██╔╝░░░░░░██║░██╔╝██║░░░██║████╗░██║  ██║'), nl,
    write('░░░██║░░░██████╔╝██║░░░██║██║░░╚═╝█████═╝░█████╗█████═╝░██║░░░██║██╔██╗██║  ██║'), nl,
    write('░░░██║░░░██╔══██╗██║░░░██║██║░░██╗██╔═██╗░╚════╝██╔═██╗░██║░░░██║██║╚████║  ╚═╝'), nl,
    write('░░░██║░░░██║░░██║╚██████╔╝╚█████╔╝██║░╚██╗░░░░░░██║░╚██╗╚██████╔╝██║░╚███║  ██╗'), nl,
    write('░░░╚═╝░░░╚═╝░░╚═╝░╚═════╝░░╚════╝░╚═╝░░╚═╝░░░░░░╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝  ╚═╝\33\[m'), nl,
    flush_output.

help(X) :-
    X is 1,
    write('\33\[37m\33\[1m'), % Help ANSI Formatting
    write('╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ '), nl,
    write('│   ┎─────────────────────────────────────────────┒    │ '), nl,
    write('│   ┃  start.     : Memulai petualanganmu         ┃    │ '), nl,
    write('│   ┃  map.       : Menampilkan peta              ┃    │ '), nl,
    write('│   ┃  status.    : Menampilkan kondisi saat ini  ┃    │ '), nl,
    write('│   ┃  inventory. : Menampilkan barang            ┃    │ '), nl,
    write('│   ┃  w a s d    : Bergerak dengan arah wasd     ┃    │ '), nl,
    write('│   ┃  move.      : Masuk ke mode movement        ┃    │ '), nl,
    write('│   ┃  help.      : Menampilkan bantuan           ┃    │ '), nl,
    write('│   ┃  clear.     : Membersihkan layar            ┃    │ '), nl,
    write('│   ┖─────────────────────────────────────────────┚    │ '), nl,
    write('╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ '), nl,
    write('Jangan lupa mengakhiri command dengan titik sebelum enter.'), nl, nl,
    write('\33\[m');

    X is 0,
    write('+--------------------------------------------------------+ '), nl,
    write('|   +----------------------------------------------+     | '), nl,
    write('|   | 1. start.     : Memulai petualanganmu        |     | '), nl,
    write('|   | 2. map.       : Menampilkan peta             |     | '), nl,
    write('|   | 3. status.    : Menampilkan kondisi saat ini |     | '), nl,
    write('|   | 3. inventory. : Menampilkan kondisi saat ini |     | '), nl,
    write('|   | 4. w a s d    : Bergerak dengan arah wasd    |     | '), nl,
    write('|   | 5. move.      : Masuk ke mode movement       |     | '), nl,
    write('|   | 6. help.      : Menampilkan bantuan          |     | '), nl,
    write('|   | 7. clear.     : Membersihkan layar           |     | '), nl,
    write('|   +----------------------------------------------+     | '), nl,
    write('+--------------------------------------------------------+ '), nl,
    write('Jangan lupa mengakhiri command dengan titik sebelum enter.'), nl, nl.

classScreen(X) :-
    X is 1,
    write('┎─────────────────────────────────────────────────────────────────────────────────────────────────────────────┒'), nl,
    write('┃                \33\[31m\33\[1mSwordsman\33\[m                         \33\[32m\33\[1mArcher\33\[m                        \33\[36m\33\[1mSorcerer\33\[m                     ┃'), flush_output, nl,
    write('┃                              ███                                                                            ┃'), flush_output, nl,
    write('┃                             ░▓█░                                                                            ┃'), flush_output, nl,
    write('┃                            ████                                                  ░░▒▓▒░░                    ┃'), flush_output, nl,
    write('┃                            ███▒                                                 █▓▓██▓▓▒▒▒                  ┃'), flush_output, nl,
    write('┃                           ▒██                  ░ ▒█▒                            ░▒░░░▓████▓                 ┃'), flush_output, nl,
    write('┃                           ██                  ▓▓████▓                           ▒▓▓██▓▓▓▒░                  ┃'), flush_output, nl,
    write('┃                          ▓█                     ▓▓▓███                           ░█████▒                    ┃'), flush_output, nl,
    write('┃                         ▒█▒                      ░  ▓██▒                        ░▓██▓░                      ┃'), flush_output, nl,
    write('┃                         █▓                      ░▒    ▓██                       ▓██▓                        ┃'), flush_output, nl,
    write('┃                        ██                       ░▒      ██░                     ▓███░                       ┃'), flush_output, nl,
    write('┃                       ▓█░                       ░▒       ▓█▒                    ▓███░                       ┃'), flush_output, nl,
    write('┃                      ▒█▓                        ▒▒        ▓█▒                   ░███░                       ┃'), flush_output, nl,
    write('┃       ▒▓██▒         ░██                         ░▒         ██▒                  ░███▓                       ┃'), flush_output, nl,
    write('┃          ▒▓▓▓▓▒▓▓▓▒▓██▒                         ▒▒          █▓                   ▒███▒                      ┃'), flush_output, nl,
    write('┃            ░███████▓▓▓▓▓▒                       ░▒          ▒█▓                  ░███░                      ┃'), flush_output, nl,
    write('┃            ▒▓████▓▓▓███████▓░                   ▒▒           ██▒                ▓██▓                        ┃'), flush_output, nl,
    write('┃             ▓████▓▓█████████▓███▓▒              ▒▓           ▓█▓                ▒█▓                         ┃'), flush_output, nl,
    write('┃            ▒███▓▓▓████████▓    ░▒▓              ▒▒           ▓█▓                ▒█▓                         ┃'), flush_output, nl,
    write('┃            ▓▓▓▓▓▒▓██████▒                       ░▓           ▒█▒                ░██                         ┃'), flush_output, nl,
    write('┃           ▒▓▓▓▓▒▓██▓▓██▒                        ▒▒           ██▒                 ▓█▒                        ┃'), flush_output, nl,
    write('┃          ░▓▒▓▓▒▒▓█▓▓██▒                         ░▒          ▒█░                  ▓█▓                        ┃'), flush_output, nl,
    write('┃          ▓▓▓▒▓▒▓█▓▓▓█▓                          ░▒         ░█▓                   ▓██▒                       ┃'), flush_output, nl,
    write('┃         ▒▓▓▒▒▒▓██▓▓█▓                           ▒▒         ██                     ▓█▓                       ┃'), flush_output, nl,
    write('┃        ░▓▓▓▒▒▓██▓▓█▓           ░▒▓▒░            ░▒       ░██                        ▓█▓                     ┃'), flush_output, nl,
    write('┃        ▓▓▓▓▒▓▓█▓▓██░         ▒██▓▓░             ▒▒      ▓██                          ▓██░                   ┃'), flush_output, nl,
    write('┃       ▒▓▓▓▒▒▓▓▓▓▓█░       ░▒▓▓░                 ░▒     ██▓                           ▒██░                   ┃'), flush_output, nl,
    write('┃      ░▓▓▓▓▒▒▓▓▓▓▓░      ▒▓▒░                    ▒▒   ▓██░                             ▒█▓                   ┃'), flush_output, nl,
    write('┃      ▓▒▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓██▒                      ░░ ░██▒                                ▓█▓                  ┃'), flush_output, nl,
    write('┃     ▒▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓███████▓▓▒░░▒▒▒░             ▒▓█░                                   ▓█▓                 ┃'), flush_output, nl,
    write('┃    ░▓▓▓▒▒▓▓▓▓▓▒▒▓▓▓▓▓█▓▓▒                     ▒▓███▒                                     ▓█▓                ┃'), flush_output, nl,
    write('┃    ▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓█▓▓░                        █▓▒█▓                                       ▓█▓               ┃'), flush_output, nl,
    write('┃   ▒█▓▓▓▓▓▓▓▓▓▒▓█▓▓░                              ▒                                         ▓█▓              ┃'), flush_output, nl,
    write('┃  ▒██▓▓▓▓████▓▓▓░                                                                            ▓█▓             ┃'), flush_output, nl,
    write('┃  ▒▓▓▓▓▓▓▓▓▓▒                                                                                 ▓█▓            ┃'), flush_output, nl,
    write('┠─────────────────────────────────────────────────────────────────────────────────────────────────────────────┨'), nl,
    write('┃                 HP  300                         HP  280                        HP  270                      ┃'), nl,
    write('┃                 MP   50                         MP   60                        MP  100                      ┃'), nl,
    write('┃                 Atk  25                         Atk  21                        Atk  23                      ┃'), nl,
    write('┃                 Def   5                         Def   3                        Def   2                      ┃'), nl,
    write('┖─────────────────────────────────────────────────────────────────────────────────────────────────────────────┚'), nl;

    X is 0,
    write('+-----------+-----------+-----------+'), nl,
    write('| Swordsman |  Archer   |  Sorcerer |'), nl,
    write('+-----------+-----------+-----------+'), nl,
    write('|  HP  300  |  HP  280  |  HP  270  |'), nl,
    write('|  MP   50  |  MP   60  |  MP  100  |'), nl,
    write('|  Atk  25  |  Atk  21  |  Atk  23  |'), nl,
    write('|  Def   5  |  Def   3  |  Def   2  |'), nl,
    write('+-----------+-----------+-----------+'), nl.



screenWipe(X) :-
    X is 0;
    flush_output,
    write('                                                       '), nl,
    Rx is X-1, screenWipe(Rx).

lineWipeAtPlayer :-
    playerLocation(_,Y), NegY is Y * (-1),
    format('\33\[u\33\[100A\33\[100C\33\[%dB',[NegY]), flush_output,
    write('                                          '),
    write('\33\[s').


% Loading bar
loadingBar(X) :-
    write('\33\[200D'),
    loadingBarSize(Size),
    write('╓'),
    loadingVerticalBorder(1,Size+3),
    write('╖'),
    write('\33\[200D\33\[2B'),
    flush_output,
    write('╙'),
    loadingVerticalBorder(1,Size+3),
    write('╜'),
    write('\33\[1A'),
    flush_output,
    loadingBarInner(X),
    nl.

loadingBarInner(X) :-
    loadingBarSize(Size), X is 8*Size;
    loadingBarSize(Size),
    write('\33\[200D'),
    flush_output,
    write('┃'),
    write('\33\[33m'), % Loading bar ANSI Formatting
    flush_output,
    loadingProgressDraw(X),
    horizontalCursorAbsolutePosition(Size+3),
    write('\33\[m'),
    flush_output,
    write('┃'),
    loadingStepDuration(TP),
    sleep(TP),
    Rx is X+1, loadingBarInner(Rx),!.

loadingPBar(X) :-
    X is 7, write('█'); % █ Full 1/8 step frame
    X is 6, write('█'); % ▉ WSL Terminal doesnt support it
    X is 5, write('█'); % ▊ Only half frame supported
    X is 4, write('█'); % ▋ Windows Terminal support full frame mode
    X is 3, write('▌'); % ▌
    X is 2, write('▌'); % ▍
    X is 1, write('▌'); % ▎
    X is 0, write('▌'). % ▏

loadingPFullBar(S,X) :-
    S is X;
    write('█'),
    Rs is S+1, loadingPFullBar(Rs,X).

loadingProgressDraw(X) :-
    write('\33\[200D'),
    write('\33\[2C'),
    flush_output,
    TPFull is div(X,8),
    loadingPFullBar(0,TPFull),
    flush_output,
    TPNotFull is mod(X,8),
    loadingPBar(TPNotFull),
    loadingSpinDraw(X).

loadingSpinDraw(X) :-
    loadingBarSize(Size),
    write('\33\[200D'),
    horizontalCursorAbsolutePosition(Size+5),
    flush_output,
    Rm is mod(X,3),
    (Rm is 0,write('-');
    Rm is 1,write('\\');
    Rm is 2,write('/')).

loadingVerticalBorder(S,X) :-
    S is X;
    write('─'),
    Rs is S+1, loadingVerticalBorder(Rs,X).

horizontalCursorRightMove(X) :-
    X is 1, write('\33\[1C');
    write('\33\[1C'),
    Rx is X-1, horizontalCursorRightMove(Rx).

horizontalCursorAbsolutePosition(X) :-
    write('\33\[200D'),
    horizontalCursorRightMove(X).



% Trivia selector
printRandomizedTrivia :-
    triviaList(TList),
    listLength(TList,ListSize),
    randomize,
    random(0,10000,RandomResult),
    Index is mod(RandomResult,ListSize),
    listSelect(TList,Index,Trivia),
    write(Trivia), nl.

listLength(L,R) :-
    L = [], R is 0;
    L = [_|Y], listLength(Y,Rx), R is Rx + 1.

listSelect(L,I,E) :-
    L = [X], I is 0, E = X;
    L = [Y|_], I is 0, E = Y;
    L = [_|B], Ri is I-1, listSelect(B,Ri,Re), E = Re, !.



/* -------------------- File input / output --------------------- */
/* Untuk save dan load */
/*read from file*/
read_from_file(File) :-
    open(File, read, Stream),

    /*Get char from data Stream*/
    get_char(Stream, Char1),

    /*Output all characters until end_of_file*/
    process_the_stream(Char1, Stream),

    close(Stream).

process_the_stream(end_of_file, _) :- !.
process_the_stream(Char, Stream) :-
    write(Char),
    get_char(Stream, Char2),
    process_the_stream(Char2, Stream).

/*write to file*/
write_on_file(File, Text) :-
    open(File, write, Stream), /*file will get overwritten*/
    /*open(File, appen, Stream), file will not get overwritten*/
    write(Stream, Text), nl,
    close(Stream).

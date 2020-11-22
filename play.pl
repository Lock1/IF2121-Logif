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

% Inisialisasi Dynamic Predicate
:- dynamic(count/1).
:- dynamic(player/1).

unicode(0). % Secara default, program ditargetkan untuk mode unicode

% Inisialisasi program
:- initialization(main).

/* ------------------------- Core Loop -------------------------- */
main :-
    unicode(IsUnicodeMode),
    IsUnicodeMode is 1,
    shell('clear'),
    randomize,
    random(37,11777,Rseed),
    set_seed(Rseed),
    first_screen,
    help(IsUnicodeMode),
    setInitialMap,
    printRandomizedTrivia,
    loadingBar(1), nl,
    gameLoop;

    IsUnicodeMode is 0,
    randomize,
    random(37,11777,Rseed),
    set_seed(Rseed),
    help(IsUnicodeMode),
    setInitialMap,
    setQuest(3),
    setShop(3),
    printRandomizedTrivia,
    gameLoop.

gameLoop :-
    repeat,
    write('> '),
    unicode(IsUnicodeMode),
    read(X), (
        X = 'start', call(start);
        X = 'help', call(help(IsUnicodeMode));
        X = 'clear', call(clear);
        X = 'quit', call(quit);

        count(_), (
            X = 'map', call(map(IsUnicodeMode));
            X = 'status', call(status);
            X = 'w', call(w);
            X = 'a', call(a);
            X = 's', call(s);
            X = 'd', call(d);
            X = 'move', call(move)
        )

    ),
    fail.

    % Useful thing : catch(call(X), error(_,_), errorMessage))
    % errorMessage :-
    %     write('Perintah tidak ditemukan\n').

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
    count(_),
    write('Gamenya sudah dimulai bambank!'), nl.

start :-
    \+count(_),
    asserta(count(1)),
    username_input,
    choose_class.

status. % TODO : add check inventory

clear :-
    shell('clear').

overwriteClear :-
    write('\33\[0,0H'),
    write('\33\[200A'),
    flush_output,
    screenWipe(20),
    write('\33\[200A'),
    flush_output, !.

quit :-
    \+count(_),
    write('KAN BELOM DIMULAI PERMAINANNYA!!!!!!!!!!!!!!!!'), nl, halt.

quit :-
    write('Yah masa baru segini quit sih, lemah!!!!'), nl, halt.

/*
inventory :-
*/


/* ----------------------- Decision branch ---------------------- */
choose_class :-
    write('(Type class name with lowercase)\n'),
    write('Choose your class: '), read(ClassType), nl,
    class(ClassID, ClassType,_,_,_,_,_,_),
    (
        ClassID =:= 1 ->
        write('You have chosen Swordsman'), nl,
        write('You may begin your journey.'), nl;
        (
        ClassID =:= 2 ->
        write('You have chosen Archer'), nl,
        write('You may begin your journey.'), nl;
        (
        ClassID =:= 3 ->
        write('You have chosen Sorcerer'), nl,
        write('You may begin your journey.'), nl
        )
        )
    ),
    isIDValid(ClassID),!;
    choose_class.

isIDValid(X) :-
    integer(X),X=<3.

username_input :-
    unicode(IsUnicodeMode),
    write('Hello, adventurer, welcome to our headquarter'), nl,
    sleep(0.8),
    write('Would you like to tell me your name?'), nl,
    sleep(1),
    write('Your name: '), read(Name), asserta(player(Name)), nl, nl,

    write('Hello, '), write(Name), write('. in this world, you can choose between three classes'), nl,
    sleep(0.2),
    write('Each class has its own unique stats and gameplay'), nl,
    sleep(0.2),
    classScreen(IsUnicodeMode).

/* -------------------------- Movement -------------------------- */
w :-
    playerLocation(TPX,TPY),
    retract(playerLocation(_,_)),
    Move is TPY-1,
    asserta(playerLocation(TPX,Move)), % TODO : Collision
    \+map,
    write('Kamu telah bergerak ke atas '), nl.
a :-
    playerLocation(TPX,TPY),
    retract(playerLocation(_,_)),
    Move is TPX-1,
    asserta(playerLocation(Move,TPY)),
    \+map,
    write('Kamu telah bergerak ke kiri '), nl.
s :-
    playerLocation(TPX,TPY),
    retract(playerLocation(_,_)),
    Move is TPY+1,
    asserta(playerLocation(TPX,Move)),
    \+map,
    write('Kamu telah bergerak ke kanan'), nl.
d :-
    playerLocation(TPX,TPY),
    retract(playerLocation(_,_)),
    Move is TPX+1,
    asserta(playerLocation(Move,TPY)),
    \+map,
    write('Kamu telah bergerak ke bawah'), nl.

% Terminal raw mode input, non-blocking mode for more fluid play
% Press m to back to command mode
switchMove(X) :-
    X is 119, w;
    X is 97, a;
    X is 115, s;
    X is 100, d;
    X > 0, \+map.

move :-
    clear,
    \+map,
    write('Tekan e untuk command mode'),
    toggleRawMode,
    clear,
    write('Telah Kembali ke command mode'), nl.

toggleRawMode :-
    get_key_no_echo(user_input,X),
    overwriteClear,
    (X is 101, !; switchMove(X), write('Tekan e untuk command mode'), toggleRawMode, !).
    % Press e to break

/* ----------------------- Draw procedure ----------------------- */
% Layar pertama ketika dijalankan
first_screen :-
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
    write('░░░╚═╝░░░╚═╝░░╚═╝░╚═════╝░░╚════╝░╚═╝░░╚═╝░░░░░░╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝  ╚═╝'), nl,
    flush_output.

help(X) :-
    X is 1,
    write('╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ '), nl,
    write('│     ┎─────────────────────────────────────────────┒    │ '), nl,
    write('│     ┃ 1. start.  : Memulai petualanganmu          ┃    │ '), nl,
    write('│     ┃ 2. map.    : Menampilkan peta               ┃    │ '), nl,
    write('│     ┃ 3. status. : Menampilkan kondisi saat ini   ┃    │ '), nl,
    write('│     ┃ 4. w a s d : Bergerak dengan arah wasd      ┃    │ '), nl,
    write('│     ┃ 5. move.   : Masuk ke mode movement         ┃    │ '), nl,
    write('│     ┃ 6. help.   : Menampilkan bantuan            ┃    │ '), nl,
    write('│     ┃ 7. clear.  : Membersihkan layar             ┃    │ '), nl,
    write('│     ┖─────────────────────────────────────────────┚    │ '), nl,
    write('╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ '), nl,
    write('Jangan lupa mengakhiri command dengan titik sebelum enter.'), nl, nl;

    X is 0,
    write('+--------------------------------------------------------+ '), nl,
    write('|     +---------------------------------------------+    | '), nl,
    write('|     | 1. start.  : Memulai petualanganmu          |    | '), nl,
    write('|     | 2. map.    : Menampilkan peta               |    | '), nl,
    write('|     | 3. status. : Menampilkan kondisi saat ini   |    | '), nl,
    write('|     | 4. w a s d : Bergerak dengan arah wasd      |    | '), nl,
    write('|     | 5. move.   : Masuk ke mode movement         |    | '), nl,
    write('|     | 6. help.   : Menampilkan bantuan            |    | '), nl,
    write('|     | 7. clear.  : Membersihkan layar             |    | '), nl,
    write('|     +---------------------------------------------+    | '), nl,
    write('+--------------------------------------------------------+ '), nl,
    write('Jangan lupa mengakhiri command dengan titik sebelum enter.'), nl, nl.

classScreen(X) :-
    X is 1,
    write('┎─────────────────────────────────────────────────────────────────────────────────────────────────────────────┒'), nl,
    write('┃                Swordsman                         Archer                        Sorcerer                     ┃'), nl,
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
    write('                                                                  '), nl,
    Rx is X-1, screenWipe(Rx).

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
    flush_output,
    loadingProgressDraw(X),
    horizontalCursorAbsolutePosition(Size+3),
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

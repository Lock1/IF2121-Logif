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

% Inisialisasi Dynamic Predicate
:- dynamic(count/1).
:- dynamic(player/1).

% Inisialisasi program
:- initialization(shell('clear')).
:- initialization(first_screen).
% :- initialization(choose_class). % DEBUG

:- initialization(write('Tips : mantap gan\n')). % Loading Bar
:- initialization(loadingBar(1)).
:- initialization(nl).
:- initialization(gameLoop).



gameLoop :-
    repeat,
    write('> '),
    read(X),
    catch(call(X), error(_,_) ,errorMessage),
    fail.

errorMessage :-
    write('Perintah tidak ditemukan\n').
% error(existence_error(procedure,asd/0),gameLoop/0)

% Layar pertama ketika dijalankan
first_screen :-
    write('Welcome to your journey!'), nl,
    help,
    flush_output.

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

isIDValid(X) :- integer(X),X=<3.

username_input :-
    write('Hello, adventurer, welcome to our headquarter'), nl,
    % sleep(0.5),
    write('Would you like to tell me your name?'), nl,
    % sleep(0.5),
    write('Your name: '), read(Name), asserta(player(Name)), nl, nl,
    % sleep(0.5),
    write('Hello, '), write(Name), write('. in this world, you can choose between three classes'), nl,
    % sleep(0.5),
    write('Each class has its own unique stats and gameplay'), nl,
    % sleep(0.5),
    write('┎─────────────────────────────────────────────────────────────────────────────────────────────────────────────┒'), nl,
    write('┃                Swordsman                         Archer                        Sorcerer                     ┃'), nl,
    write('┠─────────────────────────────────────────────────────────────────────────────────────────────────────────────┨'), nl,
    write('┃                 HP  300                         HP  280                        HP  270                      ┃'), nl,
    write('┃                 MP   50                         MP   60                        MP  100                      ┃'), nl,
    write('┃                 Atk  25                         Atk  21                        Atk  23                      ┃'), nl,
    write('┃                 Def   5                         Def   3                        Def   2                      ┃'), nl,
    write('┖─────────────────────────────────────────────────────────────────────────────────────────────────────────────┚'), nl.

help :-
    write('╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ '), nl,
    write('│     ┎─────────────────────────────────────────────┒    │ '), nl,
    write('│     ┃ 1. start.  : Memulai petualanganmu          ┃    │ '), nl,
    write('│     ┃ 2. map.    : Menampilkan peta               ┃    │ '), nl,
    write('│     ┃ 3. status. : Menampilkan kondisi saat ini   ┃    │ '), nl,
    write('│     ┃ 4. w.      : Bergerak ke atas satu langkah  ┃    │ '), nl,
    write('│     ┃ 5. a.      : Bergerak ke kiri satu langkah  ┃    │ '), nl,
    write('│     ┃ 6. s.      : Bergerak ke bawah satu langkah ┃    │ '), nl,
    write('│     ┃ 7. d.      : Bergerak ke kanan satu langkah ┃    │ '), nl,
    write('│     ┃ 8. help.   : Menampilkan bantuan            ┃    │ '), nl,
    write('│     ┖─────────────────────────────────────────────┚    │ '), nl,
    write('╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ '), nl, nl, nl.

start :-
    count(_),
    write("Gamenya sudah dimulai bambank!").

start :-
    \+count(_),
    asserta(count(1)),
    username_input,
    choose_class.


quit :-
    \+count(_),
    write('KAN BELOM DIMULAI PERMAINANNYA!!!!!!!!!!!!!!!!').

quit :-
    write('Yah masa baru segini quit sih, lemah!!!!').
    /* masih kurang beberapa argumen */

/*
inventory :-
*/

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
    X is 4, write('█'); % ▋
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

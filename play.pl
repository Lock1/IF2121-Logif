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
% Inisialisasi
:- dynamic(count/1).
:- dynamic(player/1).

:- include('facts.pl').

% :- initialization(shell('clear')).
:- initialization(first_screen).

% Layar pertama ketika dijalankan
first_screen :-
    write('  ############################################## '), nl,
    write(' ################################################'), nl,
    write('##        Welcome to your first journey         ##'), nl,
    write('## 1. start   : memulai petualanganmu           ##'), nl,
    write('## 2. map     : menampilkan peta                ##'), nl,
    write('## 3. status  : menampilkan kondisi saat ini    ##'), nl,
    write('## 4. w       : bergerak ke atas satu langkah   ##'), nl,
    write('## 5. a       : bergerak ke kiri satu langkah   ##'), nl,
    write('## 6. s       : bergerak ke bawah satu langkah  ##'), nl,
    write('## 7. d       : bergerak ke kanan satu langkah  ##'), nl,
    write('## 8. help    : menampilkan bantuan             ##'), nl,
    write(' ################################################'), nl,
    write('  ############################################## '), nl, nl.

choose_class :-
    write('Hello, adventurer, welcome to our headquarter'), nl,
    sleep(0.5),
    write('Would you like to tell me your name??'), nl,
    sleep(0.5),
    write('Write your name: '), read(Name), asserta(player(Name)), nl, nl,
    sleep(0.5),
    write('Hello, '), write(Name), write('. in this world, you can choose between three classes'), nl,
    sleep(0.5),
    write('Each class has its own unique stats and gameplay'), nl,
    sleep(0.5),
    write('CLASS DETAILS'), nl,
    write('<------------------------------------->'), nl,
    write('SWORDSMAN'), nl,
    write('Max HP: '), nl,
    write('Attack: '), nl,
    write('Defense: '), nl,
    write('<------------------------------------->'), nl,
    write('Archer'), nl,
    write('Max HP: '), nl,
    write('Attack: '), nl,
    write('Defense: '), nl,
    write('<------------------------------------->'), nl,
    write('Sorcerer'), nl,
    write('Max HP: '), nl,
    write('Attack: '), nl,
    write('Defense: '), nl,
    write('<------------------------------------->'), nl,
    repeat,
    write('Choose your class!'), nl,
    write('1. Swordsman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,
    write('4. See classes details'), nl,
    write('Choose your class: '), read(ClassType), nl,
    class(ClassID, ClassType,_,_,_,_,_,_),
    (   ClassID =:= 1 ->
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
    do(ClassID), nl,
    end_condition(ClassID),
    finalize.

do(X) :- X=<3, !.
do(_) :- write('haha.').
do(end).

end_condition(end).
% end_condition(ClassID) :-


finalize :-
    write('Halo').


help :-
    write('Command you can use'),
    write('1. start. : untuk memulai game'),
    write('2. map. : untuk menampilkan peta'),
    write("3. status :").

start :-
    count(_),
    write("Gamenya sudah dimulai bambank!").

start :-
    \+count(_),
    first_screen,
    asserta(count(1)),
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

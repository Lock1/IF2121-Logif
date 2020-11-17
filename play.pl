:- dynamic(count/1).
/*this means there is a dynamic function called player with 2 parameter/argument input*/

/*by using asserta you can add player on top of this*/
/*player(masterTanur, swordsman).*/
/*by using assertz you can add player below of this*/

/*Yang akan dimunculkan pertama kali*/
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
    write('  ############################################## ').

start :-
    write('Hello, adventurer, you are about to become the hero of this world'), nl,
    write('First, tell me your name'), nl,
    read(Name),
    choose_class.

choose_class :-
    write('Choose between these three!'), nl,
    write('1. Swordsman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,
    write('4. See classes details'), nl,

    read(Choice),
    (   Choice =:= 1 ->
        write('You have chosen Swordsman'), nl,
        write('You may begin your journey.'), nl;
        (
        Choice =:= 2 ->
        write('You have chosen Archer'), nl,                                                       
        write('You may begin your journey.'), nl;       
        (
        Choice =:= 3 ->
        write('You have chosen Sorcerer'), nl,
        write('You may begin your journey.'), nl;
        (
        Choice =:= 4 ->    
        nl,
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
        choose_class;
        (
        (Choice >4 ; Choice<0) -> 
        nl,
        nl,
        write('**********************************************************'), nl,
        write('****Cuma bisa pilih 4 pilihan neng mas, pilih lagi yok****'), nl,
        write('**********************************************************'), nl,
        choose_class                                    
        )
        )
        )
        )
    ).

help :-
    write('Command you can use'),
    write('1. start. : untuk memulai game'),
    write('2. map. : untuk menampilkan peta'),
    write("3. status :").

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


    
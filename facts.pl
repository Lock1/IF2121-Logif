/*Alur Kasar Permainan*/
/*User mengetikkan start, lalu muncul tulisan tentang mechanism game, lalu user melakukan pemilihan class
dan kemudian user dapat melakukan permainan */
/*User dapat melakukan explorasi terhadap map yang diberikan dan ketika melakukan explorasi dapat bertemu
dengan monster secara random, apabila user gagal mengalahkan monster (HP: 0), maka permainan gagal dan user
harus mengulang permainan dari awal. User memenangkan permainan apabila sudah dapat mengalahkan boss dari
permainan yaitu naga*/

/*
Fakta dan Rule yang digunakan:
Fakta
    1. Fakta tentang class player dan stats yang dimiliki
    2. Fakta tentang jenis jenis item
    3. Fakta tentang enemy dan stats mereka
    4. Fakta tentang map secara keseluruhan
    5. Fakta tentang aturan pembelian gacha
    6. Fakta kalah permainan
    7. Fakta menang permainan
Rule
    1. Rule untuk menambah inventory (menggunakan list, dan rekurens)
    2. Rule battle mechanism (menggunakan control loop)
    3. Rule Exploring map (menggunakan rekursif dan list)
    4. Rule pembelian gacha (menggunakan loop)
    5. Rule kalah dari permainan (menggunakan cut dan fail)
    6. Rule menang dari permainan
*/

/* Class(ID_pilihan, class_type, HP, mana, attack, def, level, exp)*/
class(1, swordsman, 300, 50, 25, 5, 1, 0).
class(2, archer, 280, 60, 21, 3, 1, 0).
class(3, sorcerer, 270, 100, 23, 2, 1, 0).

/* Monster(name, atk, exp_drop) */
/* Tipe monster sesuai dengan spek */
monster(slime, 22, 30).
monster(goblin, 27, 45).
monster(wolf, 33, 55).

/* Item(class_type, category, item_name, attack, def) possibly dont need gold since gacha anyway */
/* Item terbagi sesuai dengan jenis class dan category */
inventory_max(100).
item(swordsman, sword, excalibur_kw1, 50, 0).
item(swordsman, sword, samehadawibu, 45, 0).
item(swordsman, sword, pedangzabuza, 42, 0).

item(archer, bow, gataudeh, 47, 0).
item(archer, bow, ngarangbebas, 42, 0).
item(archer, bow, tolongkasihnamaya, 39, 0).

item(sorcerer, wand, avadacadavra, 46, 0).
item(sorcerer, wand, tolongkasihnama2, 44, 0).
item(sorcerer, wand, gataudeh2, 41, 0).

item(swordsman, armor, bajuperangdunia, 0, 25).
item(archer, armor, bajuperangdunia2, 0, 21).
item(sorcerer, armor, bajuperangdunia3, 0, 20).

/* Special_Skill(class_type, nama skill, manacost) */
special_skill(swordsman, matekocokkkkk, 30).
special_skill(archer, cupid-arrow, 25).
special_skill(sorcerer, santet, 30).
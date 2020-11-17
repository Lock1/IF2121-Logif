/* Class(ID_pilihan, class_type, HP, mana, attack, def, level, exp) //parameters could change*/
class(1, swordsman, 300, 50, 25, 5, 1, 0).
class(2, archer, 280, 60, 21, 3, 1, 0).
class(3, sorcerer, 270, 100, 23, 2, 1, 0).

/* Monster(name, atk, exp_drop) //parameters could change*/
/* Tipe monster sesuai dengan spek */
monster(slime, 22, 30).
monster(goblin, 27, 45).
monster(wolf, 33, 55).

/* Item(item_id, class_type, category, item_name, attack, def) possibly dont need gold since gacha anyway //parameters could change*/
/* Item terbagi sesuai dengan jenis class dan category */

item(1, swordsman, sword, excalibur_kw1, 50, 0).
item(2, swordsman, sword, samehadawibu, 45, 0).
item(3, swordsman, sword, pedangzabuza, 42, 0).

item(4, archer, bow, gataudeh, 47, 0).
item(5, archer, bow, ngarangbebas, 42, 0).
item(6, archer, bow, tolongkasihnamaya, 39, 0).

item(7, sorcerer, wand, avadacadavra, 46, 0).
item(8, sorcerer, wand, tolongkasihnama2, 44, 0).
item(9, sorcerer, wand, gataudeh2, 41, 0).

item(10, swordsman, armor, bajuperangdunia, 0, 25).
item(11, archer, armor, bajuperangdunia2, 0, 21).
item(12, sorcerer, armor, bajuperangdunia3, 0, 20).

/* Special_Skill(class_type, nama skill, manacost) //parameters could change*/
special_skill(swordsman, matekocokkkkk, 30).
special_skill(archer, cupid-arrow, 25).
special_skill(sorcerer, santet, 30).
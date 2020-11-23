/* Class(ID_pilihan, class_type, HP, mana, attack, def) //parameters could change*/
class(1, swordsman, 300, 50, 25, 5).
class(2, archer, 280, 60, 21, 3).
class(3, sorcerer, 270, 100, 23, 2).

/* Monster(ID, name, HP, atk, def, exp_drop) //parameters could change*/
/* Tipe monster sesuai dengan spek */
monster(1, slime, 60, 22, 2, 30).
monster(2, goblin, 80, 27, 4, 45).
monster(3, wolf, 90, 33, 3, 55).
monster(4, skeleton, 100, 26, 3, 42).
monster(5, zombie, 65, 20, 2, 32).
monster(6, bomber, 68, 45, 1, 48).

/* Item(item_id, class_type, category, item_name, attack, def) possibly dont need gold since gacha anyway //parameters could change*/
/* Item terbagi sesuai dengan jenis class dan category */

item(1, swordsman, sword, excalibur_kw1, 50, 0).
item(2, swordsman, sword, samehadawibu, 45, 0).
item(3, swordsman, sword, pedangzabuza, 42, 0).

item(4, archer, bow, lightningarrow, 47, 0).
item(5, archer, bow, archdemon, 42, 0).
item(6, archer, bow, arrowspike, 39, 0).

item(7, sorcerer, wand, avadacadavra, 46, 0).
item(8, sorcerer, wand, tolongkasihnama2, 44, 0).
item(9, sorcerer, wand, gataudeh2, 41, 0).

item(10, swordsman, armor, bajuperangdunia, 0, 25).
item(11, archer, armor, bajuperangdunia2, 0, 21).
item(12, sorcerer, armor, bajuperangdunia3, 0, 20).

item(13, swordsman, statup, gelangbaja, 10, 5).
item(14, sorcerer, statup, gelangsihir, 10, 5).
item(15, archer, statup, gelangkaret, 10, 5).

/*Potion(ID, Name, HP+, Mana+)*/
potion(1, lesserhealingpotion, 10, 0).
potion(2, smallhealingpotion, 20, 0).
potion(3, greaterhealingpotion, 30 ,0).
potion(4, alkohooool, 60, 0).

potion(5, lessermanapotion, 0, 10).
potion(6, smallmanapotion, 0, 20).
potion(7, greatermanapotion, 0, 30).
potion(8, okultisme, 0, 60).



/* Special_Skill(class_type, nama skill, manacost) //parameters could change*/
special_skill(swordsman, matekocokkkkk, 30).
special_skill(archer, cupid-arrow, 25).
special_skill(sorcerer, santet, 30). 
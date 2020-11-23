/* Class(ID_pilihan, class_type, HP, mana, attack, def) //parameters could change*/
class(1, swordsman, 300, 50, 25, 5).
class(2, archer, 280, 60, 21, 3).
class(3, sorcerer, 270, 100, 23, 2).

/* Monster(ID, name, HP, atk, def, exp_drop) //parameters could change*/
/* Tipe monster sesuai dengan spek */
monster(1, slime, 60, 6, 2, 30).
monster(2, goblin, 80, 10, 4, 45).
monster(3, wolf, 90, 12, 3, 55).
monster(4, skeleton, 100, 15, 3, 42).
monster(5, zombie, 65, 20, 2, 32).
monster(6, bomber, 25, 45, 1, 48).

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

/*Potion(ID, _, _,Name, HP+, Mana+)*/
potion(16, lesser_healing_potion, 10, 0).
potion(17, small_healing_potion, 20, 0).
potion(18, greater_healing_potion, 30 ,0).
potion(19, alkohooool, 60, 0).

potion(20, lessermanapotion, 0, 10).
potion(21, smallmanapotion, 0, 20).
potion(22, greatermanapotion, 0, 30).
potion(23, okultisme, 0, 60).



/* Special_Skill(class_type, nama skill, manacost) //parameters could change*/
special_skill(swordsman, baliho-fpi, 30).
special_skill(archer, cupid-arrow, 25).
special_skill(sorcerer, santet, 30).

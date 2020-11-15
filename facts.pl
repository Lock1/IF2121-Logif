/* Class(pilihan, class_type, HP, mana, attack, def, level, exp)*/
class(1, swordsman, 300, 50, 25, 5, 1, 0).
class(2, archer, 280, 60, 21, 3, 1, 0).
class(3, sorcerer, 270, 100, 23, 2, 1, 0).

/* Monster(name, atk, exp_drop) */
monster(slime, 22, 30).
monster(goblin, 27, 45).
monster(wolf, 33, 55).

/* Item(class_type, category, item_name, attack, def) possibly dont need gold since gacha anyway*/
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
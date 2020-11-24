/* Class(ID_pilihan, class_type, HP, mana, attack, def) //parameters could change*/
class(1, swordsman, 180, 50, 25, 5).
class(2, archer, 120, 60, 13, 4).
class(3, sorcerer, 150, 100, 17, 2).

/* Monster(ID, name, HP, atk, def, exp_drop) //parameters could change*/
/* Tipe monster sesuai dengan spek */
monster(1, 'Slime', 60, 6, 2, 30).
monster(2, 'Goblin', 80, 10, 4, 45).
monster(3, 'Wolf', 90, 12, 3, 55).
monster(4, 'Skeleton', 100, 15, 3, 42).
monster(5, 'Zombie', 65, 20, 2, 32).
monster(6, 'Bomber', 25, 45, 1, 48).
monster(99, 'Tubes Duragon', 999, 80, 30, 2000).

/* Item(item_id, class_type, category, item_name, attack, def) possibly dont need gold since gacha anyway //parameters could change*/
/* Item terbagi sesuai dengan jenis class dan category */

item(1, swordsman, sword, 'True-Excalibur KW1', 10, 0).
item(2, swordsman, sword, 'Samehadawibu', 35, 0).
item(3, swordsman, sword, 'Pedang Zabuza', 55, 0).

item(4, archer, bow, 'Pulse Bow', 15, 0).
item(5, archer, bow, 'Phantasm', 25, 0).
item(6, archer, bow, 'Tsunami', 40, 0).

item(7, sorcerer, wand, 'Avadacadavra', 15, 0).
item(8, sorcerer, wand, 'Rainbow Rod', 30, 0).
item(9, sorcerer, wand, 'Tongkat Gandalf', 60, 0).

item(10, swordsman, armor, 'Baju Orang Marah', 0, 8).
item(11, archer, armor, 'Baju Orang Miskin', 0, 4).
item(12, sorcerer, armor, 'Baju Orang Jenggotan', 0, 6).

item(13, swordsman, statup, 'Gelang Baja', 5, 2).
item(14, sorcerer, statup, 'Gelang Sihir', 10, 1).
item(15, archer, statup, 'Gelang Karet', 10, 0).

/*Potion(ID, _, _,Name, HP+, Mana+)*/
potion(16, 'Lesser Healing Potion', 10, 0).
potion(17, 'Healing Potion', 20, 0).
potion(18, 'Greater Healing Potion', 30 ,0).
potion(19, 'alkohooool', 60, 0).

potion(20, 'Lesser Mana Potion', 0, 10).
potion(21, 'Mana Potion', 0, 20).
potion(22, 'Greater Mana Potion', 0, 30).
potion(23, 'okultisme', 0, 60).

% TODO : Extra, boost potion

/* Special_Skill(class_type, nama skill, manacost) //parameters could change*/
special_skill(swordsman, 'baliho yang dicopot', 15).
special_skill(archer, 'rapid fire', 10).
special_skill(sorcerer, 'santet', 30).

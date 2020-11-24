:- dynamic(inventory/6).
:- dynamic(inventoryP/4).
% :- include('facts.pl'). %DEBUGGING

/*inventory(ItemID, class, category, name, attack, def)*/
addItem(ItemID) :-
    (
    findall(ItemName, inventory(_,_,_,ItemName,_,_), List),
    length(List, Length),
    findall(PotionName, inventoryP(_,PotionName,_,_), ListP),
    length(ListP, LengthP),
    Res is Length+LengthP,
    Res >= 100,
    write('Inventory Is Full'),
    !,fail;

    /*bisa ga ya kira2*/
    ItemID>15,
    potion(ItemID, PotionName, PlusHP, PlusMana),
    asserta(inventoryP(ItemID, PotionName, PlusHP, PlusMana)),!;

    ItemID=<15,
    item(ItemID, Class, Category, ItemName, Attack, Def),
    asserta(inventory(ItemID, Class, Category, ItemName, Attack, Def)),!
    ).

delItem(ItemID) :-
    \+inventory(ItemID,_,_,_,_,_),
    write('There is no specified item to delete'),!,fail;

    \+inventoryP(ItemID,_,_,_),
    write('There is no specified potion to delete'),!,fail;

    ItemID>15,
    retract(inventoryP(ItemID,_,_,_));

    ItemID=<15,
    retract(inventory(ItemID,_,_,_,_,_)), !.

listing([],[],[],[]).
listing(ListID, List1, List2, List3) :-
    [I1|I2]=ListID,
    [W1|W2]=List1,
    [X1|X2]=List2,
    [Y1|Y2]=List3,
    format('┃ ID     │ %26d  ┃',[I1]), nl,
    format('┃ Name   │ \33\[33m\33\[1m%26s\33\[m  ┃',[W1]), nl,
    format('┃ Attack │ %26d  ┃',[X1]), nl,
    format('┃ Def    │ %26d  ┃',[Y1]), nl, % TODO : Formatting
    write('┠────────┴────────────────────────────┨'),nl,
    listing(I2, W2, X2, Y2).

listItem :-
    findall(ItemID, inventory(ItemID,_,_,_,_,_), IDs),
    findall(ItemName, inventory(_,_,_,ItemName,_,_), Names),
    findall(Attack, inventory(_,_,_,_,Attack,_), Attacks),
    findall(Def, inventory(_,_,_,_,_,Def), Defs),
    write('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓'), nl,
    write('┃                Weapon                ┃'), nl,
    write('┠───────── ────────────────────────────┨'), nl,
    listing(IDs, Names, Attacks, Defs),
    write('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'), nl.

listingPotion([],[],[],[]).
listingPotion(ListID, List1, List2, List3):-
    [I1|I2]=ListID,
    format('┃ ID            │ %19d  ┃',[I1]), nl,
    [A1|A2]=List1,
    format('┃ Name          │ %19s  ┃',[A1]), nl,
    [B1|B2]=List2,
    format('┃ HP Restored   │ %19d  ┃',[B1]), nl,
    [C1|C2]=List3,
    format('┃ Mana Restored │ %19d  ┃',[C1]), nl,
    write('┃                                      ┃'),nl,
    listingPotion(I2, A2, B2, C2).

listPotion :-
    findall(PotionID, inventoryP(PotionID,_,_,_), PIDs),
    findall(PotionName, inventoryP(_,PotionName,_,_), PNames),
    findall(PlusHP, inventoryP(_,_,PlusHP,_), HPs),
    findall(PlusMana, inventoryP(_,_,_,PlusMana), ManaS),
    write('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓'), nl,
    write('┃                Potion                ┃'), nl,
    write('┠──────────────────────────────────────┨'), nl,
    listingPotion(PIDs, PNames, HPs, ManaS),
    write('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'), nl.

listInventory :-
    listItem,
    listPotion.

%statPlayer(IDTipe, Nama, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, NewGold)

checkLevelUp :-
    statPlayer(IDTipe, Nama, CurrentHP, CurrentMana, CurrentAtk, CurrentDef, CurrentLvl, CurrentXP, Gold),
    XPToLvlUp is CurrentLvl*80 + 100,
    XPToLvlUp =< CurrentXP,
    NewHP is CurrentHP + CurrentLvl*5 + 120,
    NewMana is CurrentMana + CurrentLvl*3 + 30,
    NewAtk is CurrentAtk + CurrentLvl//2 + 1,
    NewDef is CurrentDef + CurrentLvl//3,
    NewXP is CurrentXP - XPToLvlUp, LvlUp is CurrentLvl + 1,
    retract(statPlayer(IDTipe, Nama, CurrentHP, CurrentMana, CurrentAtk, CurrentDef, CurrentLvl, CurrentXP, Gold)),
    asserta(statPlayer(IDTipe, Nama, NewHP, NewMana, NewAtk, NewDef, LvlUp, NewXP, Gold)),
    format('\33\[33m\33\[1mSelamat kamu naik ke level %d!\33\[m\n',[LvlUp]), checkLevelUp; !.

drinkPot :-
    listPotion,
    write('Masukkan ID Potion \n> '),
    catch(read(X), error(_,_), errorMessage),
    usePotion(X).

:- dynamic(currentWapon/1).
:- dynamic(currentArmor/1).
:- dynamic(currentMisc/1).
kuontol :-
    listItem,
    write('Masukkan ID Item \n> '),
    catch(read(X), error(_,_), errorMessage),
    equip(X).

% Weapon, Armor, Misc
equip(ItemID) :-
    (
    \+currentWeapon(_),
    ItemID =< 9, ItemID > 0,
    statPlayer(Tipe, _, _, _, Atk, _, _, _, _),
    inventory(IDWeapon,Tipe,_,Name,WAtk,_),
    (
    asserta(currentWeapon(IDWeapon));
    write("Tidak sesuai kelas")
    ),

    NewAtk is WAtk+Atk,
    retract(statPlayer(Tipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(Tipe, Nama, HP, Mana, NewAtk, Def, Lvl, XP, Gold));

    \+currentArmor(_),
    ItemID > 9, ItemID <13,
    statPlayer(Tipe, _, _, _, _, Def, _, _, _),
    inventory(IDArmor, Tipe, _, Name, _,ADef),
    (
    asserta(currentArmor(IDWeapon));
    write("Tidak sesuai kelas")
    ),
    
    NewDef is ADef+Def,
    retract(statPlayer(Tipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(Tipe, Nama, HP, Mana, Atk, NewDef, Lvl, XP, Gold));

    \+currentMisc(_),
    ItemID > 12, ItemID =< 15,
    statPlayer(Tipe, _, _, _, Atk, Def, _, _, _),
    inventory(IDMisc, Tipe, _, Name, WAtk, ADef),
    (
    asserta(currentWeapon(IDWeapon));
    write("Tidak sesuai kelas")
    ),
    
    NewAtk is WAtk+Atk,
    NewDef is ADef+Def,
    retract(statPlayer(Tipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(Tipe, Nama, HP, Mana, NewAtk, NewDef, Lvl, XP, Gold));
    
    write('sudah nge equip barang kok mau equip lagi')
    ).
  
usePotion(PID) :-
    inventoryP(PID, Name, PlusHP, PlusMana),
    statPlayer(Tipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold),
    NewHP is HP+PlusHP,
    NewMana is Mana+PlusMana,
    retract(statPlayer(Tipe, Nama, HP, Mana, Atk, Def, Lvl, XP, Gold)),
    asserta(statPlayer(Tipe, Nama, NewHP, NewMana, Atk, Def, Lvl, XP, Gold)),
    retract(inventoryP(PID, Name, PlusHP, PlusMana)),
    format('\33\[33m\33\[1m%s\33\[m Telah diminum\n',[Name]),!;
    write('Potion tidak ditemukan\n').

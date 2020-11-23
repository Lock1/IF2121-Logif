:- dynamic(inventory/6).
:- dynamic(inventoryP/4).
:- include('facts.pl'). %DEBUGGING

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

listing([],[],[]).
listing(List1, List2, List3) :-
    [W1|W2]=List1,
    format('┃Name    | %24s  ┃',[W1]), nl,
    [X1|X2]=List2,
    format('┃Attack  | %24d  ┃',[X1]), nl,
    [Y1|Y2]=List3,
    format('┃Def     | %24d  ┃',[Y1]), nl,
    write('┃                                    ┃'),nl,
    listing(W2, X2, Y2).

listItem :-
    findall(ItemName, inventory(_,_,_,ItemName,_,_), Names),
    findall(Attack, inventory(_,_,_,_,Attack,_), Attacks),
    findall(Def, inventory(_,_,_,_,_,Def), Defs),
    write('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓'), nl,
    write('┃               Weapon               ┃'), nl,
    write('┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┃'), nl,
    listing(Names, Attacks, Defs),
    write('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'), nl.

listingPotion([],[],[]).
listingPotion(List1, List2, List3):-
    [A1|A2]=List1,
    format('┃Name           | %19s  ┃',[A1]), nl,
    [B1|B2]=List2,
    format('┃HP Restored    | %19d  ┃',[B1]), nl,
    [C1|C2]=List3,
    format('┃Mana Restored  | %19d  ┃',[C1]), nl,
    write('┃                                      ┃'),nl,
    listingPotion(A2, B2, C2).

listPotion :-
    findall(PotionName, inventoryP(_,PotionName,_,_), PNames),
    findall(PlusHP, inventoryP(_,_,PlusHP,_), HPs),
    findall(PlusMana, inventoryP(_,_,_,PlusMana), ManaS),
    write('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓'), nl,
    write('┃                Potion                ┃'), nl,
    write('┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┃'), nl,
    listingPotion(PNames, HPs, ManaS),
    write('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'), nl.

listInventory :-
    listItem,!,
    listPotion,!.

%statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, NewGold)

checkLevel :-
    statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, Gold),
    (
    CurrentLvl is Lvl,
    BaseXPReq is 200,
    NextLvl is CurrentLvl*80+BaseXPReq,
    NewAtk is Atk*CurrentLvl+20,
    NewDef is Def*CurrentLvl+10,
    retract(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, Atk, DefPlayer, Lvl, XP, Gold)),
    asserta(statPlayer(IDTipe, Nama, Tipe, HPPlayer, mana, NewAtk, NewDef, NextLvl, XP, Gold))
    ).
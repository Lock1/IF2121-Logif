:- dynamic(inventory/6).
:- dynamic(inventoryP/4).

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

    ItemID>15,
    retract(inventoryP(ItemID,_,_,_));

    ItemID=<15,
    retract(inventory(ItemID,_,_,_,_,_)), !.

listing([],[],[]).
listing(List1, List2, List3) :-
    [W1|W2]=List1,
    write('Name: '),
    write(W1), nl,
    [X1|X2]=List2,
    write('Attack: '),
    write(X1), nl,
    [Y1|Y2]=List3,
    write('Def: '),
    write(Y1), nl,
    listing(W2, X2, Y2).

listItem :-
    findall(ItemName, inventory(_,_,_,ItemName,_,_), Names),
    findall(Attack, inventory(_,_,_,_,Attack,_), Attacks),
    findall(Def, inventory(_,_,_,_,_,Def), Defs),
    write('----------------'), nl,
    write('Weapon:'), nl,
    listing(Names, Attacks, Defs).

listingPotion([],[],[]).
listingPotion(List1, List2, List3):-
    [W1|W2]=List1,
    write('Name: '),
    write(W1), nl,
    [X1|X2]=List2,
    write('HP Restored: '),
    write(X1), nl,
    [Y1|Y2]=List3,
    write('Mana Restored: '),
    write(Y1), nl,
    listing(W2, X2, Y2).

listPotion :-
    findall(PotionName, inventoryP(_,PotionName,_,_), PNames),
    findall(PlusHP, inventoryP(_,_,PlusHP,_), HPs),
    findall(PlusMana, inventoryP(_,_,_,PlusMana), ManaS),
    write('----------------'), nl,
    write('Potion:'), nl,
    listingPotion(PNames, HPs, ManaS).

listInventory :-
    listItem,!,
    listPotion,!.

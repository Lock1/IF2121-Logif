:- dynamic(inventory/6).

/*inventory(ItemID, class, category, name, attack, def)*/
addItem(ItemID) :-
    findall(ItemName, inventory(_,_,_,ItemName,_,_), List),
    findall(PotionName, potion(_,_,_PotionName,_,_), ListP),
    length(List, Length),
    length(ListP, LengthP),
    Res is Length+LengthP,
    (
    Res >= 100,
    write('Inventory Is Full'),
    !,fail;
    /*bisa ga ya kira2*/
    potion(ItemID, _, _, PotionName, PlusHP, PlusMana),
    asserta(inventory(ItemID, _, _, PotionName, PlusHP, PlusMana)),!;

    item(ItemID, ClassType, Category, ItemName, Attack, Def),
    asserta(inventory(ItemID, Class, Category, ItemName, Attack, Def)),!
    ).

delItem(ItemID) :-
    \+inventory(ItemID,_,_,_,_,_),
    write('There is no specified item to delete'),!,fail;

    retract(inventory(ItemID,_,_,_,_,_)), !.

listing(List1, List2, List3, List4):-
    [],[],[],[],[],[];
    [W1|W2]=List1,
    write(W1), nl,
    [X1|X2]=List2,
    write(X1), nl,
    [Y1|Y2]=List3,
    write(Y1), nl,
    [Z1|Z2]=List4,
    write(Z1), nl,
    listing(W2, X2, Y2, Z2).

listingPotion(List1, List2, List3, List4):-
    [],[],[],[],[],[];
    [W1|W2]=List1,
    write(W1), nl,
    [X1|X2]=List2,
    write(X1), nl,
    [Y1|Y2]=List3,
    write(Y1), nl,
    [Z1|Z2]=List4,
    write(Z1), nl,
    listing(W2, X2, Y2, Z2).

listItem:-
    findall(ItemName, inventory(_,_,_,ItemName,_,_), Names),
    findall(ItemID, inventory(ItemID,_,_,_,_,_), IDs),
    findall(Attack, inventory(_,_,_,_,Attack,_), Attacks),
    findall(Def, inventory(_,_,_,_,_,Def), Defs),
    write('----------------'), nl,
    write('Weapon:'), nl,
    listing(Names, IDs, Attacks, Defs).

listPotion:-
    findall(PotionName, inventory(_,_,_,PotionName,_,_), PNames),
    findall(ItemID, inventory(ItemID,_,_,_,_,_), IDs),
    findall(PlusHP, inventory(_,_,_,_,PlusHP,_), HPs),
    findall(PlusMana, inventory(_,_,_,_,_,_,PlusMana), ManaS),
    write('----------------'), nl,
    write('Potion:'), nl,
    listingP(PNames, IDs, HPs, ManaS).

listInventory:-
    listItem,
    listPotion.





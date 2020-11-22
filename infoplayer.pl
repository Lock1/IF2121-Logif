:- dynamic(inventory/6)

inventoryMax(100).

/*inventory(ItemID, class, category, name, attack, def)*/
inventoryLength(Length) :-
    findall(ItemName, inventory(_,_,_,ItemName,_,_), List),
    length(List,Length).


addItem(_) :-
    cekPanjang(Length),
    inventoryMax(Max),
    Length >= Max,
    write('Maaf bang inventory udah penuh'),
    !,fail.

addItem(ItemID) :-
    item(ItemID, ClassType, Category, ItemName, Attack, Def),
    asserta(inventory(ItemID, Class, Category, ItemName, Attack, Def)),!.

delItem(ItemID) :-
    \+inventory(ItemID,_,_,_,_,_),
    write('Gaada item yang dimaksud bang'),!,fail.

delItem(ItemID) :-
    retract(inventory(ItemID,_,_,_,_,_)), !.

createListInventory(ListItemName, ListCategory) :-
    findall(ItemName, inventory(_,_,_,ItemName,_,_)),
    findall(Class, inventory(_,Class,_,_,_,_)),
    findall()

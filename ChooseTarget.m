function [CurrItem] = ChooseTarget(Itemat)

Nitem = length(Itemat(:));
RandSelect = randperm(Nitem);
CurrItem   = Itemat(RandSelect(1));





function [U] = DesignParam(Itemat,FlashOrd,iflash)

Nitem = length(Itemat(:));
SRNitem = sqrt(Nitem);

if ~rem(SRNitem,round(SRNitem))
   
    if 2*SRNitem ~= length(FlashOrd)
        error('There is a problem with the dimensions of the item Matrix');
    end
    
    CurrFlash = FlashOrd(iflash);
    if CurrFlash > 6 % columns
        U = Itemat(:,CurrFlash-6);
    else % rows
        U = Itemat(CurrFlash,:);
    end
    
else
    error('This number of items is not yet supported');
end
function [] = OnlineDisplay(Itemat,Y,Target,U,LogProb,HypProb_ffx,HypProb_rfx,fignum)

disp(' ');
disp(['La cible est: ' Target]);
disp(' ');
disp(' ');
disp(['Les lettres flashées sont: ' U{:}]);
disp(' ');


Itemvec = Itemat(:)';
Tc = strcmp(Itemvec,Target);
item = find(Tc);
Uf = zeros(1,36);
for k = 1:length(U)
    Uf = Uf + strcmp(Itemvec,U(k));
end

figure(fignum);

%% Target item
IMD(Itemat,Tc,'g',1);

%% Flashed items
IMD(Itemat,Uf,'w',4);

%% Data feature
subplot(2,3,2);
hold on
if any(strcmp(U,Target))
    plot(Y,'g');
else
    plot(Y,'w');
end

%% Classification posterior probabilities
ClassPostProb = exp(LogProb);
ClassPostProb = ClassPostProb/sum(ClassPostProb);
subplot(2,3,5);
hold off
bar(1:3,ClassPostProb,0.7); drawnow

%% FFX BMS
subplot(2,3,3);
hold off
bar(1:37,HypProb_ffx,0.7); drawnow
hold on; line([item,item],[0 1],'color','r');

%% RFX BMS
subplot(2,3,6);
hold off
bar(1:37,HypProb_rfx,0.7); drawnow
hold on; line([item,item],[0 1],'color','r');

end


%% Item Matrix Display
function IMD(Itemat,U,col,sp)

subplot(2,3,sp);

colordef black
colormap gray
Mat = zeros(7,7);
pcolor(Mat);
axis square
axis off

for i = 1:6
    for j = 1:6
        text(j+0.5,7-i+0.5,Itemat(i,j),'FontSize',14,'color','k');
    end
end

Iflash = find(U);
for k = 1:length(Iflash)
    
    L = Iflash(k);
    iL = ceil(L/6);
    jL = L - (iL-1)*6;
    if iL == 0
        iL = 6;
    end
    
    text(jL+0.5,7-iL+0.5,Itemat(iL,jL),'FontSize',18,'color',col);
    
end

end


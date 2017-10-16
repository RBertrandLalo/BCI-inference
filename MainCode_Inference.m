function MainCode_Inference(Nitem)

Fdisp = 1;
SimulType = 'Synth';
PriorCoef = 10;

warning off
addpath('../matlab/prog/spm12');

%% Matrix of items
Itemat = {'A' 'B' 'C' 'D' 'E' 'F' ; 'G' 'H' 'I' 'J' 'K' 'L' ; 'M' 'N' 'O' 'P' 'Q' 'R' ; 'S' 'T' 'U' 'V' 'W' 'X' ; 'Y' 'Z' '1' '2' '3' '4' ; '5' '6' '7' '8' '9' '_'};

%% Setting other fixed design and model parameters
Nreplim   = 10;
Nflashmax = Nreplim * 12;
Nhyp = length(Itemat(:)) + 1; % adding the class 'any item' 
%Nclass = ClassifParam;    
Nclass = 3;

%% RFX priors
Alpha = ones(Nclass,Nclass) + PriorCoef*eye(Nclass,Nclass);

for k = 1:Nitem
   
    %% Choose target item k
    Target = ChooseTarget(Itemat);
    FlashOrd  = randperm(12);
    
    %% Initialization of prior hyp. probabilities
    HypProb_ffx = (1/Nhyp)*ones(1,Nhyp);
    HypProb_rfx = (1/Nhyp)*ones(1,Nhyp);
    
    LogProb_rfx = zeros(Nflashmax,Nclass);
    U_rfx = cell(1,Nflashmax);
    
    iflash = 0;
    if Fdisp
        h = figure;
    end
    
    while iflash <= Nflashmax
        
        iflash  = iflash + 1;
        
        %% Design parameter (items to be flashed)
        cflash = rem(iflash,12);
        if ~cflash
            cflash = 12;
        end
        U = DesignParam(Itemat,FlashOrd,cflash);
        
        %% Feature extraction
        Y = DataSimul(U,Target,SimulType);
        
        %% Feature classification
        ClassifParamFile = '../ParamSimuReal.mat';
        LogProb = FeatClassif(Y,ClassifParamFile);
        
        %% FFX Inference
        HypProb_ffx = Inference_ffx(LogProb,U,HypProb_ffx,Itemat);
        
        %% RFX Inference
%         LogProb_rfx(iflash,:) = LogProb;
%         U_rfx{iflash} = U;
%         HypProb_rfx = Inference_rfx(LogProb_rfx,U_rfx,HypProb_rfx,Alpha,iflash,Itemat);

        %% Display
        if Fdisp
            OnlineDisplay(Itemat,Y,Target,U,LogProb,HypProb_ffx,HypProb_rfx,h);
            pause
        end
        
        %% Stopping criterion
        
    end
    
end


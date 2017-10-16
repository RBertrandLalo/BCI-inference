function [PostProb_ffx] = Inference_ffx(LogFeat,U,PriorProb_ffx,Itemat)

Nhyp = length(PriorProb_ffx);
LogPost = zeros(1,Nhyp);

%% Null hypothesis (no item is being targeted)
LogPost(end) = log(PriorProb_ffx(end)) + LogFeat(3);

%% Alternative hypotheses
Itemvec = Itemat(:);
for k = 1:Nhyp-1    
    Item_k = Itemvec(k);
    if any(strcmpi(Item_k,U))
        LogPost(k) = log(PriorProb_ffx(k)) + LogFeat(1);
    else
        LogPost(k) = log(PriorProb_ffx(k)) + LogFeat(2);
    end 
end

%% Computing the Posterior Probabilities
%LPm  = max(LogPost);
%LogPost = LogPost - LPm + 1;
PostProb_ffx = exp(LogPost);
PostProb_ffx = PostProb_ffx/sum(PostProb_ffx);

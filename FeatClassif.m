function [LogProb] = FeatClassif(Y,ClassifParamFile)

fact = 1;
load(ClassifParamFile);
ClassifParam(1).mu = m1;
ClassifParam(1).sigma = fact*diag(v1);
ClassifParam(2).mu = m0;
ClassifParam(2).sigma = fact*diag(v0);
ClassifParam(3).mu = zeros(size(m0));
ClassifParam(3).sigma = fact*diag(v0);

Nf = length(Y);             % Feature size
Nk = length(ClassifParam);  % Number of classes

LogProb = zeros(1,Nk);

for k = 1:Nk   
    x = ClassifParam(k).mu;
    S = ClassifParam(k).sigma;
    LDS = spm_logdet(S);
    LogProb(k) = -0.5*LDS -(Nf/2)*log(2*pi) -0.5*(x-Y)'*(S\(x-Y));
end

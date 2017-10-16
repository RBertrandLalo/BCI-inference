function [Y] = DataSimul(U,Target,Type)


%% Simulation type
if strcmp(Type,'Synth')
    load('/../ParamSimuReal.mat');
    fact = 0;
    % Target model (1)
    Param(1).mu = m1;
    Param(1).sigma = fact*diag(v1);
    Param(1).a = 10;
    Param(1).b = 2;
    Param(1).c = 0;
    % Distractor model (2)
    Param(2).mu = m0;
    Param(2).sigma = fact*diag(v0);
    Param(2).a = 2;
    Param(2).b = 10;
    Param(2).c = 0;
    % Look away model model (3)
    Param(3).mu = zeros(size(m0));
    Param(3).sigma = fact*diag(v0);
    Param(3).a = 2;
    Param(3).b = 2;
    Param(3).c = 5;
elseif strcmp(Type,'Real')
    %DataPath = '';
    %DataFile = '';
else
    error('No such Simulation type');
end


%% Simulating the data features
if ~isempty(intersect(U,Target)) % the target has been flashed
    
    if strcmp(Type,'Synth')
        r = gamrnd([Param(1).a Param(1).b Param(1).c],1);
        r = r/sum(r);
        c = mnrnd(1,r);
        if c(1) % a target-like response is generated
            Y = mvnrnd(Param(1).mu,Param(1).sigma);
        elseif c(2) % a distractor-like response is generated
            Y = mvnrnd(Param(2).mu,Param(2).sigma);
        elseif c(3) % a look-away response is generated
            Y = mvnrnd(Param(3).mu,Param(3).sigma);
        end
    else
        disp('not yet implemented');    
    end
    
else % the target has not been flashed
    
    if strcmp(Type,'Synth')    
        r = gamrnd([Param(2).a Param(2).b Param(2).c],1);
        r = r/sum(r);
        c = mnrnd(1,r);
        if c(1) % a target-like response is generated
            Y = mvnrnd(Param(1).mu,Param(1).sigma);
        elseif c(2) % a distractor-like response is generated
            Y = mvnrnd(Param(2).mu,Param(2).sigma);
        elseif c(3) % a look-away response is generated
            Y = mvnrnd(Param(3).mu,Param(3).sigma);
        end
    else
        disp('not yet implemented');    
    end
    
end

Y = Y';

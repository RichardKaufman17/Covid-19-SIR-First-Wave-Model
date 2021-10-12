function Sr = getError(param, finish,start,h, trueActive)
%getError: active case sum of the squared residuals
%function Sr = getError(param, finish,start,h, trueActive)
%Richard Kaufman 12/18/20 ES55
%   computes estimate of the active cases and compares this to the 
%accepted active case data 
%Inputs
%   param: length 3 array containing infection rate, recovery rate, 
%   and scaling factor respectively 
%   finish: index of the last day of first wave
%   start: index of the first day of first wave
%   h:step size
%   trueActive: accepted active case data 
%Output:
%   Sr: Sum of the squared residuals between the accepted and estimate
%   values

infected = calcInfected(param, finish, start, h);

Sr = sum((trueActive(start:finish) - infected).^2);

end


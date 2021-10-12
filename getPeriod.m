function [start,finish] = getPeriod(activeCases)
%getPeriod: time period first wave
%function [start,finish] = getPeriod(activeCases)
%Richard Kaufman 12/18/20 ES55
%   calculates the indices of the start and end of the first wave
%Inputs
%   activeCases: the daily active case data
%Output:
%   start: index of the first day of the first wave
%   finish: index of the last day of the first wave

%calculate derivative of active case data
smoothActive = movmean(activeCases,15); 
smoothDiff = gradient(smoothActive);

%finds first local minimum 
finish = length(activeCases);
for i = [50:length(smoothDiff)-1]
    if smoothDiff(i)*smoothDiff(i+1) < 0 && smoothDiff(i)...
        <smoothDiff(i+1) || smoothDiff(i)==0
        finish = i;
        break
    end
end

%finds date of first Covid-19 case
start = 1;
while activeCases(i) == 0
    start = start+1;
end

end


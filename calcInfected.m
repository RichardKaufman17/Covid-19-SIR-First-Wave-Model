function infected = calcInfected(param,finish,start,h)
%calcInfected: SIR solution Euler's Method
%the active cases over a time period and given SIR parameters
%infected = calcInfected(param,finish,start,h)
%Richard Kaufman 12/18/20 ES55
%   uses the SIR model and Euler's method to estimate
%the active cases over a time period and given SIR parameters
%Inputs
%   param: length 3 array containing infection rate, recovery rate, 
%   and scaling factor respectively 
%   start: index of the first day of first wave
%   finish: index of the last day of first wave
%   h: step size
%Output:
%   infected: time dependent active case data from SIR model

    beta = param(1);
    K = param(2);
    
    %initializing active cases
    infected = zeros((finish - start +1)/h,1);
    infected(1) = 1/param(3);
    
    %initializing susceptible population
    susceptible = zeros((finish - start+1)/h,1);
    susceptible(1) = 1 - infected(1);
    
    
    for i = [2:length(susceptible)]
        
        %Calculate change in variables from previous iteration
        drdt = infected(i-1)*K;
        didt = beta*infected(i-1)*susceptible(i-1) - drdt;
        dsdt = beta*infected(i-1)*susceptible(i-1);
        
        %Apply Eurler's Method
        infected(i) = infected(i-1)+didt*h;
        susceptible(i) = susceptible(i-1) - dsdt*h;
    end

    %Scaling the active case data
    infected = infected*param(3);
end


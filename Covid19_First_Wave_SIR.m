%Richard Kaufman 12/18/20 ES55
%Kaufman_project_2020 imports Covid-19 data and uses an SIR model to 
%estimate the rate of infection and rate of recovery for two countries

%Imported Covid-19 Data
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
confirmed = readtable('Covid-19 Confirmed Cases Sample.csv');
deaths = readtable('Covid-19 Deaths Sample.csv');
recovered = readtable('Covid-19 Recovered Sample.csv');
countryList = readtable('Country List.csv');

%GUI to pick the two countries for analysis
stop = 0;
answer = questdlg('Choose how to pick your countries','Welcome','Choose myself','Pick for me','Pick for me');
while stop ~= 2
    if answer == "Pick for me"
        indices = randperm(length(countryList.('Country')),2);
        country1 = countryList.('Country')(indices(1));
        country2 = countryList.('Country')(indices(2));
        country1 = country1{1,:};
        country2 = country2{1,:};
        break
    end
    stop = 0;
    prompt = {'Country One', 'Country Two'};
    inputTitle = 'Compare Two Countries';
    country = inputdlg(prompt, inputTitle,2);
    country1 = country{1,1};
    country2 = country{2,1};
    for i = [1:length(countryList.('Country'))]
        tempCountry = countryList.('Country')(i);
        if convertCharsToStrings(country1) == ...
                convertCharsToStrings(tempCountry{1,:}) ||...
                convertCharsToStrings(country2) == ...
                convertCharsToStrings(tempCountry{1,:})
            stop = stop +1;
        end
    end
    if stop ~=2
        answer = questdlg('One or more countries entered are not in the database','Error','Retry','Pick for me','Pick for me');
    end
end
    
dates = confirmed.('Date');

%creating arrays from table data for country 1
[confirmed1, recovered1, deaths1, trueActive] = ...
getCountryData(confirmed, recovered,deaths, country1);

%Finding first wave for country 1
[start, finish] = getPeriod(trueActive);

%Finding the best SIR model and parameters for country 1
h = 1; %Step size of one day
param0 = [.2,.05, 100000]; %Initial guess
[infected,optimalParams1] = getOptimalModel(finish, start, h,...
    param0, trueActive);

plotTitle = sprintf('Covid-19 Data in %s', country1);
figure(1)
plot(dates,confirmed1)
hold on
plot(dates, deaths1)
plot(dates, recovered1)
plot(dates, trueActive)
legend('Confirmed', 'Dead', 'Recovered', 'Active', 'Location', 'northwest')
xlabel('Date')
ylabel('Number of People')
title(plotTitle)
hold off

plotTitle = sprintf('Active Cases for First Wave in %s', country1);
results = sprintf('Infection Rate: %g\nRemoval Rate: %g\nScaling Factor %g', optimalParams1(1), optimalParams1(2), round(optimalParams1(3),0));
figure(2)
plot(dates(start:finish),trueActive(start:finish), 'b-')
hold on 
plot(dates(start:finish),infected, 'r--')
legend('Active Cases','SIR Model Fit','Location', 'northwest')
xlabel('Date')
ylabel('Number of Active Cases')
title(plotTitle)
text(dates(start),mean(trueActive(start:finish)),results)
hold off

%Extracting arrays from tables for country 2
[confirmed2, recovered2, deaths2, trueActive] = ...
getCountryData(confirmed, recovered,deaths, country2);

%finding first wave date indices for country 2
[start, finish] = getPeriod(trueActive);

%Finding the best SIR model and parameters for country 2
h = 1; %Step size of one day
param0 = [.1,.05, 100000]; %Initial Guess
[infected,optimalParams2] = getOptimalModel(finish, start, h,...
    param0, trueActive);

plotTitle = sprintf('Covid-19 Data in %s', country2);
figure(3)
plot(dates,confirmed2)
hold on
plot(dates, deaths2)
plot(dates, recovered2)
plot(dates, trueActive)
legend('Confirmed', 'Dead', 'Recovered', 'Active', 'Location', 'northwest')
xlabel('Date')
ylabel('Number of People')
title(plotTitle)
hold off

plotTitle = sprintf('Active Cases for First Wave in %s', country2);
results = sprintf('Infection Rate: %g\nRemoval Rate: %g\nScaling Factor %g', optimalParams2(1), optimalParams2(2), round(optimalParams2(3),0));
figure(4)
plot(dates(start:finish),trueActive(start:finish), 'b-')
hold on 
plot(dates(start:finish),infected, 'r--')
legend('Active Cases','SIR Model Fit','Location', 'northwest')
xlabel('Date')
ylabel('Number of Active Cases')
title(plotTitle)
text(dates(start),mean(trueActive(start:finish)),results)
hold off

%Comparing country 1 and country 2
figure(5)
X = categorical({country1, country2});
Y = [optimalParams1(1) optimalParams2(1)];
bar(X,Y)
title('Infection Rate Comparison')
ylabel('Infection Rate')

figure(6)
X = categorical({country1, country2});
Y = [optimalParams1(2) optimalParams2(2)];
bar(X,Y)
title('Recovery Rate Comparison')
ylabel('Recovery Rate')
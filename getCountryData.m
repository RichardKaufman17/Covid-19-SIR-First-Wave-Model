function [confirmed, recovered, deaths, active] = ...
getCountryData(confirmed, recovered,deaths, country)
%getCountryData: calculate active cases
%function [confirmed, recovered, deaths, active] = getCountryData(confirmed, recovered,deaths, country)
%Richard Kaufman 12/18/20 ES55
%   converts table data to arrays for a specified country and calculates active cases
%Inputs
%   confirmed: Covid-19 daily confirmed cases
%   recovered: Covid-19 daily recovery data
%   deaths: Covid-19 daily death data
%   country: the country to retrieve data for
%Output:
%   confirmed: confirmed cases for the specified country
%   recovered: recovered cases for the specified country
%   deaths:deaths for the specified country
%   active:active cases for the specifed country

confirmed = confirmed.(country);
recovered = recovered.(country);
deaths = deaths.(country);
active = confirmed - recovered - deaths;

end


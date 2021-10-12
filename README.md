# Covid-19-SIR-First-Wave-Model
This repository contains my final project from my Numerical Methods class. The program analyzes and compares Covid-19 case data from two countries. More specifically, a Susceptible-Infected-Removed (SIR) model is developed for the first wave of the pandemic in each country. The SIR model is a set of three ordinary differential equations that depict the susceptible, infected, and removed (recovered cases and deaths) populations as a function of time. The program finds the optimal infection rate, recovery rate, and scaling factor needed to fit the SIR model to the true active case data. 

## Inputs
### Imported Data: 4 csv files
1.	List of countries included in the sample data
<br />  a.	Austria
<br />  b.	France
<br />  c.	Germany
<br />  d.	Israel
<br />  e.	Italy
<br />  f.	Japan
<br />  g.	Romania
<br />  h.	Russia
<br />  i.	South Korea*
<br />  j.	Switzerland
2.	Cumulative Confirmed Covid-19 cases from 01/22/2020 - 12/13/2020
3.	Cumulative Covid-19 deaths from 01/22/2020 - 12/13/2020
4.	Cumulative Covid-19 recoveries from 01/22/2020 - 12/13/2020
### User Input
The user has one of two options:
- Manually type in two countries from the sample data to analyze
- Request the program to pick two countries from the sample data at random to analyze
## Outputs
**The program does the following**
- Imports Covid-19 Data on confirmed cases, recoveries, and deaths
- Asks the user to manually or randomly pick two countries
- Extracts the data from the countries chosen and calculates active cases
- Determines timespan of first wave by finding the day of the first case and the day of the first local minimum of active cases
  - Calculates the first local minimum of active cases by approximating the derivative using the built in MATLAB gradient() function 
- Creates SIR simulation to estimate the daily active cases for a given infection rate, recovery rate, and scaling factor using Euler’s method
- Determines the error between the true and simulated active cases using the sum of squared residuals
- MATLAB built-in function fminsearch() determines the infection rate, recovery rate, and scaling factor that minimize the sum of the squared residuals
- Displays the confirmed and active cases, recoveries and deaths over time for both countries
- Displays the active cases for the first wave of both countries along with the best SIR model fit, including text listing the optimal infection rate, recovery rate, and ---scaling factor that produced this best fit
- Displays a bar graph juxtaposing the infection rates and recovery rates of both countries 

## Numerical Methods
1.	Ordinary Differential Equations: Euler’s Method and systems of first order ODEs
2.	Differentiation: forwards, backwards, and centered differentiation using built-in MATLAB function gradient()
3.	Optimization: three variable optimization using MATLAB built-in function fminsearch()
4.	Random Numbers: MATLAB built-in function randperm()
5.	Least Squares Regression: sum of the square of residuals
6.	Graphics: plots of results and graphical user interface


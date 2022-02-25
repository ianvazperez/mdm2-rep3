T = readtable('data.xlsx');
carsArr = table2array(T(:,5));
s = length(carsArr);
InArr = zeros(s/2,1);
OutArr = zeros(s/2,1);
DaysArr = zeros(s/2,1);
for c = 1:s
    if (mod(c,2) == 1)
        InArr(((c+1)/2),1)= carsArr(c,1);
    else
        DaysArr(c/2,1) = c/2;
        OutArr((c/2),1) = carsArr(c,1);
    end 
end
TotArr = zeros(s/2,1);
for j = 1:(s/2)
    TotArr(j,1) = InArr(j,1)+OutArr(j,1);
end
WeekTotArr = zeros(261,1);
WeekDaysArr = zeros(261,1);
Weekindex = 0;
for i = 1:365
    if (mod(i,7) ~= 0)
        if (mod(i,7) ~= 6)
            Weekindex = Weekindex + 1;
            WeekDaysArr(Weekindex,1) = Weekindex;
            WeekTotArr(Weekindex,1) = TotArr(i,1);
        end
    end   
end
% x=DaysArr;
% y=TotArr;
% 
% % Fit linear regression line with OLS.
% b = [ones(size(x,1),1) x]\y;
% % Use estimated slope and intercept to create regression line.
% RegressionLine = [ones(size(x,1),1) x]*b;
% % Plot it in the scatter plot and show equation.
% hold on,
% fprintf('Regression line (y = %0.2f*x + %0.2f)',b(2),b(1))
% legend('location','nw')
% % RMSE between regression line and y
% RMSE = sqrt(mean((y-RegressionLine).^2));
% % R2 between regression line and y
% SS_X = sum((RegressionLine-mean(RegressionLine)).^2);
% SS_Y = sum((y-mean(y)).^2);
% SS_XY = sum((RegressionLine-mean(RegressionLine)).*(y-mean(y)));
% R_squared = SS_XY/sqrt(SS_X*SS_Y);
% fprintf('RMSE: %0.2f | R2: %0.2f\n', RMSE, R_squared)

Totp1 = polyfit(DaysArr,TotArr,1);
Totf1 = polyval(Totp1,DaysArr);

Totp2 = polyfit(DaysArr,TotArr,2);
Totf2 = polyval(Totp2,DaysArr);

Totp3 = polyfit(DaysArr,TotArr,3);
Totf3 = polyval(Totp3,DaysArr);

Totp4 = polyfit(DaysArr,TotArr,9);
Totf4 = polyval(Totp4,DaysArr);

Totr1 = polyval(Totp1,DaysArr)-TotArr;
Totr2 = polyval(Totp2,DaysArr)-TotArr;
Totr3 = polyval(Totp3,DaysArr)-TotArr;
Totr4 = polyval(Totp4,DaysArr)-TotArr;

% Plotting graphs(Total year)
figure(1)

subplot(2,2,1)
plot(DaysArr, TotArr, '-xr')
hold on
plot(DaysArr, Totf1, 'k--','LineWidth',1.5)
grid on
title('1st order fit')
xlabel('Days'), ylabel('Total cars')

subplot(2,2,2) 
plot(DaysArr, TotArr, '-xr')
hold on
plot(DaysArr, Totf2, 'k--','LineWidth',1.5)
grid on
title('2nd order fit')
xlabel('Days'), ylabel('Total cars')

subplot(2,2,3)
plot(DaysArr, TotArr, '-xr')
hold on
plot(DaysArr, Totf3, 'k--','LineWidth',1.5)
grid on
title('3rd order fit')
xlabel('Days'), ylabel('Total cars')

subplot(2,2,4)
plot(DaysArr, TotArr, '-xr')
hold on
plot(DaysArr, Totf4, 'k--','LineWidth',1.5)
grid on
title('9th order fit')
xlabel('Days'), ylabel('Total cars')

sgtitle('Model fits - using total 2021 data') 

figure(2)

subplot(2,2,1)
plot(DaysArr, Totr1, 'k*')
grid on
title('1st Order Residuals')
xlabel('Days'), ylabel('Error')

subplot(2,2,2)
plot(DaysArr, Totr2, 'k*')
grid on
title('2nd Order Residuals')
xlabel('Days'), ylabel('Error')

subplot(2,2,3)
plot(DaysArr, Totr3, 'k*')
grid on
title('3rd Order Residuals')
xlabel('Days'), ylabel('Error')

subplot(2,2,4)
plot(DaysArr, Totr4, 'k*')
grid on
title('9th Order Residuals')
xlabel('Days'), ylabel('Error')

sgtitle('Regression analysis graph - using total 2021 data') 


% Plotting graphs(Week days only)
WeekDaysp1 = polyfit(WeekDaysArr,WeekTotArr,1);
WeekDaysf1 = polyval(WeekDaysp1,WeekDaysArr);

WeekDaysp2 = polyfit(WeekDaysArr,WeekTotArr,2);
WeekDaysf2 = polyval(WeekDaysp2,WeekDaysArr);

WeekDaysp3 = polyfit(WeekDaysArr,WeekTotArr,3);
WeekDaysf3 = polyval(WeekDaysp3,WeekDaysArr);

WeekDaysp4 = polyfit(WeekDaysArr,WeekTotArr,9);
WeekDaysf4 = polyval(WeekDaysp4,WeekDaysArr);

WeekDaysr1 = polyval(WeekDaysp1,WeekDaysArr)-WeekTotArr;
WeekDaysr2 = polyval(WeekDaysp2,WeekDaysArr)-WeekTotArr;
WeekDaysr3 = polyval(WeekDaysp3,WeekDaysArr)-WeekTotArr;
WeekDaysr4 = polyval(WeekDaysp4,WeekDaysArr)-WeekTotArr;

figure(3)

subplot(2,2,1)
plot(WeekDaysArr, WeekTotArr, '-xr')
hold on
plot(WeekDaysArr, WeekDaysf1, 'k--','LineWidth',1.5)
grid on
title('1st order fit')
xlabel('Days'), ylabel('Total cars')

subplot(2,2,2) 
plot(WeekDaysArr, WeekTotArr, '-xr')
hold on
plot(WeekDaysArr, WeekDaysf2, 'k--','LineWidth',1.5)
grid on
title('2nd order fit')
xlabel('Days'), ylabel('Total cars')

subplot(2,2,3)
plot(WeekDaysArr, WeekTotArr, '-xr')
hold on
plot(WeekDaysArr, WeekDaysf3, 'k--','LineWidth',1.5)
grid on
title('3rd order fit')
xlabel('Days'), ylabel('Total cars')

subplot(2,2,4)
plot(WeekDaysArr, WeekTotArr, '-xr')
hold on
plot(WeekDaysArr, WeekDaysf4, 'k--','LineWidth',1.5)
grid on
title('9th Order fit')
xlabel('Days'), ylabel('Total cars')

sgtitle('Model fits - using week days 2021 data') 

figure(4)
subplot(2,2,1)
plot(WeekDaysArr, WeekDaysr1, 'k*')
grid on
title('1st Order Residuals')
xlabel('Days'), ylabel('Error')

subplot(2,2,2)
plot(WeekDaysArr, WeekDaysr2, 'k*')
grid on
title('2nd Order Residuals')
xlabel('Days'), ylabel('Error')

subplot(2,2,3)
plot(WeekDaysArr, WeekDaysr3, 'k*')
grid on
title('3rd Order Residuals')
xlabel('Days'), ylabel('Error')

subplot(2,2,4)
plot(WeekDaysArr, WeekDaysr4, 'k*')
grid on
title('9th Order Residuals')
xlabel('Days'), ylabel('Error')

sgtitle('Regression analysis graph - using week days 2021 data') 

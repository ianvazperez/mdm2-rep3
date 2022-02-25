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
x=DaysArr;
y=TotArr;

Totp1 = polyfit(DaysArr,TotArr,1);
Totf1 = polyval(Totp1,DaysArr);

Totp2 = polyfit(DaysArr,TotArr,2);
Totf2 = polyval(Totp2,DaysArr);

Totp3 = polyfit(DaysArr,TotArr,3);
Totf3 = polyval(Totp3,DaysArr);

Totp4 = polyfit(DaysArr,log(TotArr),1);
Totf4 = polyval(Totp4,DaysArr);

Totr1 = polyval(Totp1,DaysArr)-TotArr;
Totr2 = polyval(Totp2,DaysArr)-TotArr;
Totr3 = polyval(Totp3,DaysArr)-TotArr;
Totr4 = exp(polyval(Totp4,DaysArr))-TotArr;


% Plotting graphs(Week days only)
WeekDaysp1 = polyfit(WeekDaysArr,WeekTotArr,1);
WeekDaysf1 = polyval(WeekDaysp1,WeekDaysArr);

WeekDaysp2 = polyfit(WeekDaysArr,WeekTotArr,2);
WeekDaysf2 = polyval(WeekDaysp2,WeekDaysArr);

WeekDaysp3 = polyfit(WeekDaysArr,WeekTotArr,3);
WeekDaysf3 = polyval(WeekDaysp3,WeekDaysArr);

WeekDaysp4 = polyfit(WeekDaysArr,log(WeekTotArr),1);
WeekDaysf4 = polyval(WeekDaysp4,WeekDaysArr);

WeekDaysr1 = polyval(WeekDaysp1,WeekDaysArr)-WeekTotArr;
WeekDaysr2 = polyval(WeekDaysp2,WeekDaysArr)-WeekTotArr;
WeekDaysr3 = polyval(WeekDaysp3,WeekDaysArr)-WeekTotArr;
WeekDaysr4 = exp(polyval(WeekDaysp4,WeekDaysArr))-WeekTotArr;

figure(3)
Pred0 = zeros(1,261);
Pred1 = zeros(1,261);
Pred2 = zeros(1,261);
Pred3 = zeros(1,261);
Pred4 = zeros(1,261);
total = 0;
for j = (1:100)
    for i = (1:261)
        
        Rand0 = normrnd(-2.37653e-12, 1864.4);
        while abs(Rand0) > 500
            Rand0 = normrnd(-2.37653e-12, 1864.4);
        end
        Pred0(i) = WeekDaysp1(1)*WeekDaysArr(i) + WeekDaysp1(2) + Rand0;
        
        Rand1 = normrnd(-2.37653e-12, 1864.4);
        while abs(Rand1) > 500
            Rand1 = normrnd(-2.37653e-12, 1864.4);
        end
        Pred1(i) = WeekDaysp1(1).*(WeekDaysArr(i))+ WeekDaysp1(2) + Rand1;
       
        Rand2 = normrnd(-8.22378e-13, 1426.39);
        while abs(Rand2) > 500
            Rand2 = normrnd(-8.22378e-13, 1426.39);
        end
        Pred2(i) = WeekDaysp2(1).*(WeekDaysArr(i)).^2 + WeekDaysp2(2).*WeekDaysArr(i) + WeekDaysp2(3) + Rand2;
        
        Rand3 = normrnd(-2.23018e-12, 1379.59);
        while abs(Rand3) > 500
            Rand3 = normrnd(-2.23018e-12, 1379.59);
        end
        
        Pred3(i) = WeekDaysp3(1).*(WeekDaysArr(i)).^3 + WeekDaysp3(2).*(WeekDaysArr(i)).^2 + WeekDaysp3(3).*WeekDaysArr(i) + WeekDaysp3(4) + Rand3;
  
    end

    minus = WeekTotArr - Pred3';
    length(minus);
    msq = minus.^2;
    means = mean(msq);
    %RMSE = sqrt(means);
    total = total + means;
    
end
plot(WeekDaysArr,Pred3)
average = total/100

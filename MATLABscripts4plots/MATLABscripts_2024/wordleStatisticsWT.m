clc; clear; close all;

strLoadReduction = """wind turbine control"",""load reduction""";
strIPC = """wind turbine control"", (""individual pitch control"" OR IPC)""";
strMPC = """wind turbine control"", (""model predictive control"" OR MPC)""";

wt.LoadReduction = [1980,0
 1981,0
 1982,0
 1983,1
 1984,0
 1985,0
 1986,0
 1987,0
 1988,0
 1989,1
 1990,0
 1991,0
 1992,0
 1993,2
 1994,0
 1995,3
 1996,2
 1997,0
 1998,1
 1999,0
 2000,6
 2001,1
 2002,1
 2003,6
 2004,12
 2005,7
 2006,19
 2007,21
 2008,21
 2009,40
 2010,47
 2011,97
 2012,96
 2013,113
 2014,131
 2015,128
 2016,145
 2017,137
 2018,153
 2019,103
 2020,144
 2021,121
 2022,172
 2023,126];

wt.IPC = [1980,0
1981,0
1982,0
1983,0
1984,0
1985,0
1986,0
1987,0
1988,0
1989,0
1990,1
1991,0
1992,0
1993,0
1994,0
1995,0
1996,0
1997,0
1998,1
1999,0
2000,2
2001,1
2002,2
2003,3
2004,0
2005,2
2006,8
2007,9
2008,15
2009,23
2010,39
2011,61
2012,59
2013,86
2014,93
2015,90
2016,100
2017,94
2018,121
2019,92
2020,137
2021,115
2022,136
2023,113];

wt.MPC = [1980,0
1981,0
1982,0
1983,0
1984,0
1985,0
1986,0
1987,0
1988,0
1989,0
1990,0
1991,0
1992,0
1993,0
1994,0
1995,0
1996,0
1997,1
1998,2
1999,0
2000,0
2001,1
2002,0
2003,0
2004,0
2005,1
2006,2
2007,5
2008,8
2009,18
2010,1
2011,58
2012,65
2013,97
2014,127
2015,127
2016,145
2017,153
2018,181
2019,199
2020,223
2021,244
2022,288
2023,284];

%% figures dissertaion
y0 = 1995;
ye = 2022;
delta = 2;
idxYear = wt.LoadReduction(:,1) >= y0 & wt.LoadReduction(:,1) <= ye;
cl = lines;
fig = figure(1);
fs = 19;
pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*1.7,pos(4)]);

titleStr = {['{\color[rgb]{',num2str(cl(1,:)),'}',char(strLoadReduction)],...
    ['\color[rgb]{',num2str(cl(2,:)),'}',char(strIPC),'}']};
xlabelStr = 'Year';
ylabelStr = 'No. of Google Scholar Entries';

fig.Name = 'Key words: WT ctrl, Load reduction'; 
bar(wt.LoadReduction(idxYear,1),[wt.LoadReduction(idxYear,2),wt.IPC(idxYear,2)])
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
%legend('Load reduction', 'IPC','location', 'NorthWest')

set(gca,'XTick',y0:delta:ye,'XTicklabel',y0:delta:ye,'Fontsize',fs)
set(gca,'XTickLabelRotation',45)
set(findall(gcf,'-property','FontSize'),'FontSize',fs)
title(titleStr,'FontSize',fs+2);

filenamepng = sprintf('googleWordleWTLoadRedIPC');
print(gcf,fullfile(filenamepng), '-dpng');
print(gcf,fullfile(filenamepng), '-depsc');


titleStr = ['{\color[rgb]{',num2str(cl(1,:)),'}',char(strMPC),'}'];

fig = figure(2);
fig.Name = 'Key words: MPC'; 
bar(wt.MPC(idxYear,1),wt.MPC(idxYear,2))
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
title(titleStr);
set(gca,'XTick',y0:delta:ye,'XTicklabel',y0:delta:ye,'Fontsize',fs)
set(gca,'XTickLabelRotation',45)
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1:2), pos(3)*1.7,pos(4)]);
set(findall(gcf,'-property','FontSize'),'FontSize',fs)
title(titleStr,'FontSize',fs+2);

filenamepng = sprintf('googleWordleWTMPC');
print(gcf,fullfile(filenamepng), '-dpng');
print(gcf,fullfile(filenamepng), '-depsc');


% titleStr = [testCaseStr,': Mdl1: Rot+Twr {\color[rgb]{',num2str(cl(1,:)),'}Mdl2: Rot,Twr,Bld+Act ',...
%     '\color[rgb]{',num2str(cl(2,:)),'}FAST} '];


fig = figure(3);

tmp = lines;
clk = [zeros(1,3); tmp(1:2,:)]; 
fig.Name = 'Key words: IPC and MPC'; 

titleStr = {strLoadReduction, ...
    ['{\color[rgb]{',num2str(cl(1,:)),'}',char(strIPC)],...
    ['\color[rgb]{',num2str(cl(2,:)),'}',char(strMPC),'}']};

b = bar(wt.LoadReduction(idxYear,1),[wt.LoadReduction(idxYear,2),wt.IPC(idxYear,2),wt.MPC(idxYear,2)]);
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
title(titleStr);


for k = 1:3
    b(k).FaceColor = clk(k,:);
end

pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*1.7,pos(4)]);

set(findall(gcf,'-property','FontSize'),'FontSize',fs)
title(titleStr,'FontSize',fs+1);

filenamepng = sprintf('agoogleWordleWTMPCIPC');
print(gcf,fullfile(filenamepng), '-dpng');
print(gcf,fullfile(filenamepng), '-depsc');
clc; clear; close all;
%
% % reliability control
% 2000,330000
% 2001,357000
% 2002,388000
% 2003,431000
% 2004,484000
% 2005,541000
% 2006,586000
% 2007,622000
% 2008,692000
% 2009,736000
% 2010,800000
% 2011,864000
% 2012,875000
% 2013,924000
% 2014,884000
% 2015,863000
% 2016,805000
% 2017,789000
% 2018,764000
% 2019,613000
% 2020,511000
% 2021,311000
% 2022,188000
%
%
% %reliabilitz "reliability control wind turbe farm"
%
% 2000,6830
% 2001,6920
% 2002,7390
% 2003,8210
% 2004,8870
% 2005,9350
% 2006,10300
% 2007,11400
% 2008,12800
% 2009,14800
% 2010,16200
% 2011,16800
% 2012,17100
% 2013,16800
% 2014,17700
% 2015,17800
% 2016,17900
% 2017,18000
% 2018,18000
% 2019,18600
% 2020,16900
% 2021,19000
% 2022,19600
%
%
% % "life-extendg control wind turbe farm"
%
% 2000,6
% 2001,12
% 2002,20
% 2003,21
% 2004,9
% 2005,8
% 2006,222
% 2007,13
% 2008,21
% 2009,27
% 2010,26
% 2011,25
% 2012,26
% 2013,31
% 2014,36
% 2015,46
% 2016,20
% 2017,29
% 2018,26
% 2019,31
% 2020,37
% 2021,30
% 2022,26
%
%
% %damage-mitigatg control wind turbe farm%
% 2010,3
% 2011,3
% 2012,6
% 2013,7
% 2014,6
% 2015,6
% 2016,4
% 2017,3
% 2018,2
% 2019,1
% 2020,2
% 2021,3
% 2022,3
% 3 results (0,08 sec)
%
%


%wind turbe mpc 2000: 2022
wt.MPC = [2000,19
    2001,36
    2002,20
    2003,35
    2004,39
    2005,39
    2006,57
    2007,80
    2008,94
    2009,139
    2010,206
    2011,274
    2012,398
    2013,508
    2014,636
    2015,710
    2016,912
    2017,1130
    2018,1360
    2019,1620
    2020,1860
    2021,2260
    2022,2580];

%wind turbe lidar
wt.Lidar =[ 2000,27
    2001,28
    2002,38
    2003,38
    2004,61
    2005,65
    2006,72
    2007,152
    2008,177
    2009,225
    2010,311
    2011,410
    2012,534
    2013,609
    2014,728
    2015,769
    2016,928
    2017,1050
    2018,1210
    2019,1330
    2020,1540
    2021,1670
    2022,1950];

% wind turbe lpv
wt.LPV  = [2000,13
    2001,1
    2002,8
    2003,12
    2004,21
    2005,22
    2006,34
    2007,34
    2008,41
    2009,71
    2010,77
    2011,110
    2012,152
    2013,197
    2014,199
    2015,245
    2016,233
    2017,274
    2018,269
    2019,276
    2020,315
    2021,327
    2022,366];

% wind farm lidar
wf.Lidar =[ 2000,44
    2001,64
    2002,66
    2003,81
    2004,110
    2005,118
    2006,164
    2007,224
    2008,268
    2009,335
    2010,462
    2011,584
    2012,683
    2013,767
    2014,928
    2015,1020
    2016,1190
    2017,1320
    2018,1480
    2019,1690
    2020,1830
    2021,2140
    2022,2270];

% wind farm mpc
wf.MPC = [2000,29
    2001,42
    2002,40
    2003,45
    2004,60
    2005,64
    2006,83
    2007,88
    2008,92
    2009,135
    2010,158
    2011,209
    2012,244
    2013,338
    2014,402
    2015,374
    2016,457
    2017,570
    2018,733
    2019,847
    2020,923
    2021,1150
    2022,1310];

% wind turbe IPC
wt.IPC = [2000,32
    2001,19
    2002,37
    2003,32
    2004,34
    2005,45
    2006,48
    2007,69
    2008,99
    2009,149
    2010,200
    2011,198
    2012,249
    2013,255
    2014,322
    2015,304
    2016,377
    2017,376
    2018,403
    2019,365
    2020,441
    2021,460
    2022,442];

wt.fieldtests = ...
    [2000, 2170
    2001, 2460
    2002, 2650
    2003, 3160
    2004, 3530
    2005, 4160
    2006, 4690
    2007, 5500
    2008, 6450
    2009, 8030
    2010, 10100
    2011, 12100
    2012, 14300
    2013, 15600
    2014, 16400
    2015, 16900
    2016, 17800
    2017, 18500
    2018, 19200
    2019, 20200
    2020, 20700
    2021, 21600
    2022, 22900];

wf.fieldtests = [2000,8800
    2001,8860
    2002,9400
    2003,10900
    2004,11800
    2005,12400
    2006,13200
    2007,14500
    2008,15600
    2009,17100
    2010,18300
    2011,19100
    2012,19700
    2013,20500
    2014,21000
    2015,20600
    2016,20300
    2017,21300
    2018,21100
    2019,22000
    2020,22200
    2021,22900
    2022,22400];


%%

figure;
bar(wf.MPC(:,1),[wf.MPC(:,2)';wf.Lidar(:,2)'; wf.fieldtests(:,2)'])
title('wind farm');legend('MPC','Lidar','Fieldtests','Location','NorthWest');

figure;
bar(wt.MPC(:,1),[wt.MPC(:,2)';wt.Lidar(:,2)'; wt.fieldtests(:,2)'])
title('wind turbe');legend('MPC','Lidar','Fieldtests','Location','NorthWest');

figure;
bar(wf.MPC(:,1),[wt.MPC(:,2)';wt.Lidar(:,2)'; wf.MPC(:,2)';wf.Lidar(:,2)'])
title('wind turbe and farm');legend('WT MPC','WT Lidar','WF MPC','WF Lidar','Location','NorthWest');


muSynthesis = [2000,33000
    2001,32600
    2002,34800
    2003,35300
    2004,35600
    2005,38500
    2006,38600
    2007,40100
    2008,42500
    2009,46300
    2010,50800
    2011,56600
    2012,67900
    2013,75800
    2014,80700
    2015,89400
    2016,96300
    2017,103000
    2018,110000
    2019,115000
    2020,112000
    2021,93800
    2022,70500];

figure; bar(muSynthesis(:,1),muSynthesis(:,2));
title('muSynthesis');


%%
strWRC = " ""wind farm control"", (""wake redirection control"" OR WRC)";
strAICCtrl = """wind farm"" AND  ""axial induction control"" AND ( thrust OR generator OR pitch)";
strAIC = """wind farm control"", (""axial induction control"" OR AIC)";
strWRCCtrl = """wind farm"" AND ""wake redirection control"" AND yaw";
strWRCft = " ""wind farm"" AND ""wake redirection control"" AND ""field test""";
strKoopman = " ""wind farm control"", Koopman";

wf.AIC = [2010,0
    2011,0
    2012,0
    2013,0
    2014,3
    2015,0
    2016,5
    2017,10
    2018,18
    2019,25
    2020,27
    2021,28
    2022,49];

wf.WRC = [2010,0
    2011,0
    2012,0
    2013,0
    2014,1
    2015,5
    2016,5
    2017,14
    2018,20
    2019,21
    2020,21
    2021,16
    2022,31];

% "wind farm control" "wake redirection control"
% ***
wf.WRC1 = [2010,0
2011,0
2012,0
2013,0
2014,0
2015,1
2016,3
2017,11
2018,16
2019,20
2020,18
2021,13
2022,29
2023,18];

% ***
% "wind farm control" AND ("wake redirection control" OR WRC)
% ***
% 2010,0
% 2011,0
% 2012,0
% 2013,1
% 2014,1
% 2015,1
% 2016,4
% 2017,11
% 2018,16
% 2019,21
% 2020,19
% 2021,13
% 2022,29
% 2023,18

% %"wind farm control" AND ("wake redirection control" OR WRC)
% ***
% 2010,0
% 2011,0
% 2012,0
% 2013,1
% 2014,1
% 2015,1
% 2016,4
% 2017,11
% 2018,16
% 2019,21
% 2020,19
% 2021,13
% 2022,29
% 2023,18

% ***
% "wind farm" AND ("axial induction control" OR AIC)
% ***
% [2010,46
% 2011,67
% 2012,97
% 2013,144
% 2014,131
% 2015,128
% 2016,199
% 2017,199
% 2018,230
% 2019,237
% 2020,295
% 2021,344
% 2022,317
% 2023,353];

% ***
% "wind farm" "axial induction control" 
% ***
mpc.AIC2 = [2010,0
2011,0
2012,0
2013,0
2014,3
2015,0
2016,6
2017,13
2018,20
2019,25
2020,32
2021,30
2022,42
2023,41];

%"wind farm control" AND ("axial induction control" OR AIC)

wf.AIC1 = [...
2010,0
2011,0
2012,0
2013,0
2014,4
2015,4
2016,8
2017,15
2018,23
2019,23
2020,30
2021,30
2022,43
2023,37]
%About 37 results (0,07 sec)



wf.AICctrl = [2010 , 0
    2011 , 0
    2012 , 0
    2013 , 0
    2014 , 2
    2015 , 0
    2016 , 4
    2017 , 10
    2018 , 18
    2019 , 25
    2020 , 25
    2021 , 24
    2022 , 45];

wf.WRCctrl = [2010 , 0
    2011 , 0
    2012 , 0
    2013 , 0
    2014 , 1
    2015 , 4
    2016 , 5
    2017 , 14
    2018 , 19
    2019 , 21
    2020 , 17
    2021 , 16
    2022 , 28];

wf.WRCft = [2010, 0
    2011, 0
    2012, 0
    2013, 0
    2014, 0
    2015, 0
    2016, 0
    2017, 3
    2018, 9
    2019, 9
    2020, 8
    2021, 4
    2022, 11];

%C:\Users\ditt_aj\Anaconda3\python.exe C:/Users/ditt_aj/Desktop/Wordle.py
wf.Koopman = [...
   2010, 0
2011, 0
2012, 1
2013, 0
2014, 0
2015, 0
2016, 5
2017, 4
2018, 4
2019, 0
2020, 7
2021, 7
2022, 15
2023, 10];


%***
strAICft = """wind farm"" AND ""axial induction control"" AND ""field test"""; % "wind farm" AND "axial induction control" AND "field test"
%***
wf.AICft = [2010, 0
    2011, 0
    2012, 0
    2013, 0
    2014, 0
    2015, 0
    2016, 0
    2017, 2
    2018, 4
    2019, 9
    2020, 10
    2021, 14
    2022, 26];

%%
% * there is extensive literature starting in 2014
% * Field tests have been conducted for both
% * Farms corner:
close all;
showAllFig = 0;

n=1;
if showAllFig == 1
    fig = figure(n); n = n+1;
    fig.Name = 'Key words: AIC and ctrl';
    bar(wf.AICctrl(:,1),[wf.AIC(:,2),wf.AICctrl(:,2)])
    title({strAIC,strAICCtrl});

    fig = figure(2);
    fig.Name = 'Key words: WRC and ctrl';
    bar(wf.AICctrl(:,1),[wf.WRC(:,2),wf.WRCctrl(:,2)])
    title({strWRC,strWRCCtrl});

    fig = figure(n); n = n+1;
    fig.Name = 'Comparison: AIC and WRC ctrl';
    bar(wf.AICctrl(:,1),[wf.AICctrl(:,2),wf.WRCctrl(:,2)])
    ht = title({strAICCtrl,strWRCCtrl});
    set(gca,'YLim',[0 46])
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1:2), pos(3)*1.15,pos(4)]);
    set(gca,'Fontsize',12)
    ht.FontSize = 12;
    legend('AIC','WRC','Location','NorthWest')
    grid on;
    filenamepng = sprintf('googleWordleAICWRCFTLatex1');
    print(gcf,fullfile(filenamepng), '-dpng');
    print(gcf,fullfile(filenamepng), '-depsc');

    fig = figure(n); n = n+1;
    fig.Name = 'Comparison: AIC and WRC';
    bar(wf.AICctrl(:,1),[wf.AIC(:,2),wf.WRC(:,2)])
    title({strAIC,strWRC});

    fig = figure(n); n = n+1;
    fig.Name = 'Comparison Subplots: AIC and WRC w fieldtests';

    pos = get(fig,'Position');
    set(fig,'Position',[pos(1), pos(2) - 0.5*pos(4), pos(3),pos(4)*1.5]);
    fs = 15;
    subplot(2,1,1)
    idxV = 5:length(wf.AICctrl);
    bar(wf.AICctrl(idxV ,1),[wf.AIC(idxV ,2),wf.WRC(idxV,2)])
    legend('AIC','WRC','Location','NorthWest','Fontsize',fs,'interpreter','Latex');
    set(gca,'TickLabelInterpreter','Latex','FontSize',fs)
    ylabel('Google Scholar results','interpreter','Latex','FontSize',fs); grid on;

    subplot(2,1,2)
    bar(wf.AICctrl(idxV ,1),[wf.AICft(idxV ,2),wf.WRCft(idxV,2)])
    legend('AIC field tests','WRC field tests','Location','NorthWest','Fontsize',fs,'interpreter','Latex');
    set(gca,'TickLabelInterpreter','Latex','FontSize',fs)
    ylabel('Google Scholar results','interpreter','Latex','FontSize',fs); grid on;

    filenamepng = sprintf('googleWordleAICWRCFTLatex');
    print(gcf,fullfile(filenamepng), '-dpng');


    fig = figure(n); n = n+1;
    fs = 15;
    fig.Name = 'Comparison Stacked: AIC and WRC w fieldtests';
    b = bar(wf.AICctrl(:,1),[wf.AIC(:,2),wf.WRC(:,2), wf.AICft(:,2),wf.WRCft(:,2)],'stacked');
    legend('AIC','WRC','AIC field tests','WRC field tests', 'Location','best','Fontsize',fs,'interpreter','Latex');
    set(gca,'TickLabelinterpreter','Latex','FontSize',fs);
    ylabel('Google Scholar results')
    grid on;

    filenamepng = 'googleWordleAICWRCLatex';
    print(gcf,fullfile(filenamepng), '-dpng');

    fig = figure(n); n = n+1;
    fs = 15;
    fig.Name = 'Comparison Stacked: AIC and WRC w fieldtests';
    b = bar(wf.AICctrl(:,1),[wf.AIC(:,2),wf.WRC(:,2), wf.AICft(:,2),wf.WRCft(:,2)],'stacked');
    legend('AIC','WRC','AIC field tests','WRC field tests', 'Location','best','Fontsize',fs,'interpreter','Latex');
    set(gca,'TickLabelinterpreter','Latex','FontSize',fs);
    ylabel('Google Scholar results')
    grid on;

    filenamepng = 'googleWordleAICWRCLatex';
    print(gcf,fullfile(filenamepng), '-dpng');
end

%% figures dissertaion
y0 = max(wf.AIC1(1,1),1990)-1;
ye = 2022;
delta = 1;
idxYearAIC = wf.AIC1(:,1)>= y0 & wf.AIC1(:,1) <= ye;
idxYearKoop = wf.Koopman(:,1)>= y0 & wf.Koopman(:,1) <= ye;

%idxYear = ones(length(wf.AIC(:,1)),1) == 1;
cl = lines;

fig = figure(n); n = n + 1;
fs = 19;
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1:2), pos(3)*1.7,pos(4)]);

titleStr = {['{\color[rgb]{',num2str(cl(1,:)),'}',char(strAIC)],...
    ['\color[rgb]{',num2str(cl(2,:)),'}',char(strWRC),'}']};
xlabelStr = 'Year';
ylabelStr = 'No. of Google Scholar Entries';

fig.Name = 'Key words: AIC, WRC'; 
bar(wf.AIC1(idxYearAIC,1),[wf.AIC1(idxYearAIC,2),wf.WRC1(idxYearAIC,2)])
title(titleStr);
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;

%legend('Load reduction', 'IPC','location', 'NorthWest')
title(titleStr);
set(gca,'XTick',y0:delta:ye,'XTicklabel',y0:delta:ye,'Fontsize',fs)
set(gca,'XTickLabelRotation',45)

set(findall(gcf,'-property','FontSize'),'FontSize',fs)
title(titleStr,'FontSize',fs+2);

filenamepng = sprintf('googleWordleWFAICWRC');
print(gcf,fullfile(filenamepng), '-dpng');
print(gcf,fullfile(filenamepng), '-depsc');

titleStr = ['{\color[rgb]{',num2str(cl(1,:)),'}',char(strKoopman),'}'];

fig = figure(2);
fig.Name = 'Key words: Koopman'; 
bar(wf.Koopman(idxYearKoop,1),wf.Koopman(idxYearKoop,2))
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
title(titleStr);
set(gca,'XTick',y0:delta:ye,'XTicklabel',y0:delta:ye,'Fontsize',fs)
set(gca,'XTickLabelRotation',45)
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1:2), pos(3)*1.7,pos(4)]);

set(findall(gcf,'-property','FontSize'),'FontSize',fs)
title(titleStr,'FontSize',fs+2);

filenamepng = sprintf('googleWordleWFKoopman');
print(gcf,fullfile(filenamepng), '-dpng');
print(gcf,fullfile(filenamepng), '-depsc');

% titleStr = [testCaseStr,': Mdl1: Rot+Twr {\color[rgb]{',num2str(cl(1,:)),'}Mdl2: Rot,Twr,Bld+Act ',...
%     '\color[rgb]{',num2str(cl(2,:)),'}FAST} '];

% cl1 = lines;
% % cl = [0.5,0.5,0.5;
% %     cl1(4,:);
% %     [0.8,0,0];
% %     cl1(1,:);
% %     cl1(5,:)];
%
% cl = [1,0,0;
%     0,0,1;
%     [0.7,0,0];
%     0,0,0.7];
%
% %cl =[0,0,0.9; 0,0.9,0; 0.9,0,0];
%
%
% for k = 1:4
%     b(k).FaceColor = cl(k,:);
% end
%
%
%
% figure;
% bar(wf.AICctrl(:,1),[wf.AICctrl(:,2),wf.WRCctrl(:,2)])
% legend('AIC','WRC','Location','best','Fontsize',14)

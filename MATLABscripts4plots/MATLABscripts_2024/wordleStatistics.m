% close all
% 
% % reliability control
% In 2000 there are 330000
% In 2001 there are 357000
% In 2002 there are 388000
% In 2003 there are 431000
% In 2004 there are 484000
% In 2005 there are 541000
% In 2006 there are 586000
% In 2007 there are 622000
% In 2008 there are 692000
% In 2009 there are 736000
% In 2010 there are 800000
% In 2011 there are 864000
% In 2012 there are 875000
% In 2013 there are 924000
% In 2014 there are 884000
% In 2015 there are 863000
% In 2016 there are 805000
% In 2017 there are 789000
% In 2018 there are 764000
% In 2019 there are 613000
% In 2020 there are 511000
% In 2021 there are 311000
% In 2022 there are 188000
% 
% 
% %reliabilitz "reliability control wind turbine farm"
% 
% In 2000 there are 6830
% In 2001 there are 6920
% In 2002 there are 7390
% In 2003 there are 8210
% In 2004 there are 8870
% In 2005 there are 9350
% In 2006 there are 10300
% In 2007 there are 11400
% In 2008 there are 12800
% In 2009 there are 14800
% In 2010 there are 16200
% In 2011 there are 16800
% In 2012 there are 17100
% In 2013 there are 16800
% In 2014 there are 17700
% In 2015 there are 17800
% In 2016 there are 17900
% In 2017 there are 18000
% In 2018 there are 18000
% In 2019 there are 18600
% In 2020 there are 16900
% In 2021 there are 19000
% In 2022 there are 19600
% 
% 
% % "life-extending control wind turbine farm"
% 
% In 2000 there are 6
% In 2001 there are 12
% In 2002 there are 20
% In 2003 there are 21
% In 2004 there are 9
% In 2005 there are 8
% In 2006 there are 222
% In 2007 there are 13
% In 2008 there are 21
% In 2009 there are 27
% In 2010 there are 26
% In 2011 there are 25
% In 2012 there are 26
% In 2013 there are 31
% In 2014 there are 36
% In 2015 there are 46
% In 2016 there are 20
% In 2017 there are 29
% In 2018 there are 26
% In 2019 there are 31
% In 2020 there are 37
% In 2021 there are 30
% In 2022 there are 26
% 
% 
% %damage-mitigating control wind turbine farm%
% In 2010 there are 3
% In 2011 there are 3
% In 2012 there are 6
% In 2013 there are 7
% In 2014 there are 6
% In 2015 there are 6
% In 2016 there are 4
% In 2017 there are 3
% In 2018 there are 2
% In 2019 there are 1
% In 2020 there are 2
% In 2021 there are 3
% In 2022 there are 3
% 3 results (0,08 sec)


%wind turbine mpc 2000: 2022
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

%wind turbine lidar
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

% wind turbine lpv
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

% wind turbine IPC
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

figure;
bar(wf.MPC(:,1),[wf.MPC(:,2)';wf.Lidar(:,2)'; wf.fieldtests(:,2)'])
title('Wind farm');legend('MPC','Lidar','Fieldtests','Location','NorthWest');

figure;
bar(wt.MPC(:,1),[wt.MPC(:,2)';wt.Lidar(:,2)'; wt.fieldtests(:,2)'])
title('Wind turbine');legend('MPC','Lidar','Fieldtests','Location','NorthWest');

figure;
bar(wf.MPC(:,1),[wt.MPC(:,2)';wt.Lidar(:,2)'; wf.MPC(:,2)';wf.Lidar(:,2)'])
title('Wind turbine and farm');legend('WT MPC','WT Lidar','WF MPC','WF Lidar','Location','NorthWest');


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



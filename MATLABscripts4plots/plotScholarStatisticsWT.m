% This is the script that creates MATLAB plots for wind turbine research
% Google Scholar entries based on the txt files in the output folder.

clc; clear; close all;

%% --- Read data from text files ---
mdir = fileparts(pwd);
fileLoadReduction = fullfile(mdir, 'output','GglSch_1995_2026_Wind_Turbine_Control_Load_Reduction.txt');
fileIPC           = fullfile(mdir, 'output','GglSch_1995_2026_Wind_Turbine_Control_Individual_Pitch_Control_Ipc.txt');
fileMPC           = fullfile(mdir, 'output', 'GglSch_1995_2026_Wind_Turbine_Control_Model_Predictive_Control_Mpc.txt');

wt.LoadReduction = parseGglSchFile(fileLoadReduction);
wt.IPC           = parseGglSchFile(fileIPC);
wt.MPC           = parseGglSchFile(fileMPC);

%% --- Label strings ---
strLoadReduction = '"wind turbine control","load reduction"';
strIPC           = '"wind turbine control", ("individual pitch control" OR IPC)';
strMPC           = '"wind turbine control", ("model predictive control" OR MPC)';

%% --- Plot settings ---
y0    = 1995;
ye    = 2024;
delta = 1;
fs    = 19;
cl    = lines;

if delta == 1, multF = 2.4; else, multF = 1.7; end

idxYear = wt.LoadReduction(:,1) >= y0 & wt.LoadReduction(:,1) <= ye;

xlabelStr = 'Year';
ylabelStr = 'No. of Google Scholar Entries';

%% --- Figure 1: Load Reduction + IPC ---
fig = figure(1);
fig.Name = 'Key words: WT ctrl, Load reduction';
pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*multF, pos(4)]);

titleStr = {['{\color[rgb]{',num2str(cl(1,:)),'}',strLoadReduction], ...
            ['\color[rgb]{',num2str(cl(2,:)),'}',strIPC,'}']};

bar(wt.LoadReduction(idxYear,1), [wt.LoadReduction(idxYear,2), wt.IPC(idxYear,2)]);
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
set(gca,'XTick',y0:delta:ye,'XTickLabel',y0:delta:ye,'FontSize',fs);
set(gca,'XTickLabelRotation',45);
set(findall(gcf,'-property','FontSize'),'FontSize',fs);
title(titleStr,'FontSize',fs);

print(gcf,'googleWordleWTLoadRedIPC','-dpng');
print(gcf,'googleWordleWTLoadRedIPC','-depsc');

%% --- Figure 2: MPC only ---
fig = figure(2);
fig.Name = 'Key words: MPC';
pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*multF, pos(4)]);

titleStr = ['{\color[rgb]{',num2str(cl(1,:)),'}',strMPC,'}'];

bar(wt.MPC(idxYear,1), wt.MPC(idxYear,2));
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
set(gca,'XTick',y0:delta:ye,'XTickLabel',y0:delta:ye,'FontSize',fs);
set(gca,'XTickLabelRotation',45);
set(findall(gcf,'-property','FontSize'),'FontSize',fs);
title(titleStr,'FontSize',fs);

print(gcf,'googleWordleWTMPC','-dpng'); 
print(gcf,'googleWordleWTMPC','-depsc');

%% --- Figure 3: Load Reduction + IPC + MPC ---
fig = figure(3);
fig.Name = 'Key words: IPC and MPC';
pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*multF, pos(4)]);

tmp = lines;
clk = [zeros(1,3); tmp(1:2,:)];

titleStr = {strLoadReduction, ...
            ['{\color[rgb]{',num2str(cl(1,:)),'}',strIPC], ...
            ['\color[rgb]{',num2str(cl(2,:)),'}',strMPC,'}']};

b = bar(wt.LoadReduction(idxYear,1), ...
        [wt.LoadReduction(idxYear,2), wt.IPC(idxYear,2), wt.MPC(idxYear,2)]);
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
for k = 1:3
    b(k).FaceColor = clk(k,:);
end
set(findall(gcf,'-property','FontSize'),'FontSize',fs);
set(gca,'XTick',y0:delta:ye,'XTickLabel',y0:delta:ye,'FontSize',fs);
set(gca,'XTickLabelRotation',45);
title(titleStr,'FontSize',fs);

print(gcf,'agoogleWordleWTMPCIPC','-dpng');
print(gcf,'agoogleWordleWTMPCIPC','-depsc');


%% --- Helper function ---
function data = parseGglSchFile(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    lines = {};
    while ~feof(fid)
        lines{end+1} = fgetl(fid); %#ok<AGROW>
    end
    fclose(fid);

    years  = [];
    counts = [];
    for i = 1:numel(lines)
        % Match "In YYYY, there are N results."
        tok = regexp(lines{i}, 'In (\d{4}), there are (\d+) results\.', 'tokens');
        if ~isempty(tok)
            years(end+1)  = str2double(tok{1}{1}); %#ok<AGROW>
            counts(end+1) = str2double(tok{1}{2}); %#ok<AGROW>
        else
            % Lines with "text was:" are treated as 0 results
            tok0 = regexp(lines{i}, 'In (\d{4}), there are 0 results', 'tokens');
            if ~isempty(tok0)
                years(end+1)  = str2double(tok0{1}{1}); %#ok<AGROW>
                counts(end+1) = 0; %#ok<AGROW>
            end
        end
    end
    data = [years(:), counts(:)];
end
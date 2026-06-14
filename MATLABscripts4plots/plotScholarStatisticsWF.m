% This is the script that creates MATLAB plots for wind farm research
% Google Scholar entries based on the txt files in the output folder

clc; clear; close all;

%% --- Read data from text files ---
mdir = fileparts(pwd);
fileAIC     = fullfile(mdir, 'output','GglSch_2010_2026_Wind_Farm_Axial_Induction_Control.txt');
fileWRC     = fullfile(mdir, 'output','GglSch_2010_2026_Wind_Farm_Control_Wake_Redirection_Control_Wrc.txt');
fileKoopman = fullfile(mdir, 'output','GglSch_2010_2026_Wind_Farm_Control_Koopman.txt');

wf.AIC1    = parseGglSchFile(fileAIC);
wf.WRC1    = parseGglSchFile(fileWRC);
wf.Koopman = parseGglSchFile(fileKoopman);

%% --- Label strings ---
strAIC     = '"wind farm control", ("axial induction control" OR AIC)';
strWRC     = '"wind farm control", ("wake redirection control" OR WRC)';
strKoopman = '"wind farm control", Koopman';

%% --- Plot settings ---
y0    = 2010;
ye    = 2024;
delta = 1;
fs    = 19;
cl    = lines;

if delta == 1, multF = 2.4; else, multF = 1.7; end

idxYearAIC  = wf.AIC1(:,1)    >= y0 & wf.AIC1(:,1)    <= ye;
idxYearKoop = wf.Koopman(:,1) >= y0 & wf.Koopman(:,1) <= ye;

xlabelStr = 'Year';
ylabelStr = 'No. of Google Scholar Entries';

%% --- Figure 1: AIC + WRC ---
fig = figure(1);
fig.Name = 'Key words: AIC, WRC';
pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*multF, pos(4)]);

titleStr = {['{\color[rgb]{',num2str(cl(1,:)),'}',strAIC], ...
            ['\color[rgb]{',num2str(cl(2,:)),'}',strWRC,'}']};

bar(wf.AIC1(idxYearAIC,1), [wf.AIC1(idxYearAIC,2), wf.WRC1(idxYearAIC,2)]);
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
set(gca,'XTick',y0:delta:ye,'XTickLabel',y0:delta:ye,'FontSize',fs);
set(gca,'XTickLabelRotation',45);
set(findall(gcf,'-property','FontSize'),'FontSize',fs);
title(titleStr,'FontSize',fs);

print(gcf,'googleWordleWFAICWRC','-dpng');
print(gcf,'googleWordleWFAICWRC','-depsc');

%% --- Figure 2: Koopman ---
fig = figure(2);
fig.Name = 'Key words: Koopman';
pos = get(0,'DefaultFigurePosition');
set(gcf,'Position',[pos(1:2), pos(3)*multF, pos(4)]);

titleStr = ['{\color[rgb]{',num2str(cl(1,:)),'}',strKoopman,'}'];

bar(wf.Koopman(idxYearKoop,1), wf.Koopman(idxYearKoop,2));
xlabel(xlabelStr); ylabel(ylabelStr);
grid on;
set(gca,'XTick',y0:delta:ye,'XTickLabel',y0:delta:ye,'FontSize',fs);
set(gca,'XTickLabelRotation',45);
set(findall(gcf,'-property','FontSize'),'FontSize',fs);
title(titleStr,'FontSize',fs);

print(gcf,'googleWordleWFKoopman','-dpng');
print(gcf,'googleWordleWFKoopman','-depsc');


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
        tok = regexp(lines{i}, 'In (\d{4}), there are (\d+) results\.', 'tokens');
        if ~isempty(tok)
            years(end+1)  = str2double(tok{1}{1}); %#ok<AGROW>
            counts(end+1) = str2double(tok{1}{2}); %#ok<AGROW>
        else
            tok0 = regexp(lines{i}, 'In (\d{4}), there are 0 results', 'tokens');
            if ~isempty(tok0)
                years(end+1)  = str2double(tok0{1}{1}); %#ok<AGROW>
                counts(end+1) = 0; %#ok<AGROW>
            end
        end
    end
    data = [years(:), counts(:)];
end
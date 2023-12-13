%  Script for generating figures for EELE565 - Parallel Processing final
%  project, a parallel implementation of K-Means clustering. The actual
%  parallel processing was done in Julia, but I have done the figures and
%  preprocessing in Matlab as I'm more familiar with it and couldn't spend
%  as much time learning plotting and data manipulation in Julia. In an
%  effort to save time, I have also hardcoded the values for the plots, but
%  if you wanted to make it more adaptive it would involve modifying
%  pkmBenchmark.jl to save the times to a vector for each thread count.

%% Image Data

%% Runtime Data
% Data = [2Threads 4Threads 8Threads... ] (Hardcoded values :( )

smallKTimes =   [34 45 47 45 32 31 29 27 54];
smallKDev =     [20 22 18 16 13 12 12 11 7];
smallDTimes =   [17 18 18 19 18 18 18 18 18];
smallDDev =     [10 .488 .529 .812 .404 .457 .627 .567 .613];

mediumKTimes =  [227 327 327 294 225 216 211 220 296];
mediumKDev =    [110 141 135 124 112 125 148 135 193];
mediumDTimes =  [41 48 47 51 48 47 47 48 50];
mediumDDev =    [1 .972 .937 1 .923 .837 1 1 1];

largeKTimes =   [1801 1974 2740 2603 2053 2013 1931 1914 2035];
largeKDev =     [866 973 1112 1039 863 1013 1088 1001 1035];
largeDTimes =   [85 93 92 100 96 92 95 92 96];
largeDDev =     [.741 1 3 1 .757 .860 1 .362 1];

fullKTimes =    [3763 4533 5506 4801 4377 3693 4004 3885 4937];
fullKDev =      [1829 2310 2060 2310 2117 1994 2180 1935 2675];
fullDTimes =    [136 151 149 151 152 153 151 152 151];
fullDDev =      [1 .858 1 .682 .830 .994 .318 .894 3];

%% Plot General Configurations
FIGURE_LINE_WIDTH = 2;
FIGURE_WIDTH_FULL_PAGE = 24;
THREAD_COUNT = [0 1 2 4 8 16 32 64 128];

%% Figure 1: Image Classification Results
% 4x4 Plots with rows = increasing size datasets and columns = thread count
% Row 1: Serial
% Row 2: 4 Threads
% Row 3: 16 Threads
% Row 4: 64 Threads

f1 = figure(1); clf;
f1.Units = "centimeters";
f1.Position = [1 1 FIGURE_WIDTH_FULL_PAGE 11];
t1 = tiledlayout(f1,2,4);

% Loading Original Pixel Locations (relative to the shuffled data)
load("../data/salinasPixels.mat");
load("../data/salinasPixelsLarge.mat");
load("../data/salinasPixelsMedium.mat");
load("../data/salinasPixelsSmall.mat");

% Serial Results (Load | Reconstruct | Display)
load("../results/serial/serialKResults.mat");
load("../results/serial/serialKResultsLarge.mat");
load("../results/serial/serialKResultsMedium.mat");
load("../results/serial/serialKResultsSmall.mat");

serialFull = reconstructImage(serialResults,"Full",salinasPixels_s);
serialLarge = reconstructImage(serialResultsLarge,"Large",salinasPixelsLarge_s);
serialMedium = reconstructImage(serialResultsMedium,"Medium",salinasPixelsMedium_s);
serialSmall = reconstructImage(serialResultsSmall,"Small",salinasPixelsSmall_s);

p11 = nexttile; imagesc(serialSmall); title("Serial Small");
p12 = nexttile; imagesc(serialMedium); title("Serial Medium");
p13 = nexttile; imagesc(serialLarge); title("Serial Large");
p14 = nexttile; imagesc(serialFull); title("Serial Full");

% % 4 Thread Results
% load("../results/t4/parallelKResultsFull_t4.mat");
% load("../results/t4/parallelKResultsLarge_t4.mat");
% load("../results/t4/parallelKResultsMedium_t4.mat");
% load("../results/t4/parallelKResultsSmall_t4.mat");
% 
% t4Full = reconstructImage(parallelResultsFull_t4,"Full",salinasPixels_s);
% t4Large = reconstructImage(parallelResultsLarge_t4,"Large",salinasPixelsLarge_s);
% t4Medium = reconstructImage(parallelResultsMedium_t4,"Medium",salinasPixelsMedium_s);
% t4Small = reconstructImage(parallelResultsSmall_t4,"Small",salinasPixelsSmall_s);
% 
% p15 = nexttile; imagesc(t4Small); title("T4 Small");
% p16 = nexttile; imagesc(t4Medium); title("T4 Medium");
% p17 = nexttile; imagesc(t4Large); title("T4 Large");
% p18 = nexttile; imagesc(t4Full); title("T4 Full");
% 
% % 16 Thread Results
% load("../results/t16/parallelKResultsFull_t16.mat");
% load("../results/t16/parallelKResultsLarge_t16.mat");
% load("../results/t16/parallelKResultsMedium_t16.mat");
% load("../results/t16/parallelKResultsSmall_t16.mat");
% 
% t16Full = reconstructImage(parallelResultsFull_t16,"Full",salinasPixels_s);
% t16Large = reconstructImage(parallelResultsLarge_t16,"Large",salinasPixelsLarge_s);
% t16Medium = reconstructImage(parallelResultsMedium_t16,"Medium",salinasPixelsMedium_s);
% t16Small = reconstructImage(parallelResultsSmall_t16,"Small",salinasPixelsSmall_s);
% 
% p19 = nexttile; imagesc(t16Small); title("T16 Small");
% p110 = nexttile; imagesc(t16Medium); title("T16 Medium");
% p111 = nexttile; imagesc(t16Large); title("Serial Large");
% p112 = nexttile; imagesc(t16Full); title("Serial Full");

% 64 Thread Results
load("../results/t64/parallelKResultsFull_t64.mat");
load("../results/t64/parallelKResultsLarge_t64.mat");
load("../results/t64/parallelKResultsMedium_t64.mat");
load("../results/t64/parallelKResultsSmall_t64.mat");

t64Full = reconstructImage(parallelResultsFull_t64,"Full",salinasPixels_s);
t64Large = reconstructImage(parallelResultsLarge_t64,"Large",salinasPixelsLarge_s);
t64Medium = reconstructImage(parallelResultsMedium_t64,"Medium",salinasPixelsMedium_s);
t64Small = reconstructImage(parallelResultsSmall_t64,"Small",salinasPixelsSmall_s);

p113 = nexttile; imagesc(t64Small); title("64 Threads Small");
p114 = nexttile; imagesc(t64Medium); title("64 Threads Medium");
p115 = nexttile; imagesc(t64Large); title("64 Threads Large");
p116 = nexttile; imagesc(t64Full); title("64 Threads Full");

%% Figure 2: Runtime vs Threads for varying sized images

% Plot
f2 = figure(2); clf;
f2.Units = "centimeters";
f2.Position = [1 1 FIGURE_WIDTH_FULL_PAGE 11];
t2 = tiledlayout(f2,2,2);
t2.Padding = "compact";
t2.TileSpacing = "compact";
p21 = nexttile;
p21runTime = errorbar([1 2 3 4 5 6 7 8 9],smallKTimes,smallKDev);
    p21runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p21loadTime = errorbar([1 2 3 4 5 6 7 8 9],smallDTimes,smallDDev);
    p21loadTime.LineWidth = FIGURE_LINE_WIDTH;
yline(smallKTimes(1),'r--');

title("Small Dataset");
p21.XTickMode = "auto";
p21.XTickLabel = THREAD_COUNT;
p21.XLabel.String = "Thread Count";
p21.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead','Serial Runtime');
   
%% Medium Dataset

% f3 = figure(3); clf;
% t3 = tiledlayout(f3,1,1);
p31 = nexttile;
p31runTime = errorbar([1 2 3 4 5 6 7 8 9],mediumKTimes,mediumKDev);
    p31runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p31loadTime = errorbar([1 2 3 4 5 6 7 8 9],mediumDTimes,mediumDDev);
    p31loadTime.LineWidth = FIGURE_LINE_WIDTH;
yline(mediumKTimes(1),'r--');

title("Medium Dataset");
p31.XTickLabel = THREAD_COUNT;
p31.XLabel.String = "Thread Count";
p31.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead','Serial Runtime');

%% Large Dataset

% f4 = figure(4); clf;
% t4 = tiledlayout(f4,1,1);
p41 = nexttile;
p41runTime = errorbar([1 2 3 4 5 6 7 8 9],largeKTimes,largeKDev);
    p41runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p41loadTime = errorbar([1 2 3 4 5 6 7 8 9],largeDTimes,largeDDev);
    p41loadTime.LineWidth = FIGURE_LINE_WIDTH;
yline(largeKTimes(1),'r--');

title("Large Dataset");
p41.XTickLabel = THREAD_COUNT;
p41.XLabel.String = "Thread Count";
p41.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead','Serial Runtime');

%% Full Dataset

% f5 = figure(5); clf;
% t5 = tiledlayout(f5,1,1);
p51 = nexttile;
p51runTime = errorbar([1 2 3 4 5 6 7 8 9],fullKTimes,fullKDev);
    p51runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p51loadTime = errorbar([1 2 3 4 5 6 7 8 9],fullDTimes,fullDDev);
    p51loadTime.LineWidth = FIGURE_LINE_WIDTH;
yline(fullKTimes(1),'r--');

title("Full Dataset");
p51.XTickLabel = THREAD_COUNT;
p51.XLabel.String = "Thread Count";
p51.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead','Serial Runtime');

%% Figure 3
f3 = figure(3); clf;
f3.Units = "centimeters";
f3.Position = [1 1 FIGURE_WIDTH_FULL_PAGE 11];

load("../data/Salinas_gt.mat"); 

imagesc(salinas_gt); title("Salinas Ground Truth");


%% Saving Data
exportgraphics(f1,"assignmentsImage.pdf","ContentType","vector");
exportgraphics(f2,"runtimePlots.pdf","ContentType","vector");
exportgraphics(f3,"salinasGroundTruth.pdf","ContentType","vector");
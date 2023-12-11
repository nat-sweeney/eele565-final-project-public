%  Script for generating figures for EELE565 - Parallel Processing final
%  project, a parallel implementation of K-Means clustering. The actual
%  parallel processing was done in Julia, but I have done the figures and
%  preprocessing in Matlab as I'm more familiar with it and couldn't spend
%  as much time learning plotting and data manipulation in Julia. In an
%  effort to save time, I have also hardcoded the values for the plots, but
%  if you wanted to make it more adaptive it would involve modifying
%  pkmBenchmark.jl to save the times to a vector for each thread count.


% T = 2: 
%   kmeans: 88.048 +- 50.997 ; 635.542 +- 250.122 ; 2336 +- 1011 ; 4798 +-
%   2211
%   load: 18.747 +- .366 ; 48.469 +- .966 ; 96.319 +- 1.529 ; 154.055 +-
%   2.183

% T = 4
% k: 131.206/56.99 622.122/201.767 3622/1152 5733/2018
% d:18.891/.412 48.986/1.464 101.608/3.292 159.437/3.666

% T = 8
% k: 145.938/56.966 697.646/250.426 3594/1106 5802/2247
% d: 18.858/.434 52.181/2.321 97.391/4.302 157.851/6.041

% T = 16
% k: 145.671/29.766 500.476/166.041 3092/1033 5424/2219
% d: 18.354/.318 47.265/.696 91.435/.803 146.935/1.7

% T = 32
% k: 278.473/71.899 640.641/201.407 4030/1313 5624/2297
% d: 18.882/.448 48.248/1.252 94.549/1.295 156.625/3.297

% T = 64
% k: 94.424/51.057 674.278/156.270 3148/1076 4945/2142
% d: 19.187/.618 46.168/1.128 96.203/1.44 154.761/.526

%% Data
% Data = [2Threads 4Threads 8Threads... ]

smallKTimes = [86.793 88.048 131.206 145.938 145.671 278.473 94.424];
smallKDev = [60.228 50.997 56.99 56.966 29.766 71.899 51.057];
smallDTimes = [18.275 18.747 18.891 18.858 18.354 18.882 19.187];
smallDDev = [.432 .366 .412 .434 .318 .448 .618];

mediumKTimes = [403.655 635.542 622.122 697.646 500.476 640.641 674.278];
mediumKDev = [221.208 250.122 201.767 250.426 166.041 201.407 156.270];
mediumDTimes = [47.110 48.469 48.986 52.181 47.265 48.248 46.168];
mediumDDev = [.995 .966 1.464 2.321 .696 1.252 1.128];

largeKTimes = [2534 2366 3622 3594 3092 4030 3148];
largeKDev = [1154 1011 1152 1106 1033 1313 1076];
largeDTimes = [91.411 96.319 101.608 97.391 91.435 94.549 96.203];
largeDDev = [1.333 1.529 3.292 4.302 .803 1.295 1.44];

fullKTimes = [4839 4798 5733 5802 5424 5624 4945];
fullKDev = [2274 2211 2018 2247 2219 2297 2142];
fullDTimes = [147.094 154.055 159.437 157.851 146.935 156.625 154.761];
fullDDev = [5.279 2.183 3.666 6.041 1.7 3.297 .526];

%% Plot General Configurations
FIGURE_LINE_WIDTH = 2;
THREAD_COUNT = [1 2 4 8 16 32 64];

%% Figure 1: Image Classification Results
% 4x4 Plots with rows = increasing size datasets and columns = thread count

f1 = figure(1); clf;
t1 = tiledlayout(f1,4,4);

%% Figure 2: Small Dataset Time (y) vs Threads (x) w/ Overhead

% Plot
f2 = figure(2); clf;
t2 = tiledlayout(f2,2,2);
t2.Padding = "compact";
t2.TileSpacing = "compact";
p21 = nexttile;
p21runTime = errorbar([1 2 3 4 5 6 7],smallKTimes,smallKDev);
    p21runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p21loadTime = errorbar([1 2 3 4 5 6 7],smallDTimes,smallDDev);
    p21loadTime.LineWidth = FIGURE_LINE_WIDTH;

title("Small Dataset");
p21.XTickMode = "auto";
p21.XTickLabel = THREAD_COUNT;
p21.XLabel.String = "Thread Count";
p21.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead');
   
%% Figure 3: Medium Dataset Time (y) vs Threads (x)

% f3 = figure(3); clf;
% t3 = tiledlayout(f3,1,1);
p31 = nexttile;
p31runTime = errorbar([1 2 3 4 5 6 7],mediumKTimes,mediumKDev);
    p31runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p31loadTime = errorbar([1 2 3 4 5 6 7],mediumDTimes,mediumDDev);
    p31loadTime.LineWidth = FIGURE_LINE_WIDTH;

title("Medium Dataset");
p31.XTickLabel = THREAD_COUNT;
p31.XLabel.String = "Thread Count";
p31.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead');

%% Figure 4: Large Dataset Time (y) vs Threads (x)

% f4 = figure(4); clf;
% t4 = tiledlayout(f4,1,1);
p41 = nexttile;
p41runTime = errorbar([1 2 3 4 5 6 7],largeKTimes,largeKDev);
    p41runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p41loadTime = errorbar([1 2 3 4 5 6 7],largeDTimes,largeDDev);
    p41loadTime.LineWidth = FIGURE_LINE_WIDTH;

title("Large Dataset");
p41.XTickLabel = THREAD_COUNT;
p41.XLabel.String = "Thread Count";
p41.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead');

%% Figure 5: Full Dataset Time (y) vs Threads (x)

% f5 = figure(5); clf;
% t5 = tiledlayout(f5,1,1);
p51 = nexttile;
p51runTime = errorbar([1 2 3 4 5 6 7],fullKTimes,fullKDev);
    p51runTime.LineWidth = FIGURE_LINE_WIDTH;
hold on;
p51loadTime = errorbar([1 2 3 4 5 6 7],fullDTimes,fullDDev);
    p51loadTime.LineWidth = FIGURE_LINE_WIDTH;

title("Full Dataset");
p51.XTickLabel = THREAD_COUNT;
p51.XLabel.String = "Thread Count";
p51.YLabel.String = "Latency (ms)";
legend('K-Means','Data Overhead');

%% Figure 6: Contour Plot of Threads (x) vs Samples (y) vs Time (z)

f6y = [];
f6x = [];

f6 = figure(6); clf;
t6 = tiledlayout(f6,1,1);

clear all;
load Carrot4_data_piped;

%% plot all data
figure;
hold on;
Hz = 90;
for j = 1:length(ExperimentalTrials)
    if ExperimentalTrials(j).dump == 0 && ExperimentalTrials(j).t_total > 8.5 &&...
            ExperimentalTrials(j).dv ~= 0 && j ~= 1059
        manipOnset = ExperimentalTrials(j).manipOnset;
        tStart = int32((manipOnset-0.5)*Hz) + 1;
        tEnd = int32((manipOnset + 5)*Hz);
        x = ExperimentalTrials(j).data(tStart:tEnd,7)-manipOnset;
        y = ExperimentalTrials(j).data(tStart:tEnd,4);
%         if sum(y >= 1.9)>0
%             j
%         end
        plot(x,y);
        axis([-2 5 0 2]);
    end
end


%% plot filtered freewalk 
for j = 1:length(freewalk)
    hold on;
    plot(freewalk(j).data(:,4), freewalk(j).data(:,2));
end

%% plot input traj
figure;
hold on;
for j = 1:length(ExperimentalTrials)
    if ExperimentalTrials(j).subject >= 1 && ExperimentalTrials(j).dump == 0  && ExperimentalTrials(j).dv ~= 0
        x = ExperimentalTrials(j).data(:,7);
        y = ExperimentalTrials(j).data(:,3);
        plot(x,y);
        axis([0 12 0 2]);
    end
end


%% plot rotated and interpolated but unfiltered data

figure;
hold on;
for j = 1:length(ExperimentalTrials)  
    if ExperimentalTrials(j).dump == 0 && ExperimentalTrials(j).subject >= 1 
        speed = diff(ExperimentalTrials(j).inter_traj(:,4));
        speed = [speed; speed(end)];
        speed = speed * 90;
        plot(ExperimentalTrials(j).inter_traj(:,5), speed);
%         axis([0 12 -5 5]);
    end
end

%% plot filtered data by conditions in different graphs
figure;
for j = 1:length(ExperimentalTrials)
    subject = ExperimentalTrials(j).subject;
    x = ExperimentalTrials(j).data(:,7);
    y = ExperimentalTrials(j).data(:,4);
    dump = ExperimentalTrials(j).dump;
    d0 = ExperimentalTrials(j).d0;
    dv = ExperimentalTrials(j).dv;
    if dump == 0 && subject >= 1
        if dv > 0 && d0 == 1
            subplot(2,3,1);
            hold on;
            plot(x,y);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title('dv=0.3 d0=1');
            axis([0 12 0 2]);
        end
        if dv > 0 && d0 == 3
            subplot(2,3,2);
            hold on;
            plot(x,y);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title('dv=0.3 d0=3');
            axis([0 12 0 2]);
        end
        if dv > 0 && d0 == 6
            subplot(2,3,3);
            hold on;
            plot(x,y);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title('dv=0.3 d0=6');
            axis([0 12 0 2]);
        end
        if dv < 0 && d0 == 1
            subplot(2,3,4);
            hold on;
            plot(x,y);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title('dv=-0.3 d0=1');
            axis([0 12 0 2]);
        end
        if dv < 0 && d0 == 3
            subplot(2,3,5);
            hold on;
            plot(x,y);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title('dv=-0.3 d0=3');
            axis([0 12 0 2]);
        end
        if dv < 0 && d0 == 6
            subplot(2,3,6);
            hold on;
            plot(x,y);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title('dv=-0.3 d0=6');
            axis([0 12 0 2]);
        end
    end
end


%% plot for all subject in individual graph
figure;
for j = 1:12
    subplot(3,4,j);
    hold on;
    for j = 1:length(ExperimentalTrials) 
        if ExperimentalTrials(j).dump == 0 && ExperimentalTrials(j).dv ~= 0 && ExperimentalTrials(j).subject == j
            plot(ExperimentalTrials(j).data(:,7), ExperimentalTrials(j).data(:,4));
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title(['subject ' num2str(j)]);
            axis([0 12 0 2]);
        end
    end
end


%% histogram of trial length
t = [];
Hz = 90;
figure;
hold on;
for j = 1:length(ExperimentalTrials)
    if ExperimentalTrials(j).dump == 0 %ExperimentalTrials(i).d0 == 1 && ExperimentalTrials(i).dv == -0.3
        t(end+1) = length(ExperimentalTrials(j).data);
    end
end
t = t/Hz;
histogram(t,10);
axis([7 13 0 500]);

%% trial info check (trial length analysis)
count = 0;
for j = 1:length(ExperimentalTrials)
    subject = ExperimentalTrials(j).subject;
    trial = ExperimentalTrials(j).trial;
    d0 = ExperimentalTrials(j).d0;
    dv = ExperimentalTrials(j).dv;
    dump = ExperimentalTrials(j).dump;
    manipOnset = ExperimentalTrials(j).manipOnset;
    t = ExperimentalTrials(j).t_total;
    
    if dump == 0 && t-manipOnset>5.5 && dv~=0
        count = count + 1;
        [d0 dv]  
    end
end
count


%% plot orientation

% load data_orientation;
figure;
hold on;
for j = 1:length(orientation)
    % plot yaw
    y = orientation(j).orientation(:,1);
    x = 1:length(y);
    x = x';
    plot(x,y);
    title('yaw');
    ax = gca;
    ax.FontSize = 20;
end

figure;
hold on;
for j = 1:length(orientation)
    % plot yaw
    y = orientation(j).orientation(:,2);
    x = 1:length(y);
    x = x';
    plot(x,y);
    title('pitch');
    ax = gca;
    ax.FontSize = 20;  
end
figure;
hold on;
for j = 1:length(orientation)
    % plot yaw
    y = orientation(j).orientation(:,3);
    x = 1:length(y);
    x = x';
    plot(x,y);
    title('roll');
    ax = gca;
    ax.FontSize = 20;
end

%% Check frame rate
FR = [];
for j = 1:length(ExperimentalTrials)
    FR = [FR;(ExperimentalTrials(j).raw_traj(2:end,5) - ExperimentalTrials(j).raw_traj(1:end-1,5)).^(-1)];
end

histogram(FR);
xticks(0:5:100);
xlabel('Hz');
ylabel('Number of frames');
axis([20 100 0 200000]),...
ax = gca;
ax.FontSize = 20;

%% filter testing: All trials. subplot: order
figure;
Hz = 90;
order = [0 1 2 3 4 5];
cut = 0; % cut off this many seconds from the tail
pad = 1;
cutoff = 0.6;
for i = 1:length(order)
    subplot(2,3,i);
    hold on;
    for j = 1:length(ExperimentalTrials)
        if ExperimentalTrials(j).dump == 0 && ExperimentalTrials(j).dv ~= 0 ...
                && ExperimentalTrials(j).subject >= 1
            inter_traj = ExperimentalTrials(j).inter_traj;
            if order(i) == 0
                Pos = inter_traj(:,4);
            else
                [vOutput, outFiltered, outExtended] = Carrot4_filter_butter(Hz, inter_traj(:,4),cutoff, order(i), pad);
                Pos = outFiltered;
            end
            Spd = diff(Pos);
            Spd(end+1) = Spd(end);
            Spd = Spd*Hz;
            time = inter_traj(:,5);
            plot(Spd(1:end-cut*Hz));
%             plot(time(1:end-cut*Hz),Spd(1:end-cut*Hz));
%             axis([-4 16 0 2]);
        end
    end
    xlabel('Time(s)');
    ylabel('Speed(m/s)');
    title(['filter order = ' num2str(order(i))]);
    
end

%% filter testing: 1 trial. subplot: order.  line: pad.
Hz = 90;
figure;
order = [0 1 2 3 4 5];
cut = 0; % cut off this many seconds from the tail
cutoff = 0.6;
pad = [1 45 90 180];
padLabel = {'1' '45' '90' '180' 'leader'};
for i = randperm(length(ExperimentalTrials))
    if ExperimentalTrials(i).dump == 0  && ExperimentalTrials(i).dv ~= 0 && i >= 1
        inter_traj = ExperimentalTrials(i).inter_traj;
        d0 = ExperimentalTrials(i).d0;
        for j = 1:length(order)
            subplot(2,3,j);
            hold off;
            
            for k = 1:length(pad)
                if order(j) == 0
                    Pos = inter_traj(:,4);
                else
                    [vOutput, outFiltered, outExtended] = Carrot4_filter_butter(Hz,inter_traj(:,4),cutoff,order(j),pad(k));
                    Pos = vOutput;
                end
                Spd = diff(Pos);
                Spd(end+1) = Spd(end);
                Spd = Spd*Hz;
                time = inter_traj(:,5);
                
                plot(time(1:end-cut*Hz),Spd(1:end-cut*Hz));
    %             plot(Spd(1:end-cut*Hz));
                hold on;
            end
            
            plot(time(1:end-cut*Hz-1),diff(inter_traj(:,2))*Hz);
            legend(padLabel);
            axis([-2 14 0 2]);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title([num2str(i) ':     ' num2str(d0) 'm, filter order = ' num2str(order(j))]);
        end
    end
  
    pause(0.5);
  
end

%% filter testing: 1 trial. subplot: order.  line: cutoff.

Hz = 90;
figure;
order = [0 1 2 3 4 5];
cut = 0; % cut off this many seconds from the tail
cutoff = [0.9 0.6 0.3];
cutoffLabel = {'0.9' '0.6' '0.3' 'leader'};
pad = 1;
for i = randperm(length(ExperimentalTrials))
    if ExperimentalTrials(i).dump == 0  && ExperimentalTrials(j).dv ~= 0 && i >= 1
        inter_traj = ExperimentalTrials(i).inter_traj;
        d0 = ExperimentalTrials(i).d0;
        for j = 1:length(order)
            subplot(2,3,j);
            hold off;
            
            for k = 1:length(cutoff)
                
                if order(j) == 0
                    Pos = inter_traj(:,4);
                else
                    [vOutput, outFiltered, outExtended] = Carrot4_filter_butter(Hz,inter_traj(:,4),cutoff(k),order(j),pad);
                    Pos = vOutput;
                end
                Spd = diff(Pos);
                Spd(end+1) = Spd(end);
                Spd = Spd*Hz;
                time = inter_traj(:,5);
                
                plot(time(1:end-cut*Hz),Spd(1:end-cut*Hz));
    %             plot(Spd(1:end-cut*Hz));
                hold on;
            end
            
            plot(time(1:end-cut*Hz-1),diff(inter_traj(:,2))*Hz);
            legend(cutoffLabel);
            axis([-2 14 0 2]);
            xlabel('Time(s)');
            ylabel('Speed(m/s)');
            title([num2str(i) ':     ' num2str(d0) 'm, filter order = ' num2str(order(j))]);
        end
    end
  
    pause(0.5);
  
end
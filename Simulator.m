%% generate data
model = 'expansionModel';
p = [5.5672];

% model = 'expansion2Model';
% p = [0.9099];

% model = 'expansion3Model';
% p = [2.6328,0.4175];

delay = 0;
d0 = 2;
nDuration = 15;
v0 = 1.2;
dv = 0.3;
a = 1;
x0 = 0;
y0 = d0;
heading1 = 0;
heading2 = 0;
startupDuration = 1;
meanManipOnset = 8;
onsetWindow = 0.01;
Hz = 90;

[~, lPos, lSpd, hdn, manipOnset] = simTrajectoryGenerator(x0,y0,nDuration,v0,dv,a,...
    heading1,heading2,startupDuration,meanManipOnset,onsetWindow,Hz);

pStart = 0;
vStart = 1.2;
inputHz = Hz;
outputHz = Hz;
[mPos, mSpd, mAcc] = models(model, p, delay, lPos, lSpd, pStart, vStart, inputHz, outputHz);


%% plot leader
x = 1/Hz:1/Hz:nDuration; % time
subplot(2, 2, 1); % speed plot
hold on;
plot(x, lSpd, 'k');
title('Speed');
xlabel('Time');
ylabel('Speed');
axis([0 15 0 1.5]);

subplot(2, 2, 2); % distance plot
hold on;
title('Distance');
xlabel('Time');
ylabel('Distance');
% axis([0 15 0 2]);

subplot(2, 2, 3); % acceleration plot
hold on;
title('Acceleration');
xlabel('Time');
ylabel('Acceleration');
axis([0 15 0 1.5]);


%% plot model
subplot(2, 2, 1); % speed plot
hold on;
plot(x, mSpd);


subplot(2, 2, 2); % distance plot
hold on;
plot(x, lPos - mPos);


subplot(2, 2, 3); % acceleration plot
hold on;
plot(x, mAcc);


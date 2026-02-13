% harry hicks
% egyhh11@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

%{
clear a
a = arduino("/dev/cu.usbmodem1101","Uno")

for i = 1:10
    writeDigitalPin(a,'D10',1) 
    pause(0.5)
    writeDigitalPin(a,'D10',0)
    pause(0.5)
end

%}
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear a
a = arduino("/dev/cu.usbmodem1101","Uno");

duration = 20;
time = 0:1:duration-1;
voltage = zeros(1,duration);
temperature = zeros(1,duration);

volt0 = 0.5;
temp_coeff = 0.01;

for i = 1:duration
    voltage(i) = readVoltage(a,"A1");
    temperature(i) = (voltage(i) - volt0) / temp_coeff;
    pause(1);
    fprintf("%.0f\n", i)
end

voltage
temperature
temp_min = min(temperature);
temp_max = max(temperature);
temp_average = mean(temperature);

fprintf("Minimum Temperature: %.2f °C\n", temp_min);
fprintf("Maximum Temperature: %.2f °C\n", temp_max);
fprintf("Average Temperature: %.2f °C\n", temp_average);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
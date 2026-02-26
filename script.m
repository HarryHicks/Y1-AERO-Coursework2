% harry hicks
% egyhh11@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]

clear a
a = arduino("/dev/cu.usbmodem1301","Uno")

for i = 1:10
    writeDigitalPin(a,'D10',1) 
    pause(0.5)
    writeDigitalPin(a,'D10',0)
    pause(0.5)
end


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% have to clear variable for program to work, and then redefine ardu
% instance
clear a
a = arduino("/dev/cu.usbmodem1301","Uno");
fprintf("connected")

% open up the file and add the headers. i hope matlab syntax is same as
% python so you can do the + to make the file if it doesnt exist

file = fopen('capsule_temperature.txt','w+');
fprintf(file,"Time(s)\tTemperature(C)\n");

% define variables
duration = 600;
time = 0:1:duration-1;
voltage = zeros(1,duration);
temperature = zeros(1,duration);

volt0 = 0.5;
temp_coeff = 0.01;

%loop through the amount of tiems as the duration, pauses inside of the
%loop to make it that many seconds

for i = 1:duration

    % read the voltage at the specific port, and calculate the temp and
    % save that to the array by taking away the voltage at 0 and referring
    % to the temp volt coeff. save that data to the file
    voltage(i) = readVoltage(a,"A0");
    temperature(i) = (voltage(i) - volt0) / temp_coeff;
    pause(1);
    fprintf("%.0f\n", i)
    fprintf(fileID,"%.0f\t%.2f\n", time(i), temperature(i));
end

% calculate the required bits as per the document by referring to all saved
% data in temperature array, print them out

temp_min = min(temperature);
temp_max = max(temperature);
temp_average = mean(temperature);

fprintf("Minimum Temperature: %.2f °C\n", temp_min);
fprintf("Maximum Temperature: %.2f °C\n", temp_max);
fprintf("Average Temperature: %.2f °C\n", temp_average);

% plot the graph with all the data

plot(time, temperature)
xlabel('time in s')
ylabel("temperature in degrees c")


%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% same as before, delete the arduino instance, and then call the function
% in the temp_monitor.m file
clear a
a = arduino("/dev/cu.usbmodem1301","Uno");
fprintf("running")

temp_monitor(a)


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% same as before, delete the arduino instance, and then call the function
% in the temp_prediction.m file

clear a
a = arduino("/dev/cu.usbmodem1301","Uno");
fprintf("running")

temp_prediction(a)


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.

%see the docx file attached to the github repo


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.

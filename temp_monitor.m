function temp_monitor(a)

%define variables and arrays needed for the code
% make the graph, had to use figure according to matlab documentation cause
% was having issues making graph show up. attach a variable to the plot as
% need to adjust data every loop

volt0 = 0.5;
temp_coeff = 0.01;

time = [];
temperature = [];

figure
h = plot(nan, nan);
xlabel("time in s")
ylabel("temperature in degrees C)")
title("temp monitoring")

% start time measuring

start = tic;

while true
    % read temp as before, calculate temp, and then measure time using the
    % toc function as the start bit is already made. add to the end of the
    % array using end, and add one to array position to make it not change
    % the data
    voltage = readVoltage(a,"A0");
    temp = (voltage - volt0)/temp_coeff
    
    t = toc(start);
    time(end+1) = t;
    temperature(end+1) = temp;

    % reset all LEDS

    writeDigitalPin(a,"D4",0)
    writeDigitalPin(a,"D3",0)
    writeDigitalPin(a,"D2",0)

    % logic in order to see what LEDs to turn on

    if temp >= 18 && temp <= 24
        % turn on the green light, other ones below is same except loop to
        % turn the light on and off when required
        writeDigitalPin(a,"D4",1)
        pause(1)
    elseif temp < 13
        writeDigitalPin(a,"D3",1)
        pause(0.5)
        writeDigitalPin(a,"D3",0)
        pause(0.5)
    else
        writeDigitalPin(a,"D2",1)
        pause(0.25)
        writeDigitalPin(a,"D2",0)
        pause(0.25)
        writeDigitalPin(a,"D2",1)
        pause(0.25)
        writeDigitalPin(a,"D2",0)
        pause(0.25)
    end

    % this bit is needed to update the graph live as per the coursework,
    % sets the new data to be whats in the array, and sets the limits to me
    % the current amount of time, and the max and min of the temp to be the
    % max and min in the array. had to do +1 and -1 to the temp as would
    % otherwise break as cant set upper and lower limits to be the same
    % number

    set(h,"XData",time,"YData" ,temperature)
    xlim([0 t])
    ylim([min(temperature)-1 max(temperature)+1])
    drawnow
end
end

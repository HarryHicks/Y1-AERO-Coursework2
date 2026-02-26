% do stuff

function temp_prediction(a)

% same stuff as before, time etc. refer to temp_monitor function

volt0 = 0.5;
temp_coeff = 0.01;

time = [];
temperature = [];
saved_rate = [];


start = tic;

while true
    voltage = readVoltage(a,"A0");
    temp = (voltage - volt0) / temp_coeff;
    t = toc(start);

    time(end+1) = t;
    temperature(end+1) = temp;

    % have to do this as if not, there wont be able to be an average.
    % basically on the first look the average rate will be nothing.

    if length(temperature) >= 2
        % find diffference between the last times and last temps
        dtime = time(end) - time(end-1);
        dtemp = temperature(end) - temperature(end-1);

        % rate would be the temp comapred to time, this is then saved in
        % the array. the last 5 in that array are then referred to in order
        % to grab data, and to make the average rate be a medium term
        % difference compared to just referring to the one at present each
        % loop. inferred this from the coursework document instructions.
        rate = dtemp / dtime;
        saved_rate(end+1) = rate;
        last_five = min(5, length(saved_rate));
        average_rate = mean(saved_rate(end-last_five+1:end));
    else
        average_rate = 0;
    end

    % average rate is currently measured in temp per second, so calculating
    % the 5 min difference and the rate of change of temperature per
    % minute, in order to print

    fivemindiff = temp+(average_rate*300);
    minuterate = average_rate * 60;

    fprintf("current %.2f °C rate %.2f °C/s %.2f °C/min 5 mins %.2f °C\n", temp, average_rate, minuterate, fivemindiff);

    % logic in order to set the LED lights to be a certain colour. D2 is
    % red, D4 is yellow and D3 is green. basically same logic as in the
    % temp_monitor function.
    if average_rate > 4
        writeDigitalPin(a,"D2",1);
        writeDigitalPin(a,"D4",0);
        writeDigitalPin(a,"D3",0);
    elseif average_rate < -4
        writeDigitalPin(a,"D4",1);
        writeDigitalPin(a,"D2",0);
        writeDigitalPin(a,"D3",0);
    elseif temp >= 18 && temp <= 24
        writeDigitalPin(a,"D3",1);
        writeDigitalPin(a,"D4",0);
        writeDigitalPin(a,"D2",0);
    end

    %pause in order to track every second.
    pause(1)
end
end
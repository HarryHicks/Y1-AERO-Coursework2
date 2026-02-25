% do stuff

function temp_prediction(a)

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

    if length(temperature) >= 2
        dtime = time(end) - time(end-1);
        dtemp = temperature(end) - temperature(end-1);

        rate = dtemp / dtime;
        saved_rate(end+1) = rate;
        last_five = min(5, length(saved_rate));
        average_rate = mean(saved_rate(end-last_five+1:end));
    else
        average_rate = 0;
    end

    fivemindiff = temp+(average_rate*300);
    minuterate = average_rate * 60;

    fprintf("current %.2f °C rate %.2f °C/s %.2f °C/min 5 mins %.2f °C\n", temp, average_rate, minuterate, fivemindiff);
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
    pause(1)
end
end
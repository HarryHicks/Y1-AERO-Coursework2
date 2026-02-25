function temp_monitor(a)




volt0 = 0.5;
temp_coeff = 0.01;

time = [];
temperature = [];

figure
h = plot(nan, nan);
xlabel("time in s")
ylabel("temperature in degrees C)")
title("temp monitoring")

start = tic;

while true    
    voltage = readVoltage(a,"A0");
    temp = (voltage - volt0)/temp_coeff
    
    t = toc(start);
    time(end+1) = t;
    temperature(end+1) = temp;
    
    writeDigitalPin(a,"D4",0)
    writeDigitalPin(a,"D3",0)
    writeDigitalPin(a,"D2",0)
    if temp >= 18 && temp <= 24
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
    
    set(h,"XData",time,"YData" ,temperature)
    xlim([0 t])
    ylim([min(temperature)-1 max(temperature)+1])
    drawnow
end
end

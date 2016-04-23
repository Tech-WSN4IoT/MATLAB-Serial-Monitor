% Set serial port. To find out what port the arduino is connected
% to, open device manager and search under Ports (COM & LPT) for USB Serial
% Device (<device port>)
port = 'COM4';
s = serial(port);

if ~isvalid(s)
    error('serial object is not valid')
end
% open communication with the serial port
fopen(s);

global status;
status = true;

text = '';
while status
    if ~strcmp(fgetl(s), text)
        text = fgetl(s);
        disp(text);
    end
    pause(.01);
end
fdelete(s);
fclose(instrfind);
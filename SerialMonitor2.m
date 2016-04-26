% Set serial port. To find out what port the arduino is connected
% to, open device manager and search under Ports (COM & LPT) for USB Serial
% Device (<device port>)
port = 'COM11'; %change COM port based off com port
s = serial(port);
set(s,'BaudRate',115200);
if ~isvalid(s)
    error('serial object is not valid')
end
% open communication with the serial port
fopen(s);

global status;
status = true;

text = '';
n=0;
close all;
figure;
node4 = annotation('textbox',[.1,.5,.3,.3],'String','Node 4','FitBoxToText','on');
node5 = annotation('textbox',[.1,.2,.3,.3],'String','Node 5','FitBoxToText','on');
node6 = annotation('textbox',[.5,.5,.3,.3],'String','Node 6','FitBoxToText','on');
node7 = annotation('textbox',[.5,.2,.3,.3],'String','Node 7','FitBoxToText','on');

coord1 = [.1,.4,.3,.3];
coord2 = [.1,.1,.3,.3];
coord3 = [.5,.4,.3,.3];
coord4 = [.5,.1,.3,.3];
 fig1 = annotation('textbox',coord1,'String','N/A','FitBoxToText','on');
 fig2 = annotation('textbox',coord2,'String','N/A','FitBoxToText','on');
 fig3 = annotation('textbox',coord3,'String','N/A','FitBoxToText','on');
 fig4 = annotation('textbox',coord4,'String','N/A','FitBoxToText','on');
 curCoord = coord1;
 figure1 = fig4;

 while status %& n < 10 %make sure to get rid of this n<10
    n = n + 1;
    if ~strcmp(fgetl(s), text)
        text = fgetl(s);
        disp(text);
    end
    if strcmp(text,'')
        
    else
%         text1 = num2str(n);
%         text2 = num2str(power(n,2));
        num = str2num(text);
        if strcmp(text(1),'=')


        elseif num < 10 %not a temperature reading but a node #
            switch num
                case 4
                    figure = fig1;
                    curCoord = coord1;
                case 5
                    figure = fig2; 
                    curCoord = coord2;
                case 6
                    figure = fig3;
                    curCoord = coord3;
                case 7                 
                    figure = fig4;
                    curCoord = coord4;
            end
        else
            strF = [text,char(176),'C'];
    %          delete(fig1);
    %          delete(fig2);
    %          delete(fig3);
    %          delete(fig4);
    %         fig1 = annotation('textbox',[.1,.1,.3,.3],'String','N/A','FitBoxToText','on');
    %         fig1.FontSize = 30;
    %         fig2 = annotation('textbox',[.1,.4,.3,.3],'String','N/A','FitBoxToText','on');
    %         fig2.FontSize = 30;
    %         fig3 = annotation('textbox',[.5,.1,.3,.3],'String','N/A','FitBoxToText','on');
    %         fig3.FontSize = 30;
    %         fig4 = annotation('textbox',[.5,.4,.3,.3],'String','N/A','FitBoxToText','on');
    %         fig4.FontSize = 30;
    %         delete(figure);
            delete(figure1);
            delete(figure);
            figure = annotation('textbox',curCoord,'String',strF,'FitBoxToText','on');
            figure.FontSize = 30;
            figure1 = figure; %figure1 becomes a place holder to delete this object, because we change figure in our switch statement
            drawnow;    %we probably could do some changing to these figure variables

        end
    %     drawnow;
        pause(.01);
    end
end
fclose(s); %if you CTRL-C out, make you paste the next 3 lines into the
delete(s); %command window, plus the line delete(instrfindall)
clear s;

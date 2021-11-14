%%
%     COURSE: Master MATLAB through guided problem-solving
%    SECTION: Command statements
%      VIDEO: Day of the week
% Instructor: mikexcohen.com
%
%%

% "A" is the year
A = 2022;
DayOfWeek = [ "Sunday",  "Monday",  "Tuesday",  "Wednesday",  "Thursday",  "Friday", "Saturday" ];

% here's the formula
day1Jan = mod(1+5*mod(A-1,4)+4*mod(A-1,100)+6*mod(A-1,400),7);

% match that with the correct string
switch day1Jan
    case 0
        day = 'Sunday';
    case 1
        day = 'Monday';
    case 2
        day = 'Tuesday';
    case 3
        day = 'Wednesday';
    case 4
        day = 'Thursday';
    case 5
        day = 'Friday';
    case 6
        day = 'Saturday';
end

% find this year
nowIsh = datetime();
currentYear = nowIsh.Year;


% print the information using appropriate grammar!
% bonus: avoid the switch-case!
if (A < currentYear)
    tense = 'was';
elseif (A == currentYear)
   tense = 'is';
elseif (A > currentYear)
    tense = 'will be';
end
fprintf('  1 January %g %s a %s\n',A,tense,DayOfWeek(day1Jan+1));
%%

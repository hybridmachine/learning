%%loop A
i = 0;
while i < 5
    i=i+1;
    fprintf('%g ', i);
end
fprintf('\n');

%%loop B
i = 0;
while i < 5
    fprintf('%g ', i);
    i=i+1;
end
fprintf('\n');


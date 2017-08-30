addpath('../modules/matlab-subdir/subdir')

currentfolder  = pwd();
listofmodfiles = subdir(fullfile('.', '*.mod'));
numberoftests  = length(listofmodfiles);

str = '';

for i=1:numberoftests
    [~, modfilename, ~] = fileparts(listofmodfiles(i).name);
    cd(listofmodfiles(i).folder);
    try
        dynare(modfilename)
        str = sprintf('%s\n%s\t\t\t Okay', str, listofmodfiles(i).folder);
    catch
        str = sprintf('%s\n%s\t\t\t Failed', str, listofmodfiles(i).folder);
    end
end

close all
cd(currentfolder)
disp(str)
% scripts/startup.m
proj = currentProject;
root = proj.RootFolder;

addpath(fullfile(root,'scripts'));
addpath(fullfile(root,'libraries'));
addpath(fullfile(root,'models'));
addpath(fullfile(root,'models','tests'));

% 自动打开库（可选）
open_system(fullfile(root,'libraries','MyPMSMLibrary.slx'));
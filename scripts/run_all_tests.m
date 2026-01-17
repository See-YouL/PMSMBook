% scripts/run_all_tests.m
proj = currentProject;
root = proj.RootFolder;

testModel = fullfile(root,'models','tests','Clark_Test.slx');
load_system(testModel);

simOut = sim(testModel);

disp("Clark_Test finished.");

% 如果你用 Display 看数值，这里只提示结束；
% 如果你用 To Workspace 保存 alpha_out/beta_out，可以在这里断言检查。

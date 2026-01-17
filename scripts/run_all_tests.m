function run_all_tests()
% RUN_ALL_TESTS
% 工程级测试入口
%
% 功能：
%   1) 自动运行所有变换模块的测试脚本
%   2) 任一测试失败立即中断并报错
%   3) 所有测试通过后给出统一提示
%
% 依赖：
%   tests/
%     ├─ test_Clark.m
%     ├─ test_InClark.m
%     └─ test_Park.m

    clc;
    fprintf('==============================\n');
    fprintf(' PMSM 变换模块自动测试开始\n');
    fprintf('==============================\n\n');

    %% 确保工程已打开
    try
        prj = currentProject;
        fprintf('当前工程：%s\n\n', prj.Name);
    catch
        error('未检测到已打开的 MATLAB 工程，请先打开 PMSM.prj');
    end

    %% 测试列表（按顺序执行）
    testList = {
        'test_Clark'
        'test_InClark'
        'test_Park'
    };

    %% 依次运行测试
    for k = 1:numel(testList)
        testName = testList{k};
        fprintf('>>> 正在运行 %s ...\n', testName);

        try
            feval(testName);   % 调用测试函数
            fprintf('>>> %s 通过\n\n', testName);
        catch ME
            fprintf('\n');
            fprintf('测试失败：%s\n', testName);
            fprintf('错误信息：%s\n', ME.message);
            fprintf('==============================\n');
            rethrow(ME);  % 抛出错误，中断测试
        end
    end

    %% 全部测试通过
    fprintf('==============================\n');
    fprintf('所有测试通过！\n');
    fprintf('Clark / InClark / Park 模块工作正常\n');
    fprintf('==============================\n');
end

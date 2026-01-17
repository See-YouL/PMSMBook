function test_Clarke()
% TEST_CLARKE
% 使用 Inport A/B/C 对 Clarke_Test.slx 进行常数输入测试
%
% 测试输入：
%   A = 1
%   B = -0.5
%   C = -0.5
%
% 对于 2/3 幅值不变 Clarke 变换，理论结果应为：
%   Alpha = 1
%   Beta  = 0
%
% 模型要求：
%   1) 顶层 Inport 名称为：A, B, C
%   2) 使用 To Workspace（保存到 SimulationOutput）
%      变量名分别为：alpha_out, beta_out

    %% 1. 模型名称
    model = 'Clarke_Test';

    % 加载模型（不打开界面也可以）
    load_system(model);

    %% 2. 构造常数输入信号（用 timeseries，保证外部输入稳定）
    Ts = 1e-4;          % 采样时间(步长)
    Tstop = 1e-3;       % 仿真结束时间（常数测试很短即可）
    t = (0:Ts:Tstop)';  % 时间向量

    A =  1.0  * ones(size(t));
    B = -0.5  * ones(size(t));
    C = -0.5  * ones(size(t));

    %% 3. 构造仿真输入对象
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset，元素名必须与 Inport 名称一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(A, t), 'A');
    ds = ds.addElement(timeseries(B, t), 'B');
    ds = ds.addElement(timeseries(C, t), 'C');

    in = in.setExternalInput(ds);

    %% 4. 运行仿真
    out = sim(in);

    %% 5. 读取输出结果
    alpha = out.alpha_out;
    beta  = out.beta_out;

    alpha_end = alpha(end);
    beta_end  = beta(end);

    %% 6. 打印结果
    fprintf('Clarke 常数输入测试结果：\n');
    fprintf('  输入信号： A=1, B=-0.5, C=-0.5\n');
    fprintf('  Alpha = %.6f\n', alpha_end);
    fprintf('  Beta  = %.6f\n', beta_end);

    %% 7. 自动判定是否通过（断言）
    % 理论值：Alpha = 1, Beta = 0
    tol = 1e-6;  % 允许误差

    assert(abs(alpha_end - 1) < tol, '❌ Alpha 结果错误');
    assert(abs(beta_end  - 0) < tol, '❌ Beta 结果错误');

    fprintf('✅ Clarke 常数输入测试通过\n');
end

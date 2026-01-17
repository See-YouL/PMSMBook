function test_InClark()
% TEST_INClark
% 使用 Inport Alpha/Beta 对 InClark_Test.slx 进行常数输入测试
%
% 测试输入：
%   Alpha = 1
%   Beta  = 0
%
% 对于 2/3 幅值不变 Clark 变换，理论结果应为：
%   A = 1
%   B = -0.5
%   C = -0.5
%
% 模型要求：
%   1) 顶层 Inport 名称为：Alpha, Beta
%   2) 使用 To Workspace（保存到 SimulationOutput）
%      变量名分别为：A_out, B_out, C_out

    %% 1. 模型名称
    model = 'InClark_Test';

    % 加载模型（不打开界面也可以）
    load_system(model);

    %% 2. 构造常数输入信号（用 timeseries，保证外部输入稳定）
    Ts = 1e-4;          % 采样时间(步长)
    Tstop = 1e-3;       % 仿真结束时间（常数测试很短即可）
    t = (0:Ts:Tstop)';  % 时间向量

    Alpha =  1.0  * ones(size(t));
    Beta =  0.0  * ones(size(t));

    %% 3. 构造仿真输入对象
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset，元素名必须与 Inport 名称一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(Alpha, t), 'Alpha');
    ds = ds.addElement(timeseries(Beta, t), 'Beta');

    in = in.setExternalInput(ds);

    %% 4. 运行仿真
    out = sim(in);

    %% 5. 读取输出结果
    A_out = out.A_out;
    B_out  = out.B_out;
    C_out  = out.C_out;

    A_end = A_out(end);
    B_end = B_out(end);
    C_end = C_out(end);

    %% 6. 打印结果
    fprintf('反Clark 常数输入测试结果：\n');
    fprintf('  输入信号： Alpha=1, Beta=0\n');
    fprintf('  A = %.6f\n', A_end);
    fprintf('  B = %.6f\n', B_end);
    fprintf('  C = %.6f\n', C_end);

    %% 7. 自动判定是否通过（断言）
    tol = 1e-6;  % 允许误差

    assert(abs(A_end - 1.0)  < tol, 'A 结果错误');
    assert(abs(B_end + 0.5)  < tol, 'B 结果错误'); % B 应为 -0.5
    assert(abs(C_end + 0.5)  < tol, 'C 结果错误'); % C 应为 -0.5

    fprintf('反Clark 常数输入测试通过\n');
end
function test_InPark()
% TEST_INPARK
% 使用 Inport D/Q/The 对 InPark_Test.slx 进行常数输入测试（反Park变换 dq->alpha beta）
%
% 测试输入：
%   D   = 1
%   Q   = 0
%   The = 0 (rad)
%
% 对于反Park变换：
%   alpha = D*cos(The) - Q*sin(The)
%   beta  = D*sin(The) + Q*cos(The)
%
% 当 D=1, Q=0, The=0 时，理论结果应为：
%   alpha = 1
%   beta  = 0
%
% 模型要求：
%   1) 顶层 Inport 名称为：D, Q, The
%   2) To Workspace（保存到 SimulationOutput）
%      变量名分别为：alpha_out, beta_out

    %% 1. 模型名称（改成你的 slx 文件名，不要带 .slx）
    model = 'InPark_Test';

    % 先加载库（如果 Park_Test 引用了 MyPMSMLibrary，建议加载）
    load_system('MyPMSMLibrary');

    % 加载模型（不打开界面也可）
    load_system(model);

    %% 2. 构造常数输入信号（用 timeseries，作为外部输入）
    Ts = 1e-4;          % 采样时间
    Tstop = 1e-3;       % 仿真结束时间
    t = (0:Ts:Tstop)';  % 时间向量（列向量）

    D   = 1.0 * ones(size(t));
    Q   = 0.0 * ones(size(t));
    The = 0.0 * ones(size(t));   % 单位：rad

    %% 3. 构造仿真输入对象
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset，元素名必须与 Inport 名称一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(D,   t), 'D');
    ds = ds.addElement(timeseries(Q,   t), 'Q');
    ds = ds.addElement(timeseries(The, t), 'The');

    in = in.setExternalInput(ds);

    %% 4. 运行仿真
    out = sim(in);

    %% 5. 读取输出结果（To Workspace：保存到 SimulationOutput）
    alpha = out.alpha_out;
    beta  = out.beta_out;

    % 如果你 To Workspace 的保存格式是 timeseries，需要取 Data
    % （若你保存格式是"数组"，alpha/beta 就是数值向量，不需要这一步）
    if isa(alpha, 'timeseries'); alpha = alpha.Data; end
    if isa(beta,  'timeseries'); beta  = beta.Data;  end

    alpha_end = alpha(end);
    beta_end  = beta(end);

    %% 6. 打印结果
    fprintf('反Park( dq->αβ ) 常数输入测试结果：\n');
    fprintf('  输入信号： D=1, Q=0, The=0(rad)\n');
    fprintf('  alpha = %.6f\n', alpha_end);
    fprintf('  beta  = %.6f\n', beta_end);

    %% 7. 自动判定是否通过（断言）
    tol = 1e-6;  % 允许误差
    assert(abs(alpha_end - 1) < tol, 'alpha 结果错误');
    assert(abs(beta_end  - 0) < tol, 'beta 结果错误');

    fprintf('反Park 常数输入测试通过\n');
end

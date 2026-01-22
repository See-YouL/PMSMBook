# 现代永磁同步电机控制原理及MATLAB仿真笔记

## 笔记说明

- 参考书目： 《现代永磁同步电机控制原理及MATLAB仿真》
- 测试版本： Matlab R2025b

## 三相PMSM的基本数学模型

假设三相PMSM为理想电机，且满足下列条件：

1. 忽略电机铁芯的饱和。
2. 不计电机中的涡流和磁滞损耗。
3. 电机中的电流为对称的三相正弦波电流。

在**自然坐标系**下，三相PMSM的电压方程为：

$$
\begin{equation}
u_{3s} = R i_{3s} + \frac{d}{dt} \Psi_{3s}
\tag{1-1}
\end{equation}
$$

磁链方程为

$$
\begin{equation}
\Psi_{3s} = L_{3s} i_{3s} + \psi_f \cdot F_{3s}(\theta_e)
\tag{1-2}
\end{equation}
$$

其中

- $\Psi_{3s}$：三相绕组的磁链向量
- $u_{3s}$：三相绕组的相电压向量
- $i_{3s}$：三相绕组的相电流向量
- $R$：每相绕组的电阻
- $L_{3s}$：三相绕组的电感矩阵
- $ F_{3s}(\theta_e)$：三相绕组的磁链分布函数

且满足

$$
\mathbf{i}_{3s} =
\begin{bmatrix}
i_A \\
i_B \\
i_C
\end{bmatrix}
$$

$$
\mathbf{R}_{3s} =
\begin{bmatrix}
R & 0 & 0 \\
0 & R & 0 \\
0 & 0 & R
\end{bmatrix}
$$

$$
\mathbf{\Psi}_{3s} =
\begin{bmatrix}
\psi_A \\
\psi_B \\
\psi_C
\end{bmatrix}
$$

$$
\mathbf{u}_{3s} =
\begin{bmatrix}
u_A \\
u_B \\
u_C
\end{bmatrix}
$$

$$
\mathbf{F}_{3s}(\theta_{e}) =
\begin{bmatrix}
sin(\theta_{e}) \\
sin(\theta_e - 2 \pi / 3) \\
sin(\theta_e + 2 \pi /3)
\end{bmatrix}
$$

$$
\mathbf{L}_{3s} =
L_{m3}\begin{bmatrix}
1 & cos2\pi/3 & cos4\pi/3 \\
cos2\pi/3 & 1 & cos2\pi/3 \\
cos4\pi/3 & cos2\pi/3 & 1
\end{bmatrix}
+
L_{l3}\begin{bmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 1
\end{bmatrix}
$$

其中

- $L_{m3}$ : 定子互感
- $L_{l3}$ : 定子漏感

电磁转矩$T_{e}$等于磁场储能对机械角$\theta_{m}$位移的偏导

$$
\begin{equation}
T_{e} =
\frac{1}{2} p_{n}
\frac{\partial}{\partial \theta_{m}}
(\mathbf{i}_{3s}^{T} \cdot \mathbf{\Psi_{3s}})
\tag{1-3}
\end{equation}
$$

其中

- $p_{n}$ : 三相PMSM的极对数

电机的机械运动方程

$$
\begin{equation}
J \frac{d\omega_{m}}{dt} =
T_{e} - T_{L} - B\omega_{m}
\tag{1-4}
\end{equation}
$$

其中

- $\omega_{m}$ : 电机的机械角速度
- $J$ : 转动惯量
- $B$ : 阻尼系数
- $T_{L}$ : 负载转矩

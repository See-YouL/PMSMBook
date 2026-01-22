# 现代永磁同步电机控制原理及MATLAB仿真

## 基础说明

- 参考书目： 《现代永磁同步电机控制原理及MATLAB仿真》
- 测试版本： Matlab R2025b

## 工程架构

```txt
PMSMBook/                             (工程根目录)
├─ PMSM.prj                           (MATLAB工程文件)
├─ 现代永磁同步电机控制原理及MATLAB仿真.pdf (参考书)
├─ Notes/                             (笔记目录)
│  ├─ Notes.md                        (笔记文件)
│  └─ ...                             (笔记文件中的图片)
├─ README.md                          (README文件)
├─ libraries/
│  └─ MyPMSMLibrary.slx               (书中的模型库)
├─ models/
│  ├─ tests/
│  │  └─ xxx.slx                      (单元测试模型)
│  └─ demos/                          (示例模型)
├─ blocks/                            (子系统源模型)
│  └─ xxx.slx
├─ scripts/
│  ├─ startup.m                       (工程打开时自动跑)
│  └─ run_all_tests.m                 (一键运行测试)
└─ resources/
   └─ ...                             (图片、文档等)
```

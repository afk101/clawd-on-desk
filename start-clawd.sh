#!/bin/bash

# ============================================================
# Clawd 桌宠 — 开机自启脚本
# 用法：添加到 macOS 登录项（系统设置 → 通用 → 登录项）
# 或通过 launchctl 加载 plist 实现自动启动
# ============================================================

# 项目根目录：基于脚本自身所在位置自动推导，无需写死路径
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 防止重复启动：检测是否已有 Clawd Electron 进程在运行
if pgrep -f "clawd-on-desk" > /dev/null 2>&1; then
    exit 0
fi

# 切换到项目目录
cd "$PROJECT_DIR" || exit 1

# 清除可能存在的 ELECTRON_RUN_AS_NODE 环境变量（与 launch.js 保持一致）
unset ELECTRON_RUN_AS_NODE

# 等待桌面环境就绪（macOS 登录项有时启动过早）
sleep 3

# 使用 nohup 在后台启动，丢弃所有输出
nohup npm start > /dev/null 2>&1 &

exit 0

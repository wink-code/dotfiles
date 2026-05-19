#!/bin/bash

# 用法：./dir_usage.sh <目录路径>
# 功能：显示目录的总磁盘占用（人类可读格式，默认取整到 M/G）

# 检查是否提供了参数
if [ $# -ne 1 ]; then
    echo "错误：请指定一个目录。"
    echo "用法：$0 /path/to/directory"
    exit 1
fi

TARGET_DIR="$1"

# 检查目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误：目录 '$TARGET_DIR' 不存在或不是一个目录。"
    exit 1
fi

# 使用 du 命令获取总大小（-s 汇总，-h 人类可读）
# 2>/dev/null 屏蔽可能因权限不足产生的错误（可选）
SIZE=$(du -sh "$TARGET_DIR" 2>/dev/null | cut -f1)

# 如果 du 执行失败（比如无权限），SIZE 可能为空
if [ -z "$SIZE" ]; then
    echo "错误：无法读取目录 '$TARGET_DIR'，可能是权限不足。"
    exit 1
fi

echo "目录 '$TARGET_DIR' 的总占用空间为：$SIZE"
exit 0

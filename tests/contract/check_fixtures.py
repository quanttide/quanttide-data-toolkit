#!/usr/bin/env python3
"""契约 fixture 语法检查：所有 tests/contract/*.yaml 必须是合法 YAML。
CI 调用（主仓层），防 fixture 手改坏导致各语言契约测试静默失败。"""
import sys, yaml, glob

failed = False
for f in sorted(glob.glob("tests/contract/*.yaml")):
    try:
        with open(f) as fh:
            data = yaml.safe_load(fh)
        assert isinstance(data, dict) and data, f"{f}: 空或非对象"
        print(f"✓ {f}: {len(data)} 顶层字段")
    except Exception as e:
        failed = True
        print(f"✗ {f}: {e}")
sys.exit(1 if failed else 0)

# Fall Core - 单元测试

本目录包含 Fall Core 框架的单元测试。

## 运行测试

### 运行所有测试
```bash
dart test
```

### 运行特定测试文件
```bash
dart test test/utils/gen_util_test.dart
```

### 运行测试并显示详细信息
```bash
dart test --reporter=expanded
```

### 运行测试并显示代码覆盖率
```bash
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.packages --report-on=lib
```

## 测试结构

### `test/utils/gen_util_test.dart`
测试 `GenUtil` 类的功能，包括：
- `getImportPath` - 计算相对导入路径
- `checker` - 创建 TypeChecker 实例
- `hasAnnotation` - 检查元素是否有指定注解
- `getAnnotation` - 获取元素的注解对象

#### 主要测试场景

**getImportPath 方法测试：**
- Package URI 处理（如 `package:flutter/material.dart`）
- 文件 URI 相对路径计算
- Windows 路径格式支持
- 跨目录和嵌套目录结构
- 错误处理和边缘情况

**checker 方法测试：**
- 不同类型的 TypeChecker 创建
- 类型识别和字符串表示

**注解相关方法测试：**
- 方法签名正确性验证
- 基本功能测试

**集成测试：**
- 真实 Flutter 项目结构场景
- Package 导入一致性验证

## 测试覆盖

当前测试覆盖了 `GenUtil` 类的所有公共方法：
- ✅ `getImportPath` - 完整测试
- ✅ `checker` - 完整测试  
- ✅ `hasAnnotation` - 基础测试
- ✅ `getAnnotation` - 基础测试

## 添加新测试

在添加新测试时，请遵循以下约定：
1. 使用描述性的测试名称
2. 遵循 AAA 模式（Arrange-Act-Assert）
3. 为每个方法创建单独的测试组
4. 包含正常情况、边缘情况和错误情况的测试
5. 添加必要的注释说明测试目的

## 依赖

测试依赖以下包：
- `test: ^1.25.0` - Dart 测试框架
- `analyzer` - 用于代码分析相关测试
- `source_gen` - 用于代码生成相关测试
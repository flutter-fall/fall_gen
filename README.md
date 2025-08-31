# Fall Gen

[![Pub Version](https://img.shields.io/pub/v/fall_gen)](https://pub.dev/packages/fall_gen)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Dart](https://img.shields.io/badge/Dart-3.8.1+-blue.svg)](https://dart.dev/)
[![Flutter](https://img.shields.io/badge/Flutter-compatible-blue.svg)](https://flutter.dev/)

**Fall Gen** 是 Fall 框架的代码生成工具包，专门负责在编译时为 Flutter 应用生成 AOP（面向切面编程）代理类和依赖注入相关代码。

## 🌟 项目定位

Fall Gen 与 [Fall Core](https://pub.dev/packages/fall_core) 配合使用，为 Flutter 开发者提供类似 Spring Framework 的企业级开发体验。Fall Gen 专门负责编译时代码生成，Fall Core 提供运行时基础设施。

[中文文档 | Chinese Documentation](#中文文档)

## ✨ 核心特性

### 🔧 编译时代码生成
- **AOP 代理生成**: 为 `@Aop` 注解标注的类生成增强代理类
- **服务扫描注册**: 扫描 `@Service` 注解并生成自动注册代码
- **依赖注入生成**: 为 `@Auto` 标注的属性生成注入代码
- **类型安全**: 编译时检查，避免运行时错误

### 📝 注解解析
- **`@AutoScan`**: 扫描配置，支持 include/exclude 模式
- **`@Service`**: 服务类标识，支持命名和生命周期配置
- **`@Aop`**: AOP 增强标识，支持 Hook 过滤
- **`@Auto`**: 依赖注入标识，支持命名注入
- **`@NoAop`**: 排除 AOP 处理的方法

### 🚀 构建集成
- **build_runner 支持**: 原生支持 Dart 编译工具链
- **增量构建**: 只重新生成变更的文件
- **热重载支持**: 开发模式下的实时代码生成
- **错误报告**: 详细的编译时错误信息

## 🚀 快速开始

### 安装说明

在 `pubspec.yaml` 中添加以下依赖：

```yaml
dependencies:
  fall_core: ^0.0.1  # 运行时框架，包含注解和 Hook 接口
  get: ^4.7.2         # 依赖注入容器

dev_dependencies:
  fall_gen: ^0.0.2    # 代码生成工具（仅在开发时使用）
  build_runner: ^2.7.0
```

然后运行：

```bash
flutter pub get
```

### 基本使用

#### 1. 配置自动扫描

```dart
import 'package:fall_core/fall_core.dart';

// 配置服务扫描
part 'app_config.g.dart';

@AutoScan(
  include: [
    'lib/services/**/*.dart',  // 扫描服务目录
    'lib/controllers/**/*.dart', // 扫描控制器目录
  ],
  exclude: [
    '**/*.g.dart',            // 排除生成文件
    '**/*.freezed.dart',      // 排除 freezed 文件
  ],
)
class AppConfig {}
```

#### 2. 定义服务

```dart
import 'package:fall_core/fall_core.dart';

// 基础服务定义
@Service()
class UserService {
  Future<User> getUserById(String id) async {
    // 业务逻辑
  }
}

// 带 AOP 的服务
@Service()
@Aop(allowedHooks: ['logging', 'timing'])
class OrderService {
  Future<Order> createOrder(Order order) async {
    // 业务逻辑
  }

  @NoAop() // 跳过 AOP 处理
  String _generateOrderId() {
    return 'ORDER_${DateTime.now().millisecondsSinceEpoch}';
  }
}

// 命名服务
@Service(name: 'primaryCache')
class CacheService {
  void set(String key, dynamic value) { /* ... */ }
  dynamic get(String key) { /* ... */ }
}
```

#### 2. 依赖注入

```dart
@Service()
class OrderController {
  @Auto() // 自动注入
  late UserService userService;
  
  @Auto(name: 'primaryCache') // 命名注入
  late CacheService cacheService;
  
  Future<void> processOrder(String userId, Order order) async {
    final user = await userService.getUserById(userId);
    cacheService.set('last_order_${userId}', order);
    // 处理订单逻辑
  }
}
```

#### 3. AOP Hook 定义

```dart
// 日志记录 Hook
class LoggingHook implements BeforeHook, AfterHook {
  @override
  String get name => 'logging';
  
  @override
  void onBefore(HookContext context) {
    print('开始执行: ${context.methodName}');
  }
  
  @override
  void onAfter(HookContext context, dynamic result) {
    print('执行完成: ${context.methodName} -> $result');
  }
}

// 性能监控 Hook
class TimingHook implements AroundHook {
  @override
  String get name => 'timing';
  
  @override
  dynamic execute(HookContext context, Function() proceed) {
    final stopwatch = Stopwatch()..start();
    try {
      final result = proceed();
      return result;
    } finally {
      stopwatch.stop();
      print('${context.methodName} 执行耗时: ${stopwatch.elapsedMilliseconds}ms');
    }
  }
}
```

#### 4. 应用初始化

```dart
void main() {
  // 初始化服务容器
  AutoScan.registerServices();
  
  // 注册 AOP Hooks
  final aopService = Get.find<AopService>();
  aopService.addBeforeHook(LoggingHook());
  aopService.addAroundHook(TimingHook());
  
  // 执行依赖注入
  AutoScan.injectServices();
  
  runApp(MyApp());
}
```

#### 5. 代码生成

```bash
# 运行代码生成
dart run build_runner build

# 监视模式（开发推荐）
dart run build_runner watch
```

## 📚 核心概念

### 注解系统

| 注解 | 用途 | 示例 |
|------|------|------|
| `@Service()` | 标记服务类 | `@Service(name: 'userService', lazy: false)` |
| `@Aop()` | 启用 AOP 增强 | `@Aop(allowedHooks: ['logging'])` |
| `@Auto()` | 自动依赖注入 | `@Auto(name: 'primaryCache')` |
| `@NoAop()` | 跳过 AOP 处理 | `@NoAop(reason: '性能敏感方法')` |

### Hook 类型

- **BeforeHook**: 在目标方法执行前调用
- **AfterHook**: 在目标方法执行后调用
- **AroundHook**: 完全包围目标方法的执行
- **ThrowHook**: 在方法抛出异常时调用

### 执行顺序

```
AroundHook.before → BeforeHook → 目标方法 → AfterHook → AroundHook.after
                                    ↓ (异常)
                                ThrowHook
```

## 🏗️ 架构对比

| 特性 | Spring (Java) | Fall Core (Flutter) |
|------|---------------|----------------------|
| 依赖注入 | @Autowired, @Component | @Auto, @Service |
| AOP | @Aspect, @Around | @Aop, AroundHook |
| 配置 | application.yml | pubspec.yaml |
| 代码生成 | 反射 + 代理 | build_runner |
| 容器 | ApplicationContext | GetX + AutoScan |

## 📖 示例项目

查看 [example](./example) 目录获取完整的示例项目，包含：

- 完整的服务定义和注入示例
- AOP Hook 的使用演示
- 错误处理和参数验证
- 性能监控和日志记录
- 完整的 Flutter 应用示例

## 🔧 配置

### build.yaml 配置

```yaml
targets:
  $default:
    builders:
      fall_core|aop_generator:
        enabled: true
        generate_for:
          - lib/**
      fall_core|service_generator:
        enabled: true
        generate_for:
          - lib/**
```

### 自定义配置

```dart
// 自定义服务配置
@Service(
  name: 'customService',
  lazy: false,        // 立即初始化
  singleton: true,    // 单例模式
)
class CustomService { }

// 自定义 AOP 配置
@Aop(
  allowedHooks: ['logging', 'security', 'timing'],
  name: 'secureService'
)
class SecureService { }
```

## 🤝 贡献指南

我们欢迎社区贡献！请查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解如何参与项目开发。

### 开发环境设置

```bash
# 克隆项目
git clone https://github.com/flutter-fall/fall_core.git
cd fall-core

# 安装依赖
flutter pub get

# 运行示例
cd example
flutter pub get
dart run build_runner build
flutter run
```

## 📄 许可证

本项目采用 [MIT 许可证](LICENSE)。

## 🔗 相关链接

- [API 文档](https://pub.dev/documentation/fall_core)
- [示例项目](./example)
- [更新日志](CHANGELOG.md)
- [问题反馈](https://github.com/flutter-fall/fall_core/issues)

## 🙏 致谢

特别感谢以下项目的启发：

- [Spring Framework](https://spring.io/) - Java 企业级应用框架
- [GetX](https://github.com/jonataslaw/getx) - Flutter 状态管理和依赖注入
- [Injectable](https://github.com/Milad-Akarie/injectable) - Dart 依赖注入代码生成

---

**Fall Core** - 让 Flutter 开发更简单、更优雅、更企业级 🚀
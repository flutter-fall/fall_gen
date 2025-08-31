/// Fall Gen - Flutter 应用的代码生成工具包
///
/// Fall Gen 专门负责为 Fall 框架生成编译时代码，包括：
/// - AOP 代理类生成
/// - 服务注册代码生成
/// - 依赖注入代码生成
///
/// 配合 Fall Core 使用，为 Flutter 开发提供企业级架构支持。
///
/// 使用方法：
/// 1. 添加 fall_gen 作为 dev_dependency
/// 2. 使用 @AutoScan、@Service、@Aop 等注解标记类
/// 3. 运行 `dart run build_runner build` 生成代码
///
/// 更多信息请访问：https://pub.dev/packages/fall_gen

// 代码生成工具类
export 'src/utils/utils.dart';

// 代码生成器（仅供内部使用）
// export 'src/generators/generators.dart';

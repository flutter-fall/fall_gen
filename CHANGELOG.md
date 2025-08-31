# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2025-08-31

### Added
- **项目独立**: Fall Gen 从 Fall Core 中独立出来，成为专门的代码生成包
- **@AutoScan 注解支持**: 支持 include/exclude 模式配置，灵活控制扫描范围
- **服务扫描优化**: 改进扫描逻辑，只处理当前项目文件，避免扫描 Flutter SDK
- **Part 文件生成**: 生成的代码作为被注解类的 part 文件，更好的代码组织
- **扩展方法生成**: 为 @AutoScan 标注的类生成 registerServices() 和 injectServices() 扩展方法

### Enhanced
- **AOP 代理生成**: 优化 AOP 代理类生成逻辑，支持复杂构造函数
- **类型安全**: 加强编译时类型检查，减少运行时错误
- **性能优化**: 优化扫描算法，提高大型项目的构建速度

### Technical
- **依赖管理**: 正确配置对 fall_core 的依赖关系
- **Builder 配置**: 更新 build.yaml 配置，使用 fall_gen 作为包名
- **项目文档**: 完整更新 README、发布脚本等项目文档

### Breaking Changes
- 从 Fall Core 中分离的新包，需要 Fall Core 作为运行时依赖
- @AutoScan 注解修改为生成 Extension 方法而非静态类

## [0.0.1] - 2025-08-25

### Added
- Initial release of Fall Core framework
- **Dependency Injection System**
  - `@Service` annotation for service registration
  - `@Auto` annotation for automatic dependency injection
  - Support for named services with `name` parameter
  - Lazy loading and singleton lifecycle management
  - Integration with GetX for dependency lookup
- **Aspect-Oriented Programming (AOP)**
  - `@Aop` annotation for method interception
  - `@NoAop` annotation to exclude methods from AOP
  - Hook system with BeforeHook, AfterHook, AroundHook, and ThrowHook
  - Automatic proxy class generation for AOP functionality
- **Code Generation**
  - Compile-time code generation using `build_runner`
  - `service_generator` for automatic service registration
  - `aop_generator` for AOP proxy class generation
  - Type-safe code generation avoiding runtime reflection
- **Core Components**
  - `AutoScan` utility for automatic service registration and injection
  - `AopService` for managing hooks and AOP functionality
  - `InjectUtil` for dependency injection utilities
  - `LoggerFactory` for business and system logging
- **Annotations System**
  - Complete annotation system for DI and AOP
  - Support for custom configuration parameters
  - Build-time validation and error reporting
- **Example Application**
  - Comprehensive example demonstrating all features
  - Sample services with AOP integration
  - Test cases for various scenarios

### Features
- **Enterprise-Grade Architecture**: Inspired by Spring Framework
- **Compile-Time Safety**: No runtime reflection, all code generated at build time
- **Performance Optimized**: Minimal runtime overhead with compile-time optimization
- **Developer Friendly**: Annotation-driven development with clear APIs
- **Modular Design**: Clean separation of concerns with AOP support
- **Comprehensive Logging**: Built-in logging system with hook integration

### Technical Details
- Minimum Dart SDK: 3.8.1
- Flutter support with GetX integration
- Build runner integration for code generation
- Compatible with modern Flutter development practices

### Documentation
- Complete API documentation
- Quick start guide
- Advanced usage examples
- Best practices and guidelines

## [Unreleased]

### Planned Features
- Performance monitoring hooks
- Enhanced error handling and validation
- Additional lifecycle management options
- Plugin system for custom generators
- Integration with other state management solutions

---

**Note**: This is the first stable release of Fall Core. We follow semantic versioning, so any breaking changes will be clearly documented and versioned appropriately.
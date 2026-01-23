# Project Context

## Purpose

krkrsdl2 (Kirikiri SDL2) is a cross-platform port of Kirikiri Z, a visual novel game engine, enabling execution on platforms supporting SDL2 including macOS, Linux, iOS, Android, Emscripten (web), PS Vita, and Nintendo Switch.

## Tech Stack

- **Core Engine**: C++11 (Kirikiri Z fork)
- **Graphics/Audio/Input**: SDL2
- **Audio Backend**: FAudio
- **Build Systems**: CMake (primary), Meson (deprecated)
- **Platform Support**: Windows, macOS, Linux, iOS, Android, Web (Emscripten), PS Vita, Nintendo Switch
- **SIMD Optimization**: SSE2, AVX2, ARM NEON (via SIMDe for portable platforms)

## Project Conventions

### Code Style

- C++11 standard for core engine code
- GNU C11 for C code
- Use platform-specific macros: `__SWITCH__`, `__vita__`, `__EMSCRIPTEN__`, `IOS`, `ANDROID`, `_WIN32`
- Conditional compilation for platform-specific features
- Prefix SDL2-specific code with appropriate guards

### Architecture Patterns

- **Platform Abstraction**: SDL2 provides cross-platform layer
- **Modular Build**: Platform-specific code isolated in CMake conditionals
- **Plugin System**: Disabled on embedded platforms (Vita, Switch)
- **Threading**: SDL threads preferred on embedded platforms; std::thread elsewhere
- **Async Loading**: Enabled by default except on Emscripten

### Testing Strategy

- Manual testing on target platforms
- CI/CD builds for all supported platforms
- Use Docker containers for embedded platform builds (devkitpro, vitasdk)

### Git Workflow

- Standard GitHub flow
- Feature branches merged to main
- CI builds on all commits
- Automated artifact generation for releases

## Domain Context

- **Visual Novel Engine**: Designed to run Japanese visual novel games
- **Kirikiri Z Compatibility**: Maintains compatibility with Kirikiri Z scripts (TJS)
- **Commercial Games**: Not supported for unmodified commercial titles; use Wine or Kirikiroid2 instead
- **Data Format**: Games typically packaged as .xp3 archives
- **Case Sensitivity**: Optional case-insensitive filesystem layer for cross-platform compatibility

## Important Constraints

- **No GPL Dependencies**: All components use MIT or compatible licenses
- **Embedded Platforms**: Limited RAM and storage on Vita/Switch
- **Web Platform**: Special handling for Emscripten (memory limits, threading model)
- **iOS Restrictions**: No JIT, code signing requirements
- **Android**: Requires custom project structure for APK packaging

## External Dependencies

- **SDL2**: Core platform abstraction (version varies by platform)
- **FAudio**: XAudio2 compatibility layer
- **libpng, libjpeg, libwebp**: Image formats
- **Opus**: Audio codec
- **FreeType**: Font rendering
- **zlib**: Compression
- **SIMDe**: SIMD portability for ARM/web platforms

## Platform-Specific Notes

### Nintendo Switch

- **Toolchain**: devkitPro/devkitA64
- **Package Format**: NRO (homebrew)
- **Filesystem**: romfs for embedded data, sdmc:/ for SD card
- **Initialization**: Requires romfsInit, socketInitializeDefault, nxlinkStdio
- **Display**: 1280x720 (handheld) or 1920x1080 (docked)
- **Path Handling**: Colon conflicts resolved with "file://?/" prefix

### PS Vita

- **Toolchain**: vitasdk
- **Package Format**: VPK
- **Filesystem**: Similar path handling to Switch
- **Display**: 960x544 fixed resolution

### Emscripten (Web)

- **Build Type**: MinSizeRel (optimize for size)
- **Threading**: Optional, requires SharedArrayBuffer
- **Memory**: Initial 128MB, can grow
- **Filesystem**: IDBFS for persistence
- **Module Export**: "instantiate_krkrsdl2_module"

### iOS

- **Deployment Target**: iOS 10.0+
- **Code Signing**: Optional (configurable)
- **App Bundle**: Xcode project generation
- **Case Sensitivity**: Disabled (directory listing issues)

### Android

- **Build System**: Gradle via android-project/
- **Target SDK**: Configured in gradle files
- **APK Output**: Includes SDL2, game data embedded or loaded externally

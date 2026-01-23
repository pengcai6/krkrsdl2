# Change: Document Nintendo Switch Platform Support

## Why
The Nintendo Switch port is already implemented in the codebase but lacks formal specification documentation. This change documents the existing Switch platform support to maintain consistency with the OpenSpec workflow and provide clear requirements for future maintenance.

## What Changes
- Document Nintendo Switch as a supported platform
- Specify Switch-specific initialization requirements (romfs, networking, nxlink)
- Document filesystem path handling for Switch
- Specify build configuration and toolchain requirements
- Document NRO packaging process

## Impact
- Affected specs: platform-support (new capability)
- Affected code:
  - `CMakeLists.txt` (lines 71-81, 130-137, 536-544, 723-747)
  - `src/core/sdl2/SDLApplication.cpp` (lines 44-46, 52-54, 3011-3015)
  - `src/core/base/sdl2/StorageImpl.cpp` (lines 508-516, 583-593)
  - `src/resources/nswitch/icon.jpg`
  - `.github/workflows/ci.yml` (Switch build configuration)

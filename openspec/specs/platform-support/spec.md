# platform-support Specification

## Purpose
TBD - created by archiving change document-switch-port. Update Purpose after archive.
## Requirements
### Requirement: Nintendo Switch Platform Support
The system SHALL support Nintendo Switch as a target platform, providing native execution through homebrew (NRO format).

#### Scenario: Switch platform detection
- **WHEN** compiling with devkitPro Switch toolchain
- **THEN** NINTENDO_SWITCH and __SWITCH__ macros SHALL be defined
- **AND** Switch-specific code paths SHALL be enabled

#### Scenario: Switch build configuration
- **WHEN** building for Switch platform
- **THEN** CMake SHALL use CMAKE_TOOLCHAIN_FILE pointing to ${DEVKITPRO}/cmake/Switch.cmake
- **AND** SDL2 SHALL be linked via pkg-config
- **AND** external plugins SHALL be disabled (not supported)
- **AND** SDL threads SHALL be enabled (required)

#### Scenario: NRO package generation
- **WHEN** Switch executable is built
- **THEN** build system SHALL generate .nacp metadata file with app name, author, and version
- **AND** build system SHALL convert ELF to NRO format using elf2nro
- **AND** NRO SHALL embed icon from src/resources/nswitch/icon.jpg
- **AND** NRO SHALL include romfs directory for game data

### Requirement: Switch Platform Initialization
The system SHALL initialize Switch-specific subsystems at startup.

#### Scenario: RomFS initialization
- **WHEN** application starts on Switch
- **THEN** romfsInit() SHALL be called to mount romfs filesystem
- **AND** embedded game data SHALL be accessible via romfs paths

#### Scenario: Network initialization
- **WHEN** application starts on Switch
- **THEN** socketInitializeDefault() SHALL be called to enable networking
- **AND** nxlinkStdio() SHALL be called to enable debug output over network

#### Scenario: Standard I/O redirection
- **WHEN** nxlink is initialized
- **THEN** stdout and stderr SHALL be redirected to nxlink for debugging
- **AND** debug output SHALL be accessible via nxlink client on development PC

### Requirement: Switch Filesystem Path Handling
The system SHALL handle Switch filesystem path conventions correctly.

#### Scenario: Colon character conflict resolution
- **WHEN** a path contains colon character (not part of "file:" prefix)
- **THEN** path SHALL be prefixed with "file://?/" to avoid conflicts
- **AND** file operations SHALL work correctly with the transformed path

#### Scenario: Temporary directory configuration
- **WHEN** system requires temporary file storage on Switch
- **THEN** temporary directory SHALL be set to "sdmc:/tmp/"
- **AND** temporary files SHALL be created in SD card tmp directory

#### Scenario: SD card path access
- **WHEN** accessing Switch SD card
- **THEN** paths SHALL use "sdmc:/" prefix
- **AND** file operations SHALL correctly read/write to SD card

### Requirement: Switch Build Dependencies
The system SHALL require specific toolchain and dependencies for Switch builds.

#### Scenario: DevkitPro toolchain requirement
- **WHEN** building for Switch
- **THEN** devkitPro SDK SHALL be installed
- **AND** DEVKITPRO environment variable SHALL be set
- **AND** devkitA64 toolchain SHALL be available

#### Scenario: SDL2 Switch library requirement
- **WHEN** building for Switch
- **THEN** SDL2 Switch port SHALL be installed via devkitPro package manager
- **AND** pkg-config SHALL locate SDL2 library correctly

#### Scenario: Build tools requirement
- **WHEN** packaging Switch application
- **THEN** nacptool SHALL be available in ${DEVKITPRO}/tools/bin/
- **AND** elf2nro SHALL be available in ${DEVKITPRO}/tools/bin/

### Requirement: Switch Resource Embedding
The system SHALL embed game data and resources in the NRO package.

#### Scenario: Game data embedding via romfs
- **WHEN** EMBED_DATA_PATH is specified during build
- **THEN** build system SHALL create romfs directory in build output
- **AND** build system SHALL symlink data file/directory into romfs
- **AND** elf2nro SHALL embed romfs into NRO package

#### Scenario: Icon resource embedding
- **WHEN** generating NRO package
- **THEN** icon.jpg from src/resources/nswitch/ SHALL be embedded
- **AND** icon SHALL be displayed in Switch homebrew menu
- **AND** icon SHALL be 256x256 JPEG format

### Requirement: Switch Window and Display Handling
The system SHALL handle Switch display characteristics correctly.

#### Scenario: Window size handling
- **WHEN** creating window on Switch
- **THEN** window size SHALL match layer size (handheld: 1280x720, docked: 1920x1080)
- **AND** KRKRSDL2_WINDOW_SIZE_IS_LAYER_SIZE macro SHALL be defined
- **AND** window SHALL adapt to handheld/docked mode changes

#### Scenario: Touch input support
- **WHEN** user touches Switch screen in handheld mode
- **THEN** touch events SHALL be processed as mouse input
- **AND** touch coordinates SHALL map to window coordinates correctly

### Requirement: Switch CI/CD Integration
The system SHALL support automated Switch builds in continuous integration.

#### Scenario: GitHub Actions Switch build
- **WHEN** CI pipeline runs Switch build
- **THEN** devkitpro/devkita64 Docker container SHALL be used
- **AND** build SHALL configure with Switch toolchain file
- **AND** build SHALL output .nro artifact
- **AND** artifact SHALL be archived for release

#### Scenario: Switch build artifact packaging
- **WHEN** Switch build completes successfully
- **THEN** krkrsdl2.nro SHALL be generated in build directory
- **AND** NRO file SHALL be copied to release artifacts
- **AND** NRO SHALL be deployable to Switch SD card


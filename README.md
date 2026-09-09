# game-launcher
A game launcher for the Game Development Club @ WSU

## Getting Started

1. Clone the repository and change to the launchers directory: `cd game-launcher/launcher` or `cd launcher` 
2. Ensure `CMake` is installed and up to date. Installation binaries can be found [here](https://cmake.org/download/)
3. Install `aqtinstall` using the following pip command: `pip install aqtinstall`

## Build

From the `launcher/` directory:

**Windows:**
```powershell
cmake -B build -S .
cmake --build build --config Release
```

**macOS / Linux:**
```bash
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

## Run
From the `launcher/` directory:

**Windows:**
```powershell
.\build\Release\WSU-Game-Launcher.exe
```
 
**macOS / Linux:**
```bash
./build/WSU-Game-Launcher
```

## Clean Rebuild
 
If something's broken or stale, don't try to fix `build/` by hand — delete and reconfigure:
 
```bash
# Windows
Remove-Item -Recurse -Force build
# macOS/Linux
rm -rf build
 
cmake -B build -S .   # add -DCMAKE_BUILD_TYPE=Release on macOS/Linux
```
 
`third_party/Qt` doesn't need to be deleted unless you're changing Qt version — it's independent of build/target changes.
 
## Branch Naming Convention
 
```
FirstName/feature-name
```
 
Examples:
```
Anrew/setup
Amrew/fix-launcher-crash
```
 
## Notes
 
- `build/` and `third_party/` are gitignored — never commit either, both are fully regenerable.
- If `cmake` isn't recognized after install on Windows, it's almost always a PATH issue — reopen your terminal after install, or re-run the installer and check the PATH option.

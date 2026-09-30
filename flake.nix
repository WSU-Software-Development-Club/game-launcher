{
    description = "c/c++ and qt develeopment environment";
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    outputs = { self, ... } @ inputs:
    let
        supportedSystems = [
            "x86_64-linux"
            "aarch64-linux"
            "aarch64-darwin"
        ];
        forEachSupportedSystem =
        f: inputs.nixpkgs.lib.genAttrs supportedSystems (
            system: f {
                inherit system;
                pkgs = import inputs.nixpkgs { inherit system; };
            }
        );
    in {
        devShells = forEachSupportedSystem (
            { pkgs, system }: {
                default = pkgs.mkShell.override {
                    # Override stdenv in order to change compiler:
                    # stdenv = pkgs.clangStdenv;
                } {
                    packages = with pkgs; [
                        clang-tools
                        cmake
                        codespell
                        cppcheck
                        ninja

                        qt6.qttools
                        qt6.qtbase
                        qt6.qtdeclarative
                    ] ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [ gdb ];
                    shellHook = ''
                        unset QML2_IMPORT_PATH
                        unset QT_PLUGIN_PATH
                    '';
                };
            }
        );
    };
}

{
  description = "Ind-E's nixCats";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects/main";
      flake = false;
    };
    plugins-sqls-nvim = {
      url = "github:nanotee/sqls.nvim/main";
      flake = false;
    };
    plugins-chezmoi-nvim = {
      url = "github:xvzc/chezmoi.nvim/main";
      flake = false;
    };

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

    # see :help nixCats.flake.inputs
    # If you wish to define a custom build step not handled by nixpkgs,
    # then you should name it in a different format, and deal with that in the
    # overlay defined for custom builds in the overlays directory.
    # for specific tags, branches and commits, see:
    # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html#examples
  };

  # see :help nixCats.flake.outputs
  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = self;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      # the following extra_pkg_config contains any values
      # which you want to pass to the config set of nixpkgs
      # import nixpkgs { config = extra_pkg_config; inherit system; }
      # will not apply to module imports as that will have your system values
      extra_pkg_config = {
        allowUnfree = true;
      };

      # see :help nixCats.flake.outputs.overlays
      dependencyOverlays =
        # (import ./overlays inputs) ++
        [
          # This overlay grabs all the inputs named in the format
          # `plugins-<pluginName>`
          # Once we add this overlay to our nixpkgs, we are able to
          # use `pkgs.neovimPlugins`, which is a set of our plugins.
          (utils.standardPluginOverlay inputs)
          # add any other flake overlays here.

          # when other people mess up their overlays by wrapping them with system,
          # you may instead call this function on their overlay.
          # it will check if it has the system in the set, and if so return the desired overlay
          # (utils.fixSystemizedOverlay inputs.codeium.overlays
          #   (system: inputs.codeium.overlays.${system}.default)
          # )
        ];

      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          mkPlugin,
          ...
        }@packageDef:
        {
          lspsAndRuntimeDeps = {
            minimal = with pkgs; [
              lua-language-server # lua ls
              stylua # lua fmt

              universal-ctags
              tree-sitter

              nixd # nix ls
              nixfmt # nix fmt
              statix # nix lint
              bash-language-server # bash ls
              shellcheck # bash lint
              shfmt # bash fmt
              taplo # toml ls
              vscode-langservers-extracted # css + json ls
              yaml-language-server # yaml ls
              yamllint # yaml lint
            ];
            full = with pkgs; [
              jdt-language-server # java ls
              jdk8
              clang-tools # c ls
              ty # python type checker
              ruff # python linter
              marksman # markdown ls
              typescript-language-server # typescript/javasrcipt ls
              prettier # ts fmt
              tinymist # typst ls
              websocat # for typst preview
              typstyle # typst fmt
              lemminx # xml ls
              glsl_analyzer # glsl ls
              sqls # sql ls
              gopls # go ls
              csharp-ls # csharp ls
              netcoredbg # chsarp dbg
              csharpier # csharp fmt
            ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = {
            core = with pkgs.vimPlugins; [
              vscode-nvim
              nvim-web-devicons
              lze
            ];
            cliphist = with pkgs.vimPlugins; [
              snacks-nvim
            ];
            minimal = with pkgs.vimPlugins; [
              lzextras
              vim-textobj-entire
              bufferline-nvim
              nvim-colorizer-lua
              nvim-cmp
            ];
            full = with pkgs.vimPlugins; [
              pkgs.neovimPlugins.sqls-nvim
            ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          optionalPlugins = {
            minimal = with pkgs.vimPlugins; [
              auto-save-nvim
              conform-nvim
              gitsigns-nvim
              lualine-nvim
              mini-ai
              mini-pairs
              mini-surround
              mini-trailspace
              mini-splitjoin
              lazydev-nvim
              nvim-lint
              nvim-lspconfig
              nvim-treesitter-textobjects
              pkgs.neovimPlugins.treesitter-textobjects
              nvim-treesitter.withAllGrammars
              quick-scope
              snacks-nvim
              which-key-nvim
              hop-nvim
              vim-sleuth
              ts-comments-nvim

              cmp-cmdline
              blink-cmp
              blink-compat
              colorful-menu-nvim

              pkgs.neovimPlugins.chezmoi-nvim
              plenary-nvim
            ];
            full = with pkgs.vimPlugins; [
              crates-nvim

              mini-align

              diffview-nvim
              markdown-preview-nvim
              nvim-dap
              nvim-dap-ui
              nvim-nio
              nvim-dap-virtual-text
              nvim-jdtls
              typst-preview-nvim
              vim-slime

              quarto-nvim
              otter-nvim
              image-nvim
              molten-nvim

              easy-dotnet-nvim
              csvview-nvim
            ];
          };

          # shared libraries to be added to LD_LIBRARY_PATH
          sharedLibraries = {
          };

          # run time environment variables:
          environmentVariables = {
            full = {
              DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
            };
          };

          # If you know what these are, you can provide custom ones by category here.
          # If you dont, check this link out:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
          extraWrapperArgs = {
          };

          # lists of the functions you would have passed to
          # python.withPackages or lua.withPackages
          # do not forget to set `hosts.python3.enable` in package settings

          # get the path to this python environment
          # in your lua config via vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          python3.libraries = {
            full = with pkgs.python3Packages; [
              pynvim
              jupyter-client
              ipykernel
              numpy
              pandas
              matplotlib
              seaborn
              scikit-learn
              opencv-python
            ];
          };

          # populates $LUA_PATH and $LUA_CPATH
          extraLuaPackages = {
          };

        };

      # And then build a package with specific categories from above here:
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions =
        let
          commonSettings = {
            suffix-path = true;
            suffix-LD = true;
            hosts.python3.enable = true;
          };
          categories = {
            full = true;
            minimal = true;
            core = true;
          };
          mkExtra = pkgs: {
            jdk8-path = "${pkgs.jdk8}";
          };
        in
        {
          nvim =
            {
              name,
              pkgs,
              ...
            }:
            {
              settings = commonSettings // {
                wrapRc = false;
                aliases = [
                  "v"
                  "vim"
                ];
              };
              inherit categories;
              extra = mkExtra pkgs;
            };

          nvim-wrapped =
            {
              name,
              pkgs,
              ...
            }:
            {
              settings = commonSettings // {
                wrapRc = true;
              };
              inherit categories;
              extra = mkExtra pkgs;
            };

          nvim-cliphist =
            { name, pkgs, ... }:
            {
              settings = {
                suffix-path = true;
                suffix-LD = true;

                wrapRc = true;
              };
              categories = {
                core = true;
                cliphist = true;
              };
            };

          nvim-minimal =
            { name, pkgs, ... }:
            {
              settings = {
                suffix-path = true;
                suffix-LD = true;

                wrapRc = true;
              };
              categories = {
                minimal = true;
                core = true;
              };
            };
        };
      defaultPackageName = "nvim-minimal";
    in
    # see :help nixCats.flake.outputs.exports
    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        # this is just for using utils such as pkgs.mkShell
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # these outputs will be wrapped with ${system} by utils.eachSystem
        # this will make a package out of each of the packageDefinitions defined above
        # and set the default package to the one passed in here.
        packages = utils.mkAllWithDefault defaultPackage;

        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = "";
          };
        };
      }
    )
    // (
      let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {
        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;

        inherit utils nixosModule;
        inherit (utils) templates;
      }
    );
}

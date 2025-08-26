{
  description = "Ind-E's nixCats";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

    # see :help nixCats.flake.inputs
    # If you want your plugin to be loaded by the standard overlay,
    # i.e. if it wasnt on nixpkgs, but doesnt have an extra build step.
    # Then you should name it "plugins-something"
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
          # to define and use a new category, simply add a new list to a set here,
          # and later, you will include categoryname = true; in the set you
          # provide when you build the package using this builder function.
          # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

          # lspsAndRuntimeDeps:
          # this section is for dependencies that should be available
          # at RUN TIME for plugins. Will be available to PATH within neovim terminal
          # this includes LSPs
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              nixd # nix ls
              nixfmt-rfc-style # nix fmt
              statix # nix lint
              jdt-language-server # java ls
              jdk8
              clang-tools # c ls
              basedpyright # python ls
              # rust-analyzer <- installed with dev shell
              # rustfmt # rust formatter
              marksman # markdown ls
              typescript-language-server # typescript/javasrcipt ls
              bash-language-server # bash ls
              shellcheck # bash lint
              shfmt # bash fmt
              vscode-langservers-extracted # css + json ls
              lua-language-server # lua ls
              stylua # lua fmt
              universal-ctags
              taplo # toml ls
              tinymist # typst ls
              websocat # for typst preview
              typstyle # typst fmt
              kotlin-language-server # kotlin ls
              lemminx # xml ls

              air # R ls

            ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = {
            general = with pkgs.vimPlugins; [
              vscode-nvim
              vim-textobj-entire
              lze
              lzextras
              nvim-web-devicons
              # yazi-nvim
              mini-files
              bufferline-nvim
              nvim-colorizer-lua
              nvim-cmp
              jupytext-nvim
            ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          optionalPlugins = {
            general =
              with pkgs.vimPlugins;
              [
                yuck-vim
                crates-nvim

                auto-save-nvim
                conform-nvim
                diffview-nvim
                # git-conflict-nvim
                # gitlinker-nvim
                gitsigns-nvim
                lualine-nvim
                markdown-preview-nvim
                markview-nvim
                mini-ai
                mini-align
                mini-pairs
                mini-surround
                mini-trailspace
                mini-splitjoin
                nvim-dap
                nvim-dap-ui
                nvim-nio
                nvim-dap-virtual-text
                nvim-jdtls
                nvim-lint
                nvim-lspconfig
                lazydev-nvim
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                quick-scope
                telescope-nvim
                telescope-ui-select-nvim
                # vim-abolish
                vim-fugitive
                # vim-signature
                vim-sleuth
                which-key-nvim
                # wiki-vim
                vim-slime
                hlchunk-nvim
                plenary-nvim
                typst-preview-nvim

                cmp-cmdline
                blink-cmp
                blink-compat
                colorful-menu-nvim

                quarto-nvim
                otter-nvim
                image-nvim
                molten-nvim
              ]
              ++ (with pkgs.neovimPlugins; [
                # tiny-code-action-nvim
              ]);
          };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            # general = with pkgs; [
            # ];
          };

          # run time environment variables:
          environmentVariables = {
            general = {
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
          # in your lua config via
          # vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          python3.libraries = {
            general = with pkgs.python3Packages; [
              pynvim
              jupyter-client
              # jupyter
              # ipykernel
              # matplotlib
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
            wrapRc = false;
            hosts.python3.enable = true;
          };
          categories = {
            general = true;
          };
          mkExtra = pkgs: {
            jdk8-path = "${pkgs.jdk8}";
          };
        in
        {
          nixcats =
            {
              name,
              pkgs,
              ...
            }:
            {
              settings = commonSettings // {
                aliases = [
                  "vim"
                  "nvim"
                ];
              };
              inherit categories;
              extra = mkExtra pkgs;
            };

          purecats =
            {
              name,
              pkgs,
              ...
            }:
            {
              settings = commonSettings;
              inherit categories;
              extra = mkExtra pkgs;
            };
        };
      # In this section, the main thing you will need to do is change the default package name
      # to the name of the packageDefinitions entry you wish to use as the default.
      defaultPackageName = "nixcats";
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
            shellHook = '''';
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
        homeModule = utils.mkHomeModules {
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
        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );
}

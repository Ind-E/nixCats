self: super:

let
  tiny-code-action = super.vimUtils.buildVimPlugin {
    pname = "tiny-code-action.nvim";
    version = "1.0";
    src = super.fetchFromGitHub {
      owner = "rachartier";
      repo = "tiny-code-action.nvim";
      rev = "c0af6738fe6c937324ad1bbae24e830457a17392";
      hash = "sha256-Zcp0Bj50Mw7ZfwpSZ0xI5TJxDTDwL2PPkj+D1ridYKA=";
    };
  };
in
{
  vimPlugins = super.vimPlugins // {
    inherit tiny-code-action;
  };
}

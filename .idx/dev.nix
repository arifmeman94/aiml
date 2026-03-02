
# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-25.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages.
  # We are installing python and common data science libraries.
  # It's best practice to manage these with Nix to ensure a reproducible environment.
  packages = [
    pkgs.python313Full
    pkgs.python313Packages.pip # pip is still useful for other packages
    pkgs.python313Packages.scikit-learn
    pkgs.python313Packages.pandas
    pkgs.python313Packages.numpy
    pkgs.python313Packages.jupyter
    pkgs.tenv
    pkgs.terraform
    pkgs.xvfb-run
  ];

  # Sets environment variables in the workspace
  env = {
    TENV_AUTO_INSTALL = "true";
  };

  idx = {
    # Search for extensions on https://open-vsx.org/
    extensions = [
      "ms-python.python"
      "google.gemini-cli-vscode-ide-companion"
    ];

    # workspace lifecycle hooks.
    # We removed the `onCreate` hook that was running `pip install`
    # because the python packages are now managed by Nix.
    workspace = {};
  };
}

{ ... }:

{
  # Neovim to replace vi and vim for better experience
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    waylandSupport = true;
  };

  # Set Neovim as the default text editor in MIME
  xdg.mimeApps.defaultApplications = {
    "text/*" = "nvim.desktop";
    "text/plain" = "nvim.desktop";
    "application/x-shellscript" = "nvim.desktop";
  };
}

{pkgs}: {
  deps = [
    pkgs.emacsPackages.crontab-mode
    pkgs.haskellPackages.cryptoconditions
    pkgs.cronutils
    pkgs.haskellPackages.cron
  ];
}

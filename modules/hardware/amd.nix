{ pkgs, ... }:

{
  hardware.cpu.amd.ryzen-smu.enable = true;
  environment.systemPackages = with pkgs; [
    ryzenadj
  ];

  systemd.services.ryzenadj = {
    description = "Apply RyzenAdj power limits";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.ryzenadj}/bin/ryzenadj --stapm-limit=45000 --fast-limit=55000 --slow-limit=45000";
    };
  };

  systemd.services.ryzenadj-resume = {
    description = "Reapply RyzenAdj limits after resume";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ryzenadj}/bin/ryzenadj --stapm-limit=45000 --fast-limit=55000 --slow-limit=45000";
    };
  };
}

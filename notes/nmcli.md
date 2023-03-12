```shell
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli
br-db663114fc35: connected (externally) to br-db663114fc35
        "br-db663114fc35"
        bridge, 02:42:EF:3F:02:46, sw, mtu 1500
        inet4 172.18.0.1/16
        route4 172.18.0.0/16 metric 0

docker0: connected (externally) to docker0
        "docker0"
        bridge, 02:42:C1:E5:5F:58, sw, mtu 1500
        inet4 172.17.0.1/16
        route4 172.17.0.0/16 metric 0

wlp1s0: disconnected
        "Realtek RTL8822BE 802.11a/b/g/n/ac"
        wifi (rtw_8822be), 46:B8:F3:54:EA:4A, hw, mtu 1500

lo: unmanaged
        "lo"
        loopback (unknown), 00:00:00:00:00:00, sw, mtu 65536

Use "nmcli device show" to get complete information about known devices and
"nmcli connection show" to get an overview on active connection profiles.

Consult nmcli(1) and nmcli-examples(7) manual pages for complete usage details.
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli connection show
NAME             UUID                                  TYPE    DEVICE
br-db663114fc35  a115f40a-2faf-4cec-ad65-43e5d184c549  bridge  br-db663114fc35
docker0          f8a07393-a801-4f22-9bc3-15ac1d58bc11  bridge  docker0
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli connection up wlp1s0
Error: unknown connection 'wlp1s0'.
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli device wifi list                                                                                                                                           10 ↵
IN-USE  BSSID              SSID            MODE   CHAN  RATE        SIGNAL  BARS  SECURITY
        E0:CC:7A:81:62:CB  hw_manage_62c0  Infra  1     195 Mbit/s  100     ▂▄▆█  WPA2
        54:BA:D6:AE:7F:19  --              Infra  6     270 Mbit/s  100     ▂▄▆█  WPA2
        54:BA:D6:AE:7F:18  408GreatWall    Infra  6     270 Mbit/s  100     ▂▄▆█  WPA2
        B6:F7:A1:44:08:5C  trdthg-lg       Infra  9     130 Mbit/s  100     ▂▄▆█  WPA2
        88:25:93:2C:31:7B  408             Infra  11    405 Mbit/s  100     ▂▄▆█  WPA1 WPA2
        54:BA:D6:FE:7F:1C  --              Infra  157   270 Mbit/s  100     ▂▄▆█  WPA2
        54:BA:D6:AE:7F:1C  408GreatWall    Infra  157   270 Mbit/s  99      ▂▄▆█  WPA2
        88:25:93:2C:31:7C  408_5GHz        Infra  157   135 Mbit/s  89      ▂▄▆█  WPA1 WPA2
        08:10:79:FA:95:2C  405s            Infra  7     270 Mbit/s  59      ▂▄▆_  WPA2
        46:06:A7:F0:4D:B4  --              Infra  1     540 Mbit/s  52      ▂▄__  WPA1 WPA2
        3C:06:A7:F0:4D:B6  TP-LINK_4DB4    Infra  40    540 Mbit/s  35      ▂▄__  WPA1 WPA2
        42:06:A7:F0:4D:B6  --              Infra  40    540 Mbit/s  35      ▂▄__  WPA1 WPA2
        34:96:72:6A:90:FE  yiqixuexi       Infra  1     270 Mbit/s  30      ▂___  WPA1 WPA2
        3C:06:A7:F0:4D:B4  TP-LINK_4DB4    Infra  1     540 Mbit/s  29      ▂___  WPA1 WPA2
        68:A0:3E:B7:4D:38  C305            Infra  1     130 Mbit/s  24      ▂___  WPA2
        E0:CC:7A:81:63:92  eduroam         Infra  44    540 Mbit/s  22      ▂___  WPA1 WPA2 802.1X
        E0:CC:7A:81:63:91  IOT             Infra  44    540 Mbit/s  22      ▂___  WPA2
        24:69:68:FF:AF:24  b403            Infra  1     405 Mbit/s  19      ▂___  WPA1 WPA2
        9C:A6:15:98:D1:6D  yuan405         Infra  1     405 Mbit/s  19      ▂___  WPA1 WPA2
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli device wifi connect trdthg-lg 12345678
Error: invalid extra argument '12345678'.
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli device wifi connect trdthg-lg password 12345678                                                                                                             2 ↵
Error: Failed to add/activate new connection: Insufficient privileges
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ sudo nmcli device wifi connect trdthg-lg password 12345678                                                                                                        4 ↵
[sudo] password for trdthg:
Device 'wlp1s0' successfully activated with 'cf327a16-3d39-45b5-a2a3-4bc7d9592c59'.
╭─trdthg@nixos  ~/nixos-config ‹node-›  ‹› (main*)
╰─$ nmcli device status
DEVICE           TYPE      STATE                   CONNECTION
wlp1s0           wifi      connected               trdthg-lg
br-db663114fc35  bridge    connected (externally)  br-db663114fc35
docker0          bridge    connected (externally)  docker0
lo               loopback  unmanaged               --
```

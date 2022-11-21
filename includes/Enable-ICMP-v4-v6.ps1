# Allow ICMP (ping) through Windows Firewall IPv4 and IPv6
New-NetFirewallRule -Name Allow_Ping_ICMPv4 -DisplayName "Allow Ping ICMPv4" -Description "Packet Internet Groper ICMPv4" -Protocol ICMPv4 -IcmpType 8 -Enabled True -Profile Any -Action Allow
New-NetFirewallRule -Name Allow_Ping_ICMPv6 -DisplayName "Allow Ping ICMPv6" -Description "Packet Internet Groper ICMPv6" -Protocol ICMPv6 -IcmpType 8 -Enabled True -Profile Any -Action Allow
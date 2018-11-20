
/interface wireless
set [ find default-name=wlan1 ] band=5ghz-a/n disabled=no frequency=auto \
    frequency-mode=superchannel nv2-preshared-key=sv2017 nv2-security=enabled \
    radio-name=GT05WI000119-CPE scan-list=5100-5900 ssid=BS_Oeste_SV \
    wireless-protocol=nv2-nstreme-802.11
/interface wireless nstreme
set wlan1 enable-nstreme=yes framer-policy=dynamic-size
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.2.2-192.168.2.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether1 name=dhcp1
/interface pppoe-client
add ac-name=RB_SAN_VICENTE disabled=no interface=wlan1 name=internet \
    password=GT05WI000119_2018 profile=default-encryption service-name=\
    internet_sv user=GT05WI000119
/ip address
add address=192.168.2.1/24 interface=ether1 network=192.168.2.0
/ip dhcp-server network
add address=192.168.2.0/24 dns-server=192.168.2.1 gateway=192.168.2.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip firewall filter
add action=drop chain=input port=80,23,21 protocol=tcp
/ip firewall nat
add action=masquerade chain=srcnat src-address=192.168.2.0/24
/ip route
add distance=1 gateway=10.17.1.1
/system clock
set time-zone-name=America/Guatemala
/system identity
set name="GT05WI000119 - CPE"

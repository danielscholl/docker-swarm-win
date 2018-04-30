# Configure Firewall
netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=TCP localport=2377
netsh advfirewall firewall add rule name="Open Port 7946" dir=in action=allow protocol=TCP localport=7946
netsh advfirewall firewall add rule name="Open Port 7946" dir=in action=allow protocol=UDP localport=7946
netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=UDP localport=4789

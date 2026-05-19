cat ~/.config/static/ascii_hello_world                                                     
echo "UTC-Date: $(date)"
echo "Status: $(cat /sys/class/power_supply/BAT0/status)"
echo "Capacity: $(cat /sys/class/power_supply/BAT0/capacity)%"

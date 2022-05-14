# Setup 2GB of vbswap
echo 2147483648 > /sys/devices/virtual/block/vbswap0/disksize
echo 100 > /proc/sys/vm/swappiness
mkswap /dev/block/vbswap0
swapon /dev/block/vbswap0

# Enable SIGKILL memory reap
echo 1 > /proc/sys/vm/reap_mem_on_sigkill

# Zygote Preforking (override)
setprop persist.device_config.runtime_native.usap_pool_enabled true

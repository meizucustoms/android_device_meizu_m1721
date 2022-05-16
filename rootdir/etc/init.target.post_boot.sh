#!/vendor/bin/sh
#
# Copyright (C) 2022 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Setup 1GB of vbswap
echo 1073741824 > /sys/devices/virtual/block/vbswap0/disksize
echo 40 > /proc/sys/vm/swappiness
mkswap /dev/block/vbswap0
swapon /dev/block/vbswap0

# Enable SIGKILL memory reap
echo 1 > /proc/sys/vm/reap_mem_on_sigkill

# Zygote Preforking (override)
setprop persist.device_config.runtime_native.usap_pool_enabled true

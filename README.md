# vm_display
Bash script to adjust and correct the display resolution of stubborn VMs.

Can be used to create the new resolution modes that don't exist, or change the display to a resolution that currently exists.

This script utilizes `xrandr` to make a newmode for your resolution and refresh rate, then will use that newmode as your output.

This script also utilizes `/etc/X11/xorg.conf.d/10-monitor.conf` and `$HOME/.profile` to make changes persistent.

> Note: You will need to be root or have `sudo` privileges for persistence, due to persistent `xrandr` modes needing to be added to `/etc`.

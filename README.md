# multipass-cloud-init
Spike out Multipass with Cloud-Init

## Experiments:

1. Multipass Configuration
2. Workaround for [DNS Nameservers Issue](https://linuxize.com/post/how-to-set-dns-nameservers-on-ubuntu-18-04/)
3. Workaround for [apt upgrade without a grub config prompt Issue](https://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt)
4. Bash [Menu](https://github.com/lucaswhitaker22/bash_menus/blob/master/bash_menus/demo.sh)
5. Display Time for Provisioning through Function
6. Upgrade Packages

## Geting Started:

In Terminal (Menu Driven)

```SHELL
$ ./multipass.bash
```

Multipass Manager  

            1. Provision
            2. ViewLog
            3. Shell
            4. Destroy

Enter your choice [1-4]

In Terminal (Command Driven)

```SHELL
$ source instance.env
$ source src/vm.bash

```

### References:

    1. https://linuxize.com/post/how-to-set-dns-nameservers-on-ubuntu-18-04/
    2. https://discourse.ubuntu.com/t/troubleshooting-networking-on-macos/12901
    3. https://github.com/lucaswhitaker22/bash_menus/blob/master/bash_menus/demo.sh
    4. https://linuxize.com/post/how-to-set-dns-nameservers-on-ubuntu-18-04/
    5. https://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt

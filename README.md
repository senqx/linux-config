# Archlinux + i3 : (Installing and configurating)

## Step 1. Install Archlinux
Archlinux can be installed (maybe not from first attempt) by following [Archlinux installation guide](https://wiki.archlinux.org/title/installation_guide)

> **Note** Before you exit live boot, make sure to install **NetworkManager**

## Step 2. Configure internet connection in newly installed OS
If you forgot to install **NetworkManager**, don't worry, it is still possible to configure internet, but, of course, with more steps.
+ You need to find what **ip address** and **mask** uses your local network.
+ You need to know, which **local ip address** is free, to set it for your own device.

> **For example:**
**192.168.0.3** -> May be busy, if you have other devices connected to local network.

### You can use one of the following options, for setup

1. **Manual (Most steps)**

    We need to figure out our network settings

    If you have a working device that is connected to same network, just look at its network settings.
    You will find there all the info you need.
    After which, just ping to desired ip. If you get response, then that ip is busy, if no - it's free.

    > **Note** There is an option to scan your network with other device to get free ips,
    but if you are able to do it, you surely don't need a guide to configure network.

    **For example** 
    + We found that our network is set as **192.168.0.x/24**
    + We also found that getway is **192.168.0.1**
    + And we found that **192.168.0.11** is free

    First we need to get our network interface name.
    Type the following command

    ```console
    archlinux@user:~$ ip l
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: enp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
        link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    ```

    Pay attention to interface, that has pattern: **enpXsY**
    In our case it is **enp6s0**

    > **Note** Instead of **xx:xx:xx:xx:xx:xx** you will see your MAC address

    You can see word **DOWN** in the same line, which means, that ntework interface is down. We need to enable it.
    We can do it by following command
    _ip link set dev <interface> up_
    In our case, it is
    ```console
    archlinux@root:~# ip link set dev enp6s0 up
    ```
    Now, setup your ip using following command
    _ip a add <ip/mask_length> dev <interface>_
    In our case, it is
    ```console
    archlinux@root:~# ip a add 192.168.0.11/24 dev enp6s0
    ```
    Setup your default gateway using this command
    _ip r add default via <gateway> dev <interface>_
    In our case, it is
    ```console
    archlinux@root:~# ip r add default via 192.168.0.1 dev enp6s0
    ```

    Now make sure we have internet
    ```console
    archlinux@root:~# ping 8.8.8.8
    PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
    64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=31.8 ms
    64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=30.2 ms
    64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=32.9 ms
    64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=31.5 ms
    64 bytes from 8.8.8.8: icmp_seq=5 ttl=117 time=31.9 ms
    ```
    Good!

    > **Note** If you don't see this output, then read previos part again.
    > If you are sure that you did everything perfectly, google your specific problem.

    But still, it is not enough...
    Yes, we can ping to **8.8.8.8**
    but if we try to ping **archlinux.org**, we will get an error.
    It is because, we have not configured DNS

    Edit your /etc/resolv.conf file.
    Add following lines
    _hostname 8.8.8.8_
    _hostname 1.1.1.1_

    > **Note** Yes, everything will work if you add just one of the hostnames,
    > 2 lines are just in case, and it is the recommended way to do it.

    If you have text editor installed, edit the file using it.
    If no, you can use this command
    ```console
    archlinux@root:~# echo "nameserver 8.8.8.8" >> /etc/resolv.conf
    archlinux@root:~# echo "nameserver 1.1.1.1" >> /etc/resolv.conf
    ```

    > **Note** We recommend using **vim** for editing, or **nano** if you are new to linux.
    Little tip: to exit vim type **:q**. You can install them with **pacman -S vim nano**.
    
    Now all should work fine
    ```console
    archlinux@root:~# ping archlinux.org
    PING archlinux.org (95.217.163.246) 56(84) bytes of data.
    64 bytes from archlinux.org (95.217.163.246): icmp_seq=1 ttl=52 time=47.3 ms
    64 bytes from archlinux.org (95.217.163.246): icmp_seq=2 ttl=52 time=49.0 ms
    64 bytes from archlinux.org (95.217.163.246): icmp_seq=3 ttl=52 time=52.5 ms
    64 bytes from archlinux.org (95.217.163.246): icmp_seq=4 ttl=52 time=48.9 ms
    64 bytes from archlinux.org (95.217.163.246): icmp_seq=5 ttl=52 time=49.4 ms
    ```

    Now is the best time to use
    ```console
    archlinux@root:~# pacman -Syu
    ```

    And **finally install** NetworkManager
    ```console
    archlinux@root:~# pacman -S networkmanager
    ```

    You can now make sure, how easy could everything be, if you had installed NetworkManager
    just enable it and by using following command
    ```console
    archlinux@root:~# systemctl enable NetworkManager
    archlinux@root:~# systemctl start NetworkManager
    archlinux@root:~# nmtui
    ```

    > **nmtui** - you don't even need guide to use it, it is so simple.

    In most cases, setting everything to **automatic** will work perfectly.
    If you need to configure static ip, most likely there would be network admin,
    but anyway you already know how to do it yoursself.

2. **Ask the Audience**
    
    If there is a network admin, just ask him, he will give all the info you need (and probably setup your network for you).

3. **Using live boot**
    
    Just live boot again. Mount partitions and arch-chroot into it.
    Install NetworkManager. Exit. Reboot.

## Step 3. Installing i3
Now, archlinux welcomes us with empty dark text-based view, asking to log in.
Although, we can do many tasks using tty, we don't like the way that things are now.
We want to use graphical view, to use apps that require it.
But we don't want to use heavy **Desktop environment**.
Instead, we will use simple **Window manager**.
WMs are lightweight, highly configurable and of course very fast. There are many of them. In our case, we are going to install **i3**.

### Basic installation
    
Let's start with installing neccessary packages.
```console
archlinux@root:~# pacman -S xorg xorg-xinit nvidia mesa i3-gaps
```
+ **xorg** and **xorg-xinit** are open source implementation of the X Window System and it's initialisation programm.
+ nvidia and mesa are videodrivers
+ i3-gaps is the WM
    
Let's install additional packages for further usage
```console
archlinux@root:~# pacman -S alacritty ranger rofi
```
+ **alacritty** is terminal emulator
+ **ranger** is file manager
+ **rofi** app launching programm

### Users
    
If you have followed archlinux installation guide and did not do anything else, you will have only one user - **root**.
It is very important to understand the usage of the users.
**root** user is ONLY for system configuration. He is allowed to do everything. Even to delete the system.
It is very likely, that you will try to edit system file by accident, or run a program that does so.
So it is very important to add ordinary user for everyday use. And switch back to root only when you are configurating system.
    
To add user type the folowing command.
```console
archlinux@root:~# useradd name
```
    
> **Note** use your desired username instead of **name**
    
Check the users using the following command.
```console
archlinux@root:~# cat /etc/passwd
```
    
You can see, that there are not only root and your newly created user but also some others.
Some programms create their users to run their executables from that user (with their privilagies)
    
Check the home directory of your newly created user. If directory was't created automatically, create it manually
```console
archlinux@root:~# mkdir /home/username
```
> **Note** Make sure to set owner of the directory to newly created user

As we are now configuring some users' settings, it is the best time to install **zsh**.
Archlinux uses bash by default. We recommend installing **zsh**.

```console
archlinux@root:~# pacman -S zsh
```
    
Open **/etc/passwd** for editing
```console
archlinux@root:~# vim /etc/passwd
```

You can see **/bin/bash** in front of your newly created user
Change it into **/bin/zsh**
If you want, you can change roots shell too

Now switch to ordinary user
```console
archlinux@root:~# su username
```
    
Create **.xinitrc** file in your home directory and put "exec i3" in it.
You have 2 options to do it.
1. Using vim
    ```console
    archlinux@username:~$ vim ~/.xinitrc
    ```
    And type **exec i3** and exit.
2. Using **echo**
    ```console
    archlinux@username:~$ echo "exec i3" > ~/.xinitrc
    ```

> **Note** both of the above will create the file if it doesn't exist.
    
So now we have WM configured, but it is still not enough.
Computer should start with login screen (AKA desktop manager).

Let's install one (And enable it).
> **Note** to install a package, you should switch back to root.

```console
archlinux@root:~# pacman -S lightdm
archlinux@root:~# systemctl enable lightdm
```
    
Just before we can finally see our result. Let's finish system configuration.
We need to setup audio

```console
archlinux@root:~# pacman -S alsa-lib alsa-utils pulseaudio
```
Done!

Now reboot and look at the result.

```console
archlinux@root:~# reboot
```

We can see a simple graphical login screen welcoming us.
Log in with ordinary user (It should be the only one in the list).

You will see a prompt asking what button to set as Mod (The "Windows" button or Alt).
Just press enter. We are going to configure everything manually.
    
## Step 4. Configure i3

First we can see a bar, that is showing an error. Let's fix it.
Open terminal by pressing following combination Mod+Enter
Switch user to root. And install i3status
```console
archlinux@root:~# pacman -S i3status
```

Press Mod+Shift+R. It will restart i3.
Now instead of an error text we can see our ip and other info.
It is the default settings of i3status. Yes, we can configure it as we want (But later).
    
Let's install 2 packages
```console
archlinux@root:~# pacman -S lxappearance nitrogen
```
    
+ **lxappearance** we will use to conifure system themes
+ **nitrogen** we will use to set wallpaper
    
Copy the .config directory from this repository to your home directory.
You can do it by cloning this repository, and moving it.
> **Note** You need to install git if you haven't done it before.
```console
archlinux@username:~$ git clone https://github.com/lightningInARock/linux-config
archlinux@username:~$ cp .* ~
```


# Archlinux from zero to hero

Installing and configurating Archlinux with i3 and zsh

## Steps to complete

 - [Installing & configurating pure Archlinux](#installing--configurating-pure-archlinux)
 - [Installing GUI i3](#installing-gui-i3)
 - [Configurating Zsh](#configurating-zsh)
 - [Configurating Vim](#configurating-vim)


## Installing & configurating pure Archlinux

Archlinux can be installed (maybe not from the first attempt) by following [Archlinux installation guide](https://wiki.archlinux.org/title/installation_guide).

We won't describe any other details here, because [Archlinux installation guide](https://wiki.archlinux.org/title/installation_guide) does it pretty well. By following all the steps, you should be able to install pure Archlinux.  
> **Note** Archlinux does not have anything pre-configured, so you have to do almost everything manualy. Of course there are some tools that can help us during the process, and of course we will use some of them!

Just before you exit live boot, make sure to install **NetworkManager**

```console
archlinux@root:~# pacman -S NetworkManager
```  
> **Note** **NetworkManager** is a very helpful tool to configure our internet connection.
## Configure internet connection in newly installed OS

To configure our OS, we need internet connection. All packages or git repos or other cool stuff (even not related to this topic) can be found on the internet. And unfortunately we don't have access to it right now. So let's fix it, shall we?

### The network!

First things first. We need to know some details. So the network configuration is not that easy as it seems. There are many tools that make the config process automated, and so we don't even notice how many steps are done without our participation.

> **Note** If you are familiar with networks, you can skip this section.

The network is very big (I mean really really big) and after connecting we become just a very very small part of it. There are billions if devices connected to the internet. So how is it working without breaking apart?
 
First, who said it is working without breaking apart??? Network is crashing all the time! Crashes happen every day, maybe even every hour in your city's network. Even if 1 wire gets cut, or one of the stations breaks because of the weather... a whole section of network can break apart! Fortunately people are smart (at least those who create or maintain the network). So the connection is pretty much reliable. Starting from its structure... For example in most cases there is not only one specific path from your compuiter to a server you want to connect, so if one of the wires gets damaged, you will connect to the server via other path automatically. Even if not, there are people, who detect and fix the network all the time, and that is a labor-intensive work. Let's take a moment and say thank you to them. So you can play you online game or watch your favorite streamer without worrying, and even if there appears a problem, be sure that it is going to be fixed very soon!
 
> **Note** The network structure and its maintainance is a very big topic. We are not going to discuss the details of it here. We just got a little knowledge of how the things work.

So let's move on.

Every device connected to the network has its address. You can think of it as buildings in a city. There are many building out there, and each of them has an address, so you can sit in a taxi and ask the driver to go to your friend's house by giving the address (Because the driver doesn't know where your friend lives). The same is in the network, with one little difference.

The addresses there are not like **"5 <Famous man's name> Street Apt. 24"**  
In the network every device has a number assigned to it. That number is called **IP**.  
There are 2 protocols that define the range (and other parameters) of IPs - **IPv4** and **IPv6**. Although, in all cases IPv6 is better, it was designed later than IPv4, so the IPv4 is now dominating. But sooner or later IPv6 is (almost 100% sure) going to cover ALL the network.

But as most likely you are going to use IPv4, let's see how is it working.
A IP in IPv4 is an **unsigned integer of 32 bits** (aka. a number between **0** and **4 294 967 295**)  
But it is represented not as a single number, but as a 4 one-byte numbers.
This is the template - **X.X.X.X**
Where **X** is a **1 byte unsigned integer** (aka. a number between 0 and 255)
You have definitely met such an IP - **192.168.0.1**

You may have already noticed one problem. The IP count in IPv4 is not enough!!! **4 294 967 295** total IP count?! Seriously? Who came up with this?  
The number of devices that can connect to the internet are counted in billions (Not only PCs or Smartphones... There are cameras, fridges, even light bulbs!)  
So how is it all working?

Check out the [Cisco IP Networking Basics](https://www.cisco.com/en/US/docs/security/vpn5000/manager/reference/guide/appA.html) to learn more.

### Configuration

So all the info to configure the network are
+ Local IP
+ Subnet Mask
+ The address of the network device that we are connected to (Router, Switch, etc.) aka Default Gateway

We just need to tell all of it to our device.

So how can we do it?
Here are the options.
+ [Configure everything using **NetworkManager**](configure-everything-using-networkmanager) (Recommended)
+ [Ask the audience](ask-the-audience)
+ [Using live boot](using-live-boot)
+ [Manual](manual)

### Configure everything using NetworkManager
If you have installed **NetworkManaget** you will have a terminal command called **nmtui**. It is so simple that I don't even think that someone (Especially people that want to use Archlinux) need a guide for it. 
Just use
```console
archlinux@root:~# nmtui
```
Then just navigate to Network Interface and type in the information it needs (Local IP, Subnet Mask, Default Gate address) 
You will need to
+ Select **Edit a connection**
+ Select your option under the **Ethernet** (It should be named **enpXsY** where **X** and **Y** are integers). If there is no connection **add** one!
+ Cahnge the **Profile name** (if you want, this is optional)
+ Edit the Address (to something like 192.168.0.11/24)
+ Edit the Gateway (to something like 192.168.0.1)
+ Add **DNS server** 8.8.8.8 and 1.1.1.1 (It works fine with only one too)
+ Enter **OK** and then **Back**
+ You will most likely need to activate the Netwrk interface too, so enter to **Activate a connection**
+ Select newly configurted interface and press **Activate** and then go **Back**
+ We want our PC to have its name (For others on the network will know whick device is yours). Select **Set system hostname**
+ Enter a name you like (Fore example: **MyArchDevice**)
+ Select **OK** and then **Quit**
You are all done!

### Ask the audience
If you are trying to install it not for your own PC, or your network settings are not the same as shown on example, it is most likely that it is configured manually. So jsut ask your Network Administrator for help.
### Using live boot
If you don't have **NetworkManager**, you can try to boot with your **Live boot** again. It will have internet, and then jsut Install NetworkManager and check out the **Configure everything using NetworkManager** part.
### Manual
We need to figure out our network settings.  
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

 hostname 8.8.8.8
 hostname 1.1.1.1

>**Note** Yes, everything will work if you add just one of the hostnames,
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
## Installing GUI i3
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
#### Using vim
```console
archlinux@username:~$ vim ~/.xinitrc
```
And type **exec i3** and exit. 

#### Using **echo**
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
We need to setup audio.

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
    
### Configure i3

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

## Configurating Zsh
To unleash the full power of Zsh, we highly recomment to install **Oh-My-Zsh**  
Check out their [website](https://ohmyz.sh)  
Or just run this command directly
```console
archlinux@root:~# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Next install **zsh-autosuggestions** **zsh-syntax-highlighting** using **OMZ** (aka **Oh-My-Zsh**)  
They both have their github pages so just google it and look at the topic where it describes how to install using **OMZ**.
## Configurating Vim
We will install some plugins to improve our experience with **Vim**.  
And to make Plugin management a lot easier, we highly recommend installing [Vundle](https://github.com/VundleVim/Vundle.vim)

After Installation, copy the **.vimrc** file from this repo to your **home directory**.  
Then run **vim** and type **:PluginInstall**  
Wait for it to complete and restart vim.

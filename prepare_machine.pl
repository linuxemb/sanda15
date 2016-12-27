#!/usr/bin/perl
################################################################################
## Title:       Build Machine preparation script
## Version:     1.1
## Description: This script prepares a 64-bit Ubuntu/Debian machine
##              so that it can perform a build.
################################################################################

use strict;
use warnings;

# Starting messages
print "\e[33m";
print "==================================================\n";
print "Build Machine Preparation Script for Ubuntu 64-bit\n";
print "- v1.0\n";
print "==================================================\n\n";
print "\e[0m\n";

# Checking for 64-bit machine
print "\e[36mChecking CPU and Operating System...\e[0m\n";
my $os_check = `uname -m`;
if ($os_check =~ m/x86_64/) {
    print "\e[35mOperating system: 64-bit\e[0m\n\n";
}
else {
    print "\e[32mERROR: 64-bit Operating system not found! Quitting!\e[0m\n\n";
    exit(1);
}

# Installation commands
#  a) pkg_install_cmd: used for packages.
#  b) toolchain_install_cmd: Used for installing the toolchain in console mode.
my $pkg_install_cmd = "sudo apt-get -y install ";
my $pkg_flag = 0;
my $toolchain_pattern = "arm-[0-9]{4}\.[0-9]{2}-[0-9]{2}-arm-none-linux-gnueabi.bin";

# List of missing packages for Ubuntu 12.04 Desktop (64-bit) to check
# so that we can setup a build machine from scratch
my @packages = (
    "aptitude",
    "binutils-dev",
    "build-essential",
    "crda",
    "dkms",
    "docbook-xml",
    "ia32-libs",
    "imagemagick-common",
    "imagemagick",
    "iw",
    "bison",
    "flex",
    "gcc-multilib", 
    "gettext",
    "git",
    "libcdt4",
    "libelf-dev",
    "libelf1:i386",
    "libgraph4",
    "libglade2-dev",
    "libglib2.0-dev",
    "libgvc5",
    "libgssglue1",
    "libgtk-3-dev",    
    "libilmbase6",
    "liblqr-1-0",
    "libmagickcore4",
    "libmagickcore4-extra",
    "libmagickwand4",
    "libncurses5-dev",
    "libnetpbm10",
    "libnfsidmap2",
    "libopenexr6",
    "libpathplan4",
    "libqt4-dev",
    "librarian0",
    "libtirpc1",
    "libutouch-evemu1",
    "libutouch-frame1", 
    "libutouch-geis1", 
    "libutouch-grail1", 
    "libvte-common",
    "libvte9",
    "netpbm",
    "nfs-common",
    "nfs-kernel-server",
    "openssh-server",
    "rarian-compat",
    "rpcbind",
    "sgml-data",
    "ssh",
    "ssh-import-id",
    "subversion",
    "synaptic",
    "texinfo",
    "vim",
    "vim-runtime",
    "wireless-regdb"
);

# Checking each package and building the install command
print "\e[36mChecking for missing packages in system...\e[0m\n";
foreach (@packages) {
    # nice printing on screen
    my $str = "$_";
    for (my $i = 0; $i < 40 - length($_); $i++) {
        $str .= ".";
    }         
    
    # checking each package and building the installation script
    my $cmd = `dpkg-query -l $_ 2>&1`;
    if ($cmd =~ m/No packages found/) {
        $str .= "\e[31mno\e[0m\n";
        $pkg_install_cmd .= "$_ ";
        $pkg_flag = 1;
    }
    else {
        $str .= "\e[32myes\e[0m\n";
    }    
    print $str;
}

# Installing the packages
if ($pkg_flag == 1) {    
    print "\e[36mInstalling missing packages... please wait...\n";
    print "\e[36mYou maybe prompted for admin/root password!\e[0m\n\n";
    system($pkg_install_cmd);
} 
else {
    print "\e[32mAll packages are already installed!\e[0m\n\n";
}

# Reconfiguring your prompt to use dash instead
print "\e[36mReconfiguring your system to use Dash...........";
system("sudo dpkg-reconfigure -plow dash");
print "\e[32mDONE!\e[0m\n\n";

# Installing toolchain
#
print "\e[36mChecking for toolchain installer file... please wait...\e[0m\n";
my $cmd = `ls *.bin 2>&1`;
my @match = $cmd =~ m/$toolchain_pattern/g;
#print @match . "\n";
#print $cmd . "\n";

if (@match > 0) {
    print "\e[36mInstalling cross-compile toolchain...\e[0m\n";
    print "\e[35mSelected: " . $match[0] . "...\e[0m\n";
    system("sudo ./" . $match[0] . " -i console");
}
else {
    print "\e[31mERROR: Toolchain not found! Exiting Installer!\e[0m\n";
}

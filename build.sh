#!/bin/bash
#
# simple wrapper to prep a bare box to build RPMs
# 
# also see: http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment

echo "%_topdir                %{expand:%%(pwd)}" > ~/.rpmmacros
echo "%_sourcedir             %{expand:%%(pwd)}" >> ~/.rpmmacros
#
# generic steps
# we need stuff from EPEL, like libiptcdata-devel, libstatgrab-devel
sudo rpm -ihv http://mirror.bytemark.co.uk/fedora/epel/5/i386/epel-release-5-4.noarch.rpm
sudo yum install rpm-build make gcc spectool
mkdir -p ./{BUILD,RPMS,SOURCES,SPECS,SRPMS}

#
# spec specific steps
BUILDDEPS="lm_sensors-devel rrdtool-devel libpcap-devel net-snmp-devel libstatgrab-devel libxml2-devel libiptcdata-devel curl-devel libidn-devel mysql-devel"
sudo yum install $YUM_OPTS $BUILDDEPS
#yum-builddep collectd.spec

rpmbuild -ba collectd.spec

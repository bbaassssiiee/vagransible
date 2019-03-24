#!/bin/bash -eux

HOME_DIR=/home/vagrant
yum install -y gcc cpp libstdc++-devel kernel-devel kernel-headers

mkdir -p /tmp/vbox;
mount -o loop $HOME_DIR/VBoxGuestAdditions.iso /tmp/vbox;
sh /tmp/vbox/VBoxLinuxAdditions.run \
    || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
        "For more read https://www.virtualbox.org/ticket/12479";
umount /tmp/vbox;
rm -rf /tmp/vbox;
rm -f $HOME_DIR/*.iso;


if [[ "$PACKER_BUILDER_TYPE" == virtualbox* ]]; then
  ## https://access.redhat.com/site/solutions/58625 (subscription required)
  # add 'single-request-reopen' so it is included when /etc/resolv.conf is generated
  echo 'RES_OPTIONS="single-request-reopen"' >> /etc/sysconfig/network
  service network restart
  echo 'Slow DNS fix applied (single-request-reopen)'
else
  echo 'Slow DNS fix not required for this platform, skipping'
fi

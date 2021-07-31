#!/usr/bin/bash -x

if [[ $BLACKARCH == "true" ]]; then
  # Run https://blackarch.org/strap.sh as root and follow the instructions.
  curl -O https://blackarch.org/strap.sh
  # Verify the SHA1 sum
  echo edf8a85057ea49dce21eea429eb270535f3c5f9a strap.sh | sha1sum -c
  # Set execute bit
  chmod +x strap.sh
  # Run strap.sh
  ./strap.sh
  # Enable multilib following https://wiki.archlinux.org/index.php/Official_repositories#Enabling_multilib 
  sed -i '/^#\[multilib\]/s/^#//g' /etc/pacman.conf
  sed -i '/^\[multilib\]/{N;s/\n#/\n/}' /etc/pacman.conf
  # Update
  pacman -Syy
  # Remove
  rm -f ./strap.sh
fi

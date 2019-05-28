https://gitlab.com/interception/linux/plugins/caps2esc

install_caps2esc() {
echo "Cloning and compiling binaries"
(
    cd /tmp
    git clone git@gitlab.com:interception/linux/tools.git
    cd tools
    mkdir build
    cd build
    cmake ..
    make
    sudo make install
)
(
    cd /tmp
    git clone git@gitlab.com:interception/linux/plugins/caps2esc.git
    cd caps2esc
    mkdir build
    cd build
    cmake ..
    make
    sudo make install
)

echo "Writing udevmon job configuration"
cat <<-EOF | sudo tee /etc/udevmon.yaml
- JOB: "intercept -g \$DEVNODE | caps2esc | uinput -d \$DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
EOF

echo "Adding udevmon service"
cat <<-EOF | sudo tee /etc/systemd/system/udevmon.service
[Unit]
Description=udevmon
After=systemd-user-sessions.service

[Service]
ExecStart=/usr/bin/nice -n -20 usr/local/bin/udevmon -c /etc/udevmon.yaml

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now udevmon
}

if [ ! "$(command -v caps2esc)"]; then
    install_caps2esc
else
    echo "caps2esc already installed"
fi

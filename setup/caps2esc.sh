https://gitlab.com/interception/linux/plugins/caps2esc

echo "Writing udevmon job configuration"
cat <<-EOF | sudo tee /etc/udevmon.yaml
- JOB: "intercept -g \$DEVNODE | caps2esc | uinput -d \$DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
EOF

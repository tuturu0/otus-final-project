#!/bin/bash

Users="application"

for i in $Users; do
        grep -q "^$i:" /etc/group || echo -e "ubuntu\n" | sudo -S groupadd "$i" && \
        grep -q "^$i:" /etc/passwd || echo -e "ubuntu\n" | sudo -S useradd "$i" -N -G users --create-home -s /bin/bash && \
        echo -e echo -e "ubuntu\n" | sudo -S usermod -a -G "$i" "$i" || exit 2
        echo -e echo -e "ubuntu\n" | sudo -S usermod -a -G "sudo" "$i"

        echo -e "ubuntu\n" | sudo -S mkdir "/home/$i/.ssh"
        echo -e "ubuntu\n" | sudo -S chmod 755 "/home/$i/.ssh"
        echo -e "ubuntu\n" | sudo -S touch "/home/$i/.ssh/authorized_keys"
        echo -e "ubuntu\n" | sudo -S chmod 644 "/home/$i/.ssh/authorized_keys"
        echo -e "ubuntu\n" | sudo -S chown -R "$i":users "/home/$i/.ssh"

        if [ $i == "application" ]; then
                echo -e "ubuntu\n" | sudo -S tee -a /home/$i/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXbiVfSofz2OyBxNpXPvw/IX2RFM7VE7DEV49n+5Dh58/ygqgJbwJ83V/8KOXHugl6HoujQXKlWBKTuK0rDdIM8NxgE04QsGIkLPBUhfhdsKYHCk8vOkxbW1qRX0auHI8W2FKwLteDd9CZNDQIeTzaAoOevyXTl0Gt5PJq6GfueNU198OoVThBgmo7n5W8M3g7quGfgDnqSYhNKAlWnP9UQuxuQfF0aYWtROieXEX289sVGBm7g+6JUxTHeKx8QgiAzeFu1vy760Bu0f4DmXmCUjXLJhX9JQyY0OZIzVxV5f6B7ryZqWKlGP6PZi1DIkmIoQOTuN46DZxbhC8wOvAzH07pnm3BNCptQYv2nOIWtWfUT3SGBE2uAd+EVWpi36L5NJ0ltU/QpZ4NIXxIguQ8YikvwQYl4iPXg07Sg1ODDT6Nmat+BKoCCugQF96Wv6UvSMgccK3XrK3T4kqKjJCcLYBC+s3c1e/2S3REx/pTqiG+1O+zmeFj5516c69hA68= tuturu@DESKTOP-8J9606S
EOF
        fi
done

echo -e "ubuntu\n" | sudo -S tee -a /etc/sudoers.d/users <<EOF
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL) NOPASSWD:ALL

EOF
echo -e "ubuntu\n" | sudo -S chmod 0440 /etc/sudoers.d/users

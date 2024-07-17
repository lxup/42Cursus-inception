#!/bin/bash

# Launch vsftpd
service vsftpd start

# Create user with FTP_USER and FTP_PASSWORD
adduser --disabled-password --gecos "" $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd

# Add user to vsftpd user list
echo "$FTP_USER" >> /etc/vsftpd.userlist

# Create FTP directory from WordPress path
mkdir -o $WORDPRESS_PATH
chown nobody:nogroup $WORDPRESS_PATH
chmod a-w $WORDPRESS_PATH

# Update vsftpd configuration
sed -i -r "s/#?local_enable=YES/local_enable=YES/" /etc/vsftpd.conf
sed -i -r "s/#?write_enable=YES/write_enable=YES/" /etc/vsftpd.conf
sed -i -r "s/#?chroot_local_user=YES/chroot_local_user=YES/" /etc/vsftpd.conf
echo "
	allow_writeable_chroot=YES
	user_sub_token=\$USER
	local_root=$WORDPRESS_PATH
" >> /etc/vsftpd.conf

# Add passive mode configuration
echo "
	pasv_min_port=21000
	pasv_max_port=21010
	local_enable=YES
	userlist_file=/etc/vsftpd.userlist
" >> /etc/vsftpd.conf


# Restart vsftpd
service vsftpd stop

# Launch vsftpd
/usr/sbin/vsftpd /etc/vsftpd.conf

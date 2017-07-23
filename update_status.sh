#!/bin/sh
[ $UPDATE_INTERVAL -ge 1 ] || UPDATE_INTERVAL=300

while [ true ]; do
	/usr/local/bin/php /var/www/cron/status.cron.php
	sleep $UPDATE_INTERVAL
done

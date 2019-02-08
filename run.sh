#!/usr/bin/env sh

LIMIT=15

ps cax | grep xmrig > /dev/null
if [ $? -eq 0 ]; then
	echo "xmrig is already running."
else
	echo "starting xmrig."
	nice -n 19 ./xmrig -c config.json

	XMRPID=$(pgrep xmrig)

	cpulimit -l $LIMIT -p $XMRPID -b

	echo 19 > /proc/$XMRPID/autogroup

	# let the bg process print to screen and then give you a clean prompt
	sleep 2
	echo
fi

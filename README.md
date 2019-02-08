# bg miner

The idea of this project is to mine a little crypto when your vm is otherwise being unused. It's set to use a high nice value so the primary function of your vm may persist unheeded and limit cpu usage so as to not be an undue burden to your vm neighbors. I don't know that the numbers are tweaked to optimal profit/fair to neighbors levels, but they seem like a good starting point at the very least.

### both versions

* set [nice](https://en.wikipedia.org/wiki/Nice_(Unix)) level to 19, both on the process itself and on the process's [autogroups](https://superuser.com/a/1151279)
	* I can't really tell if this has any real effect on docker, but it's there and doesn't hurt
* use cpulimit to keep cpu usage low
	* get a little utility out of dead cpu cycles, but also stay friendly to vm neighbors
	* currently set to 15, but it isn't perfect and usually ends up in the 10-20 range
* uses [xmrig](https://github.com/xmrig/xmrig) as the miner
	* default points to my account (I don't mind if you choose not to change it!)
* assume debian based system variants (uses apt-get)

#### usage

1. feel free to test by cloning the project as it is, but i would suggest forking it and setting up your own custom defaults
1. modify the config.json file or [create](https://config.xmrig.com/xmrig) a new one
	* make sure to set your own wallet/credentials for whatever pool you're mining with
	* I suggest setting the logs value to `./logs/xmrig` as that folder will be created during `setup.sh` (and isn't tracked via git)
1. change the `LIMIT` value in `run.sh` to whatever cpu limit you'd like to set. (remember it's not perfect, 15 typically results in a range of 10-20 in my experience)
1. commit your changes to git and keep them on *github* for easy distribution and updating
1. continue with whichever variant best suits your needs below

### Raw (not docker) version 

1. run `setup.sh`
	* requires sudo privileges and will prompt for your password
	* installs build tools and a couple other basic tools in case your linux distribution doesn't already have them
	* downloads code and builds latest version of xmrig
1. run `run.sh`
	* automatically uses the config you provided
	* sets nice levels
	* uses cpulimit to limit cpu usage
1. if you need to stop, easiest with `stop.sh`
1. protip - many modern systems allow you to set the following in your crontab to get it to run automatically after you reboot
	* `@reboot cd /path/to/bg/miner/folder; ./run.sh;`

### Docker version

NOTE: docker does not play [nice](https://en.wikipedia.org/wiki/Nice_(Unix)) (hahahaha super pun) with other processes! the docker setup is only set to dial down its intensity when other other *docker containers* are vying for more cpu resources! also, it's easiest to use *docker-compose* (easy reference/guide [here](https://markdowndemo.redeggproductions.com/permalink.php?perma=a6fe3a777cea529a24e0e738eb19c6e6))

1. from within the *bg-miner* directory, just run `docker-compose up -d`
	* if you make config changes, you'll need to add `--build`
1. that's pretty much it? might need to remember to restart the service if your host vm reboots, but I don't know for sure. I'm still new to docker

### Prove it will back off for other CPU resources

1. run `htop` and note how much cpu *xmrig* is using
1. run `cat /dev/zero > /dev/null` in another terminal window
	* if using docker, you'll need to run in a second docker container to see results, so you can run it in a simple alpine container with this command: `docker run --name bench --rm -it alpine`
1. note how *xmrig*'s cpu usage dials back when the higher priority process is running (it's working!)
1. kill the `cat` command (`ctrl-c`)
1. *xmrig* resumes its higher cpu usage

### Donate if you appreciate this work
xmr: `496zV4xRqyw99rrwdwy89pJvHjsdVeVDnTwhnDCnNaPdgr3v8JfBZmEMiSqykdZy7uTNvFRwXU1woRa2Mkzscueo3nQuQYx`

btc: `18QgJFvFNqes6K62pY66YQRj9fZ1e1RYz9`

eth: `0x7D735e8C7Bd61f073A136534D92895C614c30Fb5`

ltc: `LeSowYRfPjz9wZUB6W8fX8czL5FePJZbuh`

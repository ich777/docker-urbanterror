# Urban Terror™ in Docker optimized for Unraid
Urban Terror™ is a free multiplayer first person shooter developed by FrozenSand, that will run on any Quake III Arena compatible engine. It is available for Windows, Linux and Macintosh.

Urban Terror can be described as a Hollywood tactical shooter; somewhat realism based, but the motto is "fun over realism". This results in a very unique, enjoyable and addictive game.

**ATTENTION:** The first startup can take very long since the container downloads the gamefiles, please wait patiently even if it seems to be stuck (this can take up to 30 minutes).

**UPDATE:** The container will search for a new version of the game on every start/restart of the container if the variable 'CHECK_FOR_UPDATES' is set to 'true'.


## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Folder for configfiles and the application | /urbanterror |
| CONFIG_NAME | Specify a custom server configuration file name | server-ctf.cfg |
| START_PARAMS | Enter you extra startup parameters if needed | *empty* |
| CHECK_FOR_UPDATES | Set to 'true' (without quotes) to search for updates on every start/restart otherwise leave empty | true |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| UMASK | Umask value for new created files | 0000 |
| DATA_PERMS | Data permissions for config folder | 770 |

## Run example
```
docker run --name Urban-Terror -d \
	-p 27960:27960/udp \
	--env 'CHECK_FOR_UPDATES=true' \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=0000' \
	--env 'DATA_PERMS=770' \
	--volume /path/to/urban-terror:/urbanterror \
	ich777/urbanterror
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!
 
#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/
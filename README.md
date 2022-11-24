# Manage VPS via Telegram
Telegram

![Alt text](https://github.com/pocketvince/Telegram/blob/main/telegram.gif?raw=true "todo")

Shell script to send commands to your VPS via Telegram

## Installation
Edit the settings part:
```shell
#settings
yourid='123456789'
botid='bot0000000000'
apikey='XXXX_XXXXXXXXXXXXXXXXXXXX'
tmpfolder="/tmptelegram"
tmpfile="lastmessageid"
#end settings
```
Add the script in a crontab

Example:
```shell
*/1 05-23 * * * /root/telegram/v2/cmd2.sh
```
And put in your /bin a script that allows to answer (edit also the settings part)
```shell
#!/bin/bash
sleep 2
yourid='123456789'
botid='bot0000000000'
apikey='XXXX_XXXXXXXXXXXXXXXXXXXXXX'
curl -s "https://api.telegram.org/$botid:$apikey/sendMessage?chat_id=$yourid&text=$1"
```

## Usage
V1 of the script (spaghetti code) was mostly used to debug a small VPS during (mysterious) DDOS periods
Or to be able to send me the new IP of my VPS by message (yes, I tested a lot of hosters, some very obscure)

## Contributing

Readme generator: https://www.makeareadme.com/

Ouiheberg (affiliate link): https://www.ouiheberg.com/panel/aff.php?aff=452

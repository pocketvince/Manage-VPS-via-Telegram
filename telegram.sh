#!/bin/bash
sleep 5
#V2
#settings
yourid='123456789'
botid='bot0000000000'
apikey='XXXX_XXXXXXXXXXXXXXXXXXXX'
tmpfolder="/tmptelegram"
tmpfile="lastmessageid"
#end settings
#check folder/file
if [ ! -d "$tmpfolder" ];
then
    echo "The folder does not exist, it will be created ($tmpfolder)"
    mkdir "$tmpfolder"
fi
if [ ! -f "$tmpfolder/$tmpfile" ]
then
        echo "File not found, temporary file generated" ; echo "debug" > "$tmpfolder/$tmpfile"
fi
#end check folder/file
#start
lastmessage=$(curl -s https://api.telegram.org/$botid:$apikey/getUpdates | tail -1)
request=$(echo "$lastmessage" | grep -o -P '(?<="text":").*(?="\}\}]\})' | sed 's/\\//g')
requestdebug=$(echo "$lastmessage" | grep -o -P '(?<="text":").*(?=","entities")' | sed 's/\\//g')
idsender=$(echo "$lastmessage" | grep -o 'id":[^"]*,' | grep -o '[^"]*$' | tail -1 | grep -o '[[:digit:]]*')
lastmessageid=$(echo "$lastmessage" | grep -o 'message_id":[^"]*,' | grep -o '[^"]*$' | tail -1 | grep -o '[[:digit:]]*')
lastmessageidprocessed=$(cat $tmpfolder/$tmpfile)
#check sender
if [ "$yourid" == "$idsender" ]; then
echo "The last message is from you"
else
    echo "The last message is not from you ($idsender)" ; exit
fi
#check if the last message has already been processed
if [ "$lastmessageid" == "$lastmessageidprocessed" ]; then
echo "The last message has already been processed ($request)" ; exit
else
echo "The last message has not been processed yet"
fi
echo "$lastmessageid" > "$tmpfolder/$tmpfile"
echo "#!/bin/bash" > $tmpfolder/tmp_telegramscript.sh
[[ ! -z "$request" ]] && echo "$request" >> $tmpfolder/tmp_telegramscript.sh || echo "$requestdebug" >> $tmpfolder/tmp_telegramscript.sh
chmod +x $tmpfolder/tmp_telegramscript.sh
script -c $tmpfolder/tmp_telegramscript.sh $tmpfolder/telegramscript_last.log
#end

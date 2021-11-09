#!/bin/sh

# Deploy script run during a lifecycle event
# The script has access to the following environment variables that are configured
# as secrets:
# INPUT_KEY: ssh private key of the user to be logged in on the deployment host
# INPUT_USERNAME: username of the user to be logged in on the deployment host
# INPUT_HOST: the target host for deployment
# INPUT_SOURCE: the directory to copy files from
# INPUT_TARGET: the directory for files to be copied to on the deployment host
# INPUT_PUBLISH: the directory where final files are published after they have been deployed to the host

# Note that the rsync moves the files to the INPUT_TARGET, but that in a separate step we move the files
# into the INPUT_PUBLISH to ensure file consistency

echo "+++++++++++++++++++STARTING TRANSFER+++++++++++++++++++"

if [[ "$INPUT_KEY" ]]; then
    #echo -n "Working dir: "
    #echo `pwd`
    echo -e "${INPUT_KEY}" > tmp_id
    chmod 600 tmp_id
    #echo `ifconfig`
    mkdir -p /root/.ssh && \
        chmod 0700 /root/.ssh && \
        ssh-keyscan ${INPUT_HOST} > /root/.ssh/known_hosts
    #scp -qr -P $INPUT_PORT -o StrictHostKeyChecking=no -i tmp_id $INPUT_SOURCE "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET"
    ssh -p ${INPUT_PORT} -i tmp_id ${INPUT_USERNAME}@${INPUT_HOST} "mkdir -p $INPUT_TARGET"
    rsync -rav -e "ssh -i tmp_id -p ${INPUT_PORT}" ${INPUT_SOURCE} $INPUT_USERNAME@$INPUT_HOST:$INPUT_TARGET
    ssh -p ${INPUT_PORT} ${INPUT_USERNAME}@${INPUT_HOST} "chgrp -R web-dev ${INPUT_TARGET}; chmod -R g+rwx ${INPUT_TARGET}"
    #ssh -p ${INPUT_PORT} $INPUT_USERNAME@$INPUT_HOST "if [ -d ${INPUT_PUBLISH}_old ]; then rm -r ${INPUT_PUBLISH}_old; fi; if [ -d ${INPUT_PUBLISH} ]; then mv ${INPUT_PUBLISH} ${INPUT_PUBLISH}_old; fi; mv ${INPUT_TARGET} ${INPUT_PUBLISH}; chgrp -R web-dev ${INPUT_PUBLISH}; chmod -R g+rwx ${INPUT_PUBLISH}"
    echo "Transfer process complete using rsyn over SSH keys"
else
    echo "Trying password authentication as key is not available"
    #sshpass -p $INPUT_PASSWORD scp -qr -P $INPUT_PORT -o StrictHostKeyChecking=no $INPUT_SOURCE "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET"
    #echo "Transfer process complete using password"

fi
echo "+++++++++++++++++++END+++++++++++++++++++"

#!/bin/bash

STAGE=${1}
if [[ -z ${STAGE} ]]; then
    echo 'Stop Deploy Need To Environment Stage'
    exit;
fi

ENV=''

if [ "${STAGE}" == 'development' ] || [ "${STAGE}" == 'staging' ]; then
    echo ${STAGE}
    ENV='dev'
    echo ${ENV}
fi

if [ "${STAGE}" == 'preproduction' ] || [ "${STAGE}" == 'production' ]; then
    echo ${STAGE}
    ENV='prod'
    echo ${ENV}
fi

if [ x${ENV} == x ]; then
    echo 'Stop Deploy Not Allow Environment Stage'
    exit;
fi

IP_LIST=$(aws ec2 describe-instances --filters --query "Reservations[].Instances[].[PublicIpAddress,Tags[?Key=='Name'].Value[]]" --output text --region ap-northeast-2 | sed '$!N;s/\n/\t/' | awk '{print $1}')

for IP in ${IP_LIST};
do
    echo '===================='
    echo ${IP}
    ssh  -o "StrictHostKeyChecking no" -i capa-api.pem ubuntu@${IP} /home/ubuntu/deploy.sh ${STAGE}
    sleep 3
done;
#!/usr/bin/env bash

WECHAT_LOG="/tmp/wechat.log"
#DOWNURL="$(cat release.txt)"
DOWNURL="test"
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
INFO="[${Green_font_prefix}INFO${Font_color_suffix}]"
ERROR="[${Red_font_prefix}ERROR${Font_color_suffix}]"
TITLESUCCESS="固件编译成功"
TITLEFAIL="固件编译失败"
#CONTENT="${DOWNURL}"
CHANNEL="cp"
IFSUCCESS="success"
#PUSHPLUSPOSTSUCCESS='{"token":"'${PUSHPLUSTOKEN}'", "title":"'${TITLESUCCESS}'", "content":"'${DOWNURL}'", "channel":"'${CHANNEL}'", "webhook":"'${PUSHPLUSWEBHOOK}'"}'
#PUSHPLUSPOSTFAIL='{"token":"'${PUSHPLUSTOKEN}'", "title":"'${TITLEFAIL}'", "content":"失败了哪还有下载地址。", "channel":"'${CHANNEL}'", "webhook":"'${PUSHPLUSWEBHOOK}'"}'

#if [[ ${IFSUCCESS} == success ]]; then
#    echo -e "${INFO} Sending message to WeChat..."
#    curl -s "https://sc.ftqq.com/${SCKEY}.send?text=Lean固件编译成功。" -d "&desp=${DOWNURL}" >${WECHAT_LOG}
#    WECHAT_STATUS=$(cat ${WECHAT_LOG} | jq -r .errmsg)
#    if [[ ${WECHAT_STATUS} != success ]]; then
#        echo -e "${ERROR} WeChat message sending failed: $(cat ${WECHAT_LOG})"
#    else
#        echo -e "${INFO} WeChat message sent successfully!"
#    fi
#else
#    echo -e "${INFO} Sending message to WeChat..."
#    curl -s "https://sc.ftqq.com/${SCKEY}.send?text=Lean固件编译失败。" -d "&desp=失败了哪还有下载地址。" >${WECHAT_LOG}
#    WECHAT_STATUS=$(cat ${WECHAT_LOG} | jq -r .errmsg)
#    if [[ ${WECHAT_STATUS} != success ]]; then
#        echo -e "${ERROR} WeChat message sending failed: $(cat ${WECHAT_LOG})"
#    else
#        echo -e "${INFO} WeChat message sent successfully!"
#    fi
#fi

if [[ ${IFSUCCESS} == success ]]; then
    echo -e "${INFO} Sending message to WeChat..."
    curl -s -X POST -H "Content-Type: application/json" -d '{"token":"'"$PUSHPLUSTOKEN"'", "title":"Lean固件编译成功", "content":"$DOWNURL", "channel":"'"$CHANNEL"'", "webhook":"'"$PUSHPLUSWEBHOOK"'"}' http://www.pushplus.plus/send >${WECHAT_LOG}
    cat ${WECHAT_LOG} | grep -q '"code":200'
    if [[ ${?} != 0 ]]; then
        echo -e "${ERROR} WeChat message sending failed: $(cat ${WECHAT_LOG})"
    else
        echo -e "${INFO} WeChat message sent successfully!"
    fi
else
    echo -e "${INFO} Sending message to WeChat..."
    curl -s -X POST -H "Content-Type: application/json" -d '{"token":"'"$PUSHPLUSTOKEN"'", "title":"Lean固件编译失败", "content":"$DOWNURL", "channel":"'"$CHANNEL"'", "webhook":"'"$PUSHPLUSWEBHOOK"'"}' http://www.pushplus.plus/send >${WECHAT_LOG}
    cat ${WECHAT_LOG} | grep -q '"code":200'
    if [[ ${?} != 0 ]]; then
        echo -e "${ERROR} WeChat message sending failed: $(cat ${WECHAT_LOG})"
    else
        echo -e "${INFO} WeChat message sent successfully!"
    fi
fi

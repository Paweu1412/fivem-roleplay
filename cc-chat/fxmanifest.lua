version '1.4.0'
author 'Concept Collective'
description 'A chat theme for FiveM'

lua54 'yes'

server_script 'server/main.lua'
client_script 'client/main.lua'

dependency 'chat'

file 'theme/style.css'

chat_theme 'ccChat' {
    styleSheet = 'theme/style.css',
    msgTemplates = {
        ccChat = '<div id="notification" style="background-color: {0} !important"><div id="info"><div id="bottom-info"><i class="{1}"></i><p id="text">{4}</p></div></div>'
    }
}

exports {
    'getTimestamp'
}

game 'common'
fx_version 'adamant'

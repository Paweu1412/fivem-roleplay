fx_version 'cerulean'
game 'gta5'

name "rp_hud"
description "Hud"
author "Pawcio#4564"
version "1.0.0"

ui_page 'web/index.html'

files {
	'web/index.html',
	'web/index.css',
	'web/index.js',
	'web/assets/wave.gif'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

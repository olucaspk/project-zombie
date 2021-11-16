fx_version "cerulean"
game "gta5"

use_fxv2_oal "yes"
lua54 "yes"

name "common"

server_scripts {
    "@connectqueue/connectqueue.lua",
    "main.lua",
    "server/controllers/*"
}

client_scripts {
    "client/*",
    "client/**/*"
}
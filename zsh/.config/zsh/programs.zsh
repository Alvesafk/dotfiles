_agopass_completion() {
local -a commands
commands=(
'init:Create DB and prompt for master key'
'add:Create a secret in DB'
'list:List all registered secrets'
'delete:Delete a secret'
'get:Get the secret key'
'update:Modify a registered secret'
'make:Create a random 32 bit key'
'auto:Setup autocomplete'
)

if [[ $CURRENT -eq 2 ]]; then
_describe 'command' commands
return
fi
}

compdef _agopass_completion agopass

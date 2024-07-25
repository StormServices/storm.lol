local version = 'v1'
local currentV = 'a'
local link = ''
local discord = ''

if currentV =~ version then
    warn('Wrong version, please get the current version on the link we copied on your clipboard, or join our discord.')
    setclipboard(link)
end
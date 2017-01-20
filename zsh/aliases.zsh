# Use colors in coreutils utilities output
alias ls='ls --color=auto'
alias grep='grep --color'

# ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls'

# Aliases to protect against overwriting
alias cp='cp -i'
alias mv='mv -i'

# git related aliases
alias g='git'

# Update dotfiles
function dfu() {
    (
        cd ~/.dotfiles && git pull --ff-only && ./install -q
    )
}

# Use pip without requiring virtualenv
function syspip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

function syspip3() {
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# cd to git root directory
alias cdgr='cd "$(git root)"'

# Create a (nested) directory and cd into it
function mcd() {
    mkdir -p "${1}" && cd "${1}"
}

# Jump to directory containing file
function jump() {
    cd "$(dirname ${1})"
}

# Go up [n] directories
function up()
{
    local cdir="$(pwd)"
    if [[ "${1}" == "" ]]; then
        cdir="$(dirname "${cdir}")"
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    elif ! [[ "${1}" -gt "0" ]]; then
        echo "Error: argument must be positive"
    else
        for i in {1..${1}}; do
            local ncdir="$(dirname "${cdir}")"
            if [[ "${cdir}" == "${ncdir}" ]]; then
                break
            else
                cdir="${ncdir}"
            fi
        done
    fi
    cd "${cdir}"
}

# Execute a command in a specific directory
function in() {
    (
        cd ${1} && shift && ${@}
    )
}

# Check if a file contains non-ascii characters
function nonascii() {
    LC_ALL=C grep -n '[^[:print:][:space:]]' ${1}
}

# Serve current directory
# TODO(divestrato): change to ws
function serve() {
    ruby -run -e httpd . -p "${1:-8080}"
}

# Mirror a website
alias mirrorsite='wget -m -k -K -E -e robots=off'

# Mirror stdout to stderr, useful for seeing data going through a pipe
alias peek='tee >(cat 1>&2)'

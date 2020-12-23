set -g theme_color_scheme base16-light
set -g theme_newline_cursor yes

if test -e "$HOME/homebrew/bin"
    set -x  fish_user_paths  "$HOME/homebrew/bin" $fish_user_paths
end
if test -e "/home/linuxbrew/.linuxbrew/bin"
    set -x fish_user_paths /home/linuxbrew/.linuxbrew/bin $fish_user_paths
end

set -x PATH $HOME/.anyenv/bin $PATH
status --is-interactive; and source (env SHELL=fish anyenv init -|psub)
source "$HOME/google-cloud-sdk/path.fish.inc"
eval (direnv hook fish)

# GOPATH
set -x GOROOT (goenv prefix)
set -x GOPATH $HOME/go/(goenv versions --bare)
set -x PATH "$GOPATH/bin" $PATH
#eval (goenv init - | source)


# SSH Agent
set -x SSH_AGENT_FILE $HOME/.ssh/ssh-agent
if test -f $SSH_AGENT_FILE
   source $SSH_AGENT_FILE
end
ssh-add -l > /dev/null ^&1
if test $status -ne 0
  ssh-agent -c > $SSH_AGENT_FILE
  source $SSH_AGENT_FILE
  ssh-add $HOME/.ssh/id_rsa
end

set -x PATH ./bin $PATH

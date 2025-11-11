if status is-interactive
    # Commands to run in interactive sessions can go here
end

direnv hook fish | source
set DIRENV_LOG_FORMAT ""
starship init fish | source
alias rebuild "sudo nixos-rebuild boot --flake ~/nixos/#desktop"

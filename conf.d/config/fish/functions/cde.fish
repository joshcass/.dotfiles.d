#!/usr/bin/env fish
# enter the directory that the the currently active Emacs file resides in

function cde
    cd (emacsclient -e '(with-current-buffer
                               (window-buffer (selected-window))
                               default-directory)' | tr -d '"')
end

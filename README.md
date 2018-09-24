`zzz` User Hooks
================

Call scripts on suspend and resume for the currently logged in user using `zzz`.

This was written specifically for Void Linux but should work on any OS that has
or uses the `zzz` command to suspend.

Installation
------------

`make` can be used to install the scripts:

    $ sudo make install
    cp user-script /etc/zzz.d
    cp hooks/resume/99-user-script /etc/zzz.d/resume
    cp hooks/suspend/99-user-script /etc/zzz.d/suspend

This will result in the following layout being created:

    $ tree /etc/zzz.d/
    /etc/zzz.d/
    ├── resume
    │   └── 99-user-script
    ├── suspend
    │   └── 99-user-script
    └── user-script

    2 directories, 3 files

With these scripts in place, the following scripts will be run for the currently
logged in user:

- `~/.onsuspend` - called before the machine is suspended
- `~/.onresume` - called when the machine wakes up

The above scripts will be called with the permissions of the user for whom they
are being called (using `sudo -Hu <user>`).  The `DISPLAY` environmental
variable will also be set to the currently active display.

You can uninstall with:

    $ sudo make uninstall
    rm -f /etc/zzz.d/user-script
    rm -f /etc/zzz.d/resume/99-user-script
    rm -f /etc/zzz.d/suspend/99-user-script

Example
-------

    $ sudo zzz
    Zzzz... [user-script] called Sun Sep 23 11:33:59 EDT 2018
    [user-script] running /home/dave/.onsuspend for user dave (DISPLAY=:0)
    [user-script] ran /home/dave/.onsuspend for user dave, exited 0
    [user-script] called Sun Sep 23 11:34:05 EDT 2018
    [user-script] running /home/dave/.onresume for user dave (DISPLAY=:0)
    [user-script] ran /home/dave/.onresume for user dave, exited 0
    yawn.

Contributing
------------

This project uses:

- Bash Style Guide: https://www.daveeddy.com/bash/
- `shellcheck`: https://github.com/koalaman/shellcheck

Ensure any code contributions pass `make check`:

```
$ make check
awk 'length($0) > 80 { exit(1); }' user-script
shellcheck user-script
shellcheck hooks/*/99-user-script
```

License
-------

MIT License

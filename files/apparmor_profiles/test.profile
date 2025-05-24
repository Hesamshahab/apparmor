# Profile for a sample application "test"
# This profile limits test's access to only specific files and system resources

#include <tunables/global>

profile /usr/bin/test {
    # Allow read access to certain directories
    /usr/bin/test.sh r,
    /lib/** r,
    /usr/lib/** r,

    # Allow access to specific files
    /var/log/test.log rw,
    /var/run/test.pid w,

    # Limit networking (if the app doesn’t need network access, deny it)
    deny network,

    # Allow capabilities needed by test
    capability setuid,
    capability setgid,

    # Allow the app to read environment variables
    @{PROC}/[0-9]*/environ r,

    # Restrict other unnecessary access
    deny /tmp/** w,

    # Allow execution of certain commands, restrict others
    /bin/echo ix,
    /usr/bin/test ix,

    # Deny access to other executables
    deny /bin/** mrwklx,
    deny /sbin/** mrwklx,
}

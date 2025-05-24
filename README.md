
---

# AppArmor Ansible Role

An Ansible role to install, configure, and manage AppArmor profiles on Linux systems. This role helps secure applications by applying AppArmor policies that limit access to resources, files, and capabilities.

## Requirements

This role is compatible with:
- AppArmor installed on the target host.

## Role Variables

### Default Variables

These variables can be defined in `defaults/main.yml` or overridden in your playbook:

| Variable            | Description                                                                                       | Default Value |
|---------------------|---------------------------------------------------------------------------------------------------|---------------|
| `apparmor_profiles` | List of profiles to manage. Each profile should specify the profile name and source file path.    | `[]`          |
| `apparmor_mode`     | AppArmor mode to apply to profiles: `"enforce"` or `"complain"`.                                  | `"enforce"`   |

### Example Variables

```yaml
apparmor_profiles:
  - profile_name: "nginx"
    source: "files/apparmor_profiles/nginx.profile"
apparmor_mode: "enforce"
```

## Role Structure

The role has the following structure:

```
roles/
└── apparmor
    ├── defaults/
    │   └── main.yml               # Default role variables
    ├── tasks/
    │   └── main.yml               
    |   └── setup.yml
    |   └── config.yml             # Role tasks
    |   └── test.yml
    |   └── verify.yml
    |   └── logrotate.yml
    ├── files/
    │   └── apparmor_profiles/
    │       └── example_profile.profile   # Sample profile file
```

## Usage

1. Add this role to your playbook.
2. Define any custom profiles in `files/apparmor_profiles/`.
3. Configure `apparmor_profiles` to list each profile to apply.

### Example Playbook

```yaml
- hosts: all
  roles:
    - role: apparmor
      vars:
        apparmor_profiles:
          - profile_name: "nginx"
            source: "files/apparmor_profiles/nginx.profile"
        apparmor_mode: "enforce"
```

## AppArmor Profile Example

Each profile restricts an application's access to specific resources. Below is an example profile for `/usr/bin/myapp`:

```plain
#include <tunables/global>

profile /usr/bin/myapp {
    /usr/bin/myapp r,
    /lib/** r,
    /usr/lib/** r,
    /etc/myapp/** r,
    /var/log/myapp.log rw,
    /var/run/myapp.pid w,
    deny network,
    capability setuid,
    capability setgid,
    @{PROC}/[0-9]*/environ r,
    deny /tmp/** w,
    /bin/echo ix,
    /usr/bin/myapp ix,
    deny /bin/** mrwklx,
    deny /sbin/** mrwklx,
}
```

Save the profile as `usr.bin.myapp` in `files/apparmor_profiles/` and reference it in `apparmor_profiles`.
## Tags

tags:
  - install (install Apparmor packages)
  - config (create and manage Apparmor profiles)
  - test_script  (test on local machine with script)
  - test_podman  (test on local machine with container)
  - verify (verify Apparmor service and profile)
  - logrotate (for lifecycle audit logs)

## License

MIT License

Copyright (c) 2025 Amirhesam Shahab

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

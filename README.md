# vps-init

vps-init quickly setup a safe and clean environment on a VPS on an ubuntu system (preferred 16.04).

## Table of Contents

*   [Getting started](#getting_started)
*   [Documentation](#documentation)
*   [Reference](#reference)
*   [Contributing](#contributing)
*   [Licensing](#licensing)
*   [Changelog](#changelog)

## Getting started

### VPS prerequisites

Be sure you're on a fresh install of your VPS and root access is granted through SSH.

### Client prerequisites

Be sure SSH is installed on your machine before continuing. To ensure that SSH is installed on your machine, run the following command.

``` shell
ssh
```

To setup your SSH keys please refer to [Google][google] by searching `ssh getting started`.

### Configuration

Before launching the script to quickly setup your VPS, you can edit some configuration files to customize your installation:

*   vps-install.conf: used to configure your remote host.
*   vps/vps-entrypoint.conf: used to configure user, group, gecos, hostname...
*   vps/ssh/sshd_config: ssh standard configuration file without `PermitRootLogin` and without `PasswordAuthentication`. Note that it's recommended to update default port.
*   vps/ssh/id_rsa.pub: your SSH public key to authorize.
*   vps/postfix/main.conf: postfix standard configuration file, you should update your hostname.
*   vps/fail2ban/jail.conf: fail2ban standard jail configuration file, ssh is enabled.

### How to use

To run this script, you just have to run the following command in your terminal.

``` shell
/path/to/vps-init/vps-install.sh
```

## Documentation

If you want to know more about Postfix, Fail2Ban or UFW please refer to official documentations in [reference](#reference).

## Reference

*   [Postfix][postfix]
*   [Fail2Ban][fail2ban]
*   [UFW][ufw]

## Contributing

You're free to contribute, please fork my project and send me a pull request.

If you want to contribute please be aware of my [CODE OF CONDUCT][code_of_conduct].

## Licensing

This repository is under this [LICENSE][license].

## Changelog

The complete changelog could be found in [CHANGELOG][changelog].

[google]: https://www.google.com/search?q=ssh+getting+started
[postfix]: http://www.postfix.org/
[fail2ban]: https://www.fail2ban.org/wiki/index.php/Main_Page
[ufw]: https://wiki.ubuntu.com/UncomplicatedFirewall
[code_of_conduct]: CODE_OF_CONDUCT.md
[license]: LICENSE.md
[changelog]: CHANGELOG.md

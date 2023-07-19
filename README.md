# Latvian eID Gentoo Overlay

Latvian utilities provided by eParaksts.lv for document and requests signing

# Installation

Just add to /etc/portage/repos.conf/latvija-eid.conf
```
[latvija-eid]
location = /var/db/repos/latvija-eid
sync-type = git
sync-uri = https://github.com/admincheg/latvija-eid
priority = 50
autosync = Yes
```

And execute `emerge --sync latvija-eid`
# Applications

> app-crypt/eparakstitajs3

It's standalone java-based application for opening and signing edoc and asice documents.

> app-crypt/latvia-eid

It's kind of middleware libs, patched pkcs11 library for working with latvian eID smartcards.

> app-crypt/eparaksts-token-signing

It's another one middleware lib. Bridge between browsers and latvia-eid libs.

# Notes

If you want to use your ID card for signing documents in browser - you should add specific extension to it.

For Mozilla Firefox it will be: https://addons.mozilla.org/en-US/firefox/addon/eparaksts-signing-extension/

After installation you should go to `Settings -> Security -> Security devices` and manually add installed library.
If you install app-crypt/eparaksts-token-signing - your library placed at /usr/lib/pkcs11/libeparaksts-module.so

You can check your smartcard through `pcsc_scan` command or in eparakstitajs3 application `Tools -> Certificates`.

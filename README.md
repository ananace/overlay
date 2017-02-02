My own collection of ebuilds
---

Please note that I'm not a Gentoo developer, so none of these ebuilds will have official support.
If you find an issue then please submit it on [the issue tracker](https://github.com/ace13/overlay/issues).

Pull Requests are also welcome.

Using
-----

You can use this overlay by adding a file to `/etc/portage/repos.conf/` containing the following;
```
[ace]
priority = 50
location = /opt/portage/ace
sync-type = git
sync-uri = git://github.com/ace13/overlay.git
auto-sync = Yes
```

Or just add it from layman;
```
# layman -a ace
```


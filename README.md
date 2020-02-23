My own collection of ebuilds
---

Please note that I'm not a Gentoo developer, so none of these ebuilds will probably have official support.  
If you find an issue then please submit it on [the issue tracker](https://github.com/ananace/overlay/issues).

Pull Requests are also welcome.

Using
-----

This overlay is on layman, so adding it is as simple as;
```
# layman -a ace
```

If you're not using layman, you can also use this overlay by adding a file to `/etc/portage/repos.conf/` containing something like;
```
[ace]
priority = 50
location = /opt/portage/ace
sync-type = git
sync-uri = git://github.com/ananace/overlay.git
auto-sync = Yes
```

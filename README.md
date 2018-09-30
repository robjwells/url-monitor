# URL Monitor

	Usage:
		monitor.sh URL HTMLDIR DIFFDIR

This is a little shell script that monitors a web page for changes.

You'll want to set it up to run regularly (use `cron`, or `launchd`
via [Lingon](https://www.peterborgapps.com/lingon/) or
[LaunchControl](http://www.soma-zone.com/LaunchControl/) on macOS).

It only checks the HTML of the page. If the HTML is different from
the last time it checked, it saves a copy (into HTMLDIR) and stores
a patch file (from diff -u) into a separate folder (DIFFDIR).

You can then rig something up to act on the patch files as they
appear. I use [Hazel](https://www.noodlesoft.com) to send me a
notification and add a task to OmniFocus (see the sample AppleScript).

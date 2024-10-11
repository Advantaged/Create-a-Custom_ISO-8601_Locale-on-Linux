# Make-your-own_ISO-8601_locale

* **Merit to:** [AI ChatGPT](https://chatgpt.com/)
* In my system i choose by the installation "American English" as Language and "Germany" as location but i want "date"
to be represented following ISO-8601, like:

```
date
2024-10-08 19:37:52 CEST

```

* The output of `locale`-command before the changes:

```
locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=de_DE.UTF-8
LC_TIME=de_DE.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=de_DE.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_ALL=

```

### Step 1: Install `localedef`

Ensure you have the `glibc` package installed, which includes the `localedef` utility (it should be installed by
default on Arch).

### Step 2: Copy File

1. Copy the `locale`-file of your Country-Location, e.g. for Germany:

```
sudo cp /usr/share/i18n/locales/de_DE /usr/share/i18n/locales/de_DE_ISO

```

In this manner, we don't touch the existing file but make only a copy to modify it.

### Step 3: Modify & Compile new Locale

1. Open the new copied file with an Editor, e.g.:

```
sudo nano /usr/share/i18n/locales/de_DE_ISO

```

2. Replace the complete `LC_TIME`-chapter as following 🟰 `ISO-8601`:

```
% Define LC_TIME fields with ISO 8601 format
LC_TIME
abday   "So";"Mo";"Di";"Mi";"Do";"Fr";"Sa"
day     "Sonntag";"Montag";"Dienstag";"Mittwoch";"Donnerstag";"Freitag";"Samstag"
abmon   "Jan";"Feb";"Mär";"Apr";"Mai";"Jun";"Jul";"Aug";"Sep";"Okt";"Nov";"Dez"
mon     "Januar";"Februar";"März";"April";"Mai";"Juni";"Juli";"August";"September";"Oktober";"November";"Dezember"
d_t_fmt "%Y-%m-%d %H:%M:%S"
d_fmt   "%Y-%m-%d"
t_fmt   "%H:%M:%S"
am_pm   "";""
t_fmt_ampm ""
date_fmt "%Y-%m-%d %H:%M:%S %Z"
END LC_TIME

```

* Don't forget to save and close the modified file after modification, if you use `nano`-editor…:
	* [CTRL➕O] to save/store the file &
	* [CTRL➕X] to close the editor.

3. Compile the file through `localedef` with following command:

```
sudo localedef -i de_DE_ISO -f UTF-8 de_DE.ISO.UTF-8

```

* **Notes:**
	* Adjust the file-name according to `copy`-command above.
	* The need to compile the new/modified `locale`-file is (for me) new. That assure `locale` haven't errors. We have
to thank the AI for this.

### Step 4: Add/replace your system with new ISO-8601_TIME-Locale

1. Find your `shell`-configuration files on your system. My system **"CachyOS"** have three different shell's: `bash`,
`fish` & `zsh` & naturally configuration-files for `$ROOT` & `$USER`… hence, following my shell-configuration-files:

* For `$ROOT`:

```
/etc/bash.bashrc

/usr/share/cachyos-fish-config/cachyos-config.fish

/usr/share/cachyos-zsh-config/cachyos-config.zsh

```

* For `$USER`:

```
~/.bashrc

~/.config/fish/config.fish

~/.zshrc

```

* **Note:** If you have only one `shell`… you just need to modify two files and not six in this step 😉.

2. Add at End of these file following command:

`export LC_TIME=de_DE.ISO.UTF-8`

* **Notes:**
	* Last Entry on configuration-files is what count under Linux, no need to search for `export LC_TIME=` in the file.
	* Don't forget to let or insert an empty line at End of every configuration-file of/under Linux.
	* If you use `nano`… hit/press [CTRL➕O] to save/store the file & [CTRL➕X] to close the editor.

3. Modify `sudoers` to assure every app started as "Admin/Root" respect the new `LC_TIME=`

* For this edit `visudo` and not `/etc/sudoers` because last one it doesn’t perform any syntax checking or file locking.
* Edit/open `visudo` with following command:

`sudo EDITOR=nano visudo`

* & add following line:

`Defaults env_keep += "LC_TIME"`

* Don't forget to take care about last Notes above 😉.

### Step 5: Modify `/etc/locale.conf`

1. Edit/open `/etc/locale.conf` e.g. wit `nano` as follow:

`sudo nano /etc/locale.conf`

2. Replace your `LC_TIME=`Line according to your new ISO-8601-Locale:

`LC_TIME=de_DE.ISO.UTF-8`

* The complete `/etc/locale.conf` look like this:

```
LANG=en_US.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_TIME=de_DE.ISO.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8

```

3. Save/store ➕ close the file like already explained above.
* **Notes:**
	* The "locales" set in "Systemsettings/Language & Time/Region & Language" (we can call KDE- or Plasma-Settings) are
independent from "Shell" (terminal/konsole) settings done above.
	* Hence, the settings done till now assure "only" that we not get errors in the terminal during update/upgrade.
	* That's mean… with the anchorage of "Shell-Settings" we avoid that "Plasma-Settings" interfere with
"Shell-Settings"
	* That mean also… if you want to set all other locales/variables for you country like "Numeric, Monetary, Paper,
Name, Address, Telephone, Measurement & Identification" in "Plasma-Settings"… you have to export all variables as above
described 😉.

### Step 6: KDE-/Plasma-Settings

* Now you can open **"Systemsettings/Language & Time/Region & Language"** and set "Time" to `en_SE` (or whatever you
want) without waiting long time during the "Hook-Settings" ➕ error-messages by updating your system, e.g. `sudo pacman
-Syyu`

### Results:

1. Here the output of `locale`-command:

```
locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=de_DE.UTF-8
LC_TIME=de_DE.ISO.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=de_DE.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_ALL=

```

2. Here the output of `date`-command:

```
date
2024-10-08 19:37:52 CEST

```

3. In Attachment some [pictures])Pictures/ with results, e.g. Dolphin, Konsole, ZFS, etc..


✅ **Done** 👍 **& Enjoy**❗️

.

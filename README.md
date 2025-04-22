# Create-a-Custom_ISO-8601_Locale-on-Linux

* **Merit to:** [AI DeepSeek](https://chat.deepseek.com/)
* In my system i choose by the installation "American English" as Language and "Germany" as location but i want "date"
to be represented following ISO-8601.

## Create a Custom ISO-8601 Locale on Linux

*Tested on CachyOS (Arch-based) | By: [tony advantaged]*

#### Objective

Configure your system to display dates in ISO-8601 format (**YYYY-MM-DD HH:MM:SS**) while keeping other locale settings (e.g., language, currency) unchanged.

### Step 1: Copy the Base Locale File

1. **Copy the German locale file** (replace `de_DE` with your country’s locale if needed):

```
sudo cp /usr/share/i18n/locales/de_DE /usr/share/i18n/locales/de_ISO
```

*Why?* This preserves the original file and creates a modifiable copy.

### Step 2: Modify the `LC_TIME` Section

1. Open the copied file:

```
sudo nano /usr/share/i18n/locales/de_DE_ISO
```

2. Replace the `LC_TIME` section with ISO-8601 formats:

```
LC_TIME
abday   "So";"Mo";"Di";"Mi";"Do";"Fr";"Sa"
day     "Sonntag";"Montag";"Dienstag";"Mittwoch";"Donnerstag";"Freitag";"Samstag"
abmon   "Jan";"Feb";"Mär";"Apr";"Mai";"Jun";"Jul";"Aug";"Sep";"Okt";"Nov";"Dez"
mon     "Januar";"Februar";"März";"April";"Mai";"Juni";"Juli";"August";"September";"Oktober";"November";"Dezember"
d_t_fmt "%Y-%m-%d %H:%M:%S"  # ISO-8601 datetime
d_fmt   "%Y-%m-%d"            # ISO-8601 date
t_fmt   "%H:%M:%S"            # ISO-8601 time
am_pm   "";""
t_fmt_ampm ""
date_fmt "%Y-%m-%d %H:%M:%S %Z"
END LC_TIME
```

* ***Note:*** Most relevant part:

```
d_t_fmt "%Y-%m-%d %H:%M:%S"  # ISO-8601 datetime
d_fmt   "%Y-%m-%d"            # ISO-8601 date
t_fmt   "%H:%M:%S"            # ISO-8601 time
am_pm   "";""
t_fmt_ampm ""
date_fmt "%Y-%m-%d %H:%M:%S %Z"
```

* ***Tip for Pros:*** Adjust day/month names for your language and/or use [en_ISO](en_ISO). The linked/mentioned file is especially made/tailored for people using English as OS-language &/but living in another country & want ISO-8601 as date/time representation and files-sorting/representation in their files-manager.

### Step 3: Compile the Locale

1. Generate the binary locale:

```
sudo localedef -i de_ISO -f UTF-8 de_ISO.UTF-8
```

* if you have copied/download `en_ISO`… use command `sudo localedef -i en_ISO -f UTF-8 en_ISO.UTF-8` instead.
* ***Why?*** This compiles the text file into a system-recognized locale.

### Step 4: Update System Configuration

#### 4.1: Add Locale to `/etc/locale.gen`

1. Edit the file:

```
sudo nano /etc/locale.gen
```

2. Add:

```
de_ISO.UTF-8 UTF-8
```
or `en_ISO.UTF-8 UTF-8`, depending of which solution you opted.

3. Regenerate locales:

```
sudo locale-gen
```

#### 4.2: Set `LC_TIME` System-Wide

1. Edit `/etc/locale.conf`:

```
sudo nano /etc/locale.conf
```

2. Add/update:

```
LC_TIME=de_ISO.UTF-8
```

3. My `/etc/locale.conf` made with [en_ISO](en_ISO):

```
LANG=en_US.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_TIME=en_ISO.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8

```

#### 4.3: Update Shell Configs

* Config-Files-List of CachyOS for `$ROOT`:

```
/etc/bash.bashrc

/usr/share/cachyos-fish-config/cachyos-config.fish

/usr/share/cachyos-zsh-config/cachyos-config.zsh

```

* Config-Files-List of CachyOS for `$USER`:

```
~/.bashrc

~/.config/fish/config.fish

~/.zshrc

```


* **Syntax example for Fish:**

```
# ~/.config/fish/config.fish
set -gx LC_TIME de_ISO.UTF-8
```

* **Syntax example for Bash/Zsh:**

```
# ~/.bashrc or ~/.zshrc
export LC_TIME=de_ISO.UTF-8
```

* **Reload your shell:**

```
exec fish  # Fish
source ~/.bashrc  # Bash
source ~/.zshrc   # Zsh
```

#### 4.4: Preserve `LC_TIME` for Sudo/Root

1. Edit sudoers safely:

```
sudo EDITOR=nano visudo
```

2. Add:

```
Defaults env_keep += "LC_TIME"
```

* **Note:** For loading the new configuration you can also log-out & re-log-in or restart your Linux-OS. People using Plasma-DE can also set/choose in `systemsettings/Region & Language/Time/English (Sweden)` or `en_SE`.

### Step 5: Verify the Setup

1. Check locales:


```
locale -a | grep de_ISO  # Should show "de_ISO.utf8"
```

2. Confirm LC_TIME:

```
locale | grep LC_TIME  # Should show "LC_TIME=de_ISO.UTF-8"
```

3. Test the date format:

```
date  # Output: "2025-03-28 09:09:03 CET"
```

4. Read/Test all locales, Note: i use the `en_ISO` locale:

```
locale
```

* All my tests:

```
❯ locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=de_DE.UTF-8
LC_TIME=en_ISO.UTF-8
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

~
❯ locale -a | grep -E "en_US|de_DE|en_ISO"
de_DE.utf8
en_ISO.utf8
en_US.utf8

~
❯ date
2025-03-28 09:03:38 CET

~
❯ locale | grep LC_TIME
LC_TIME=en_ISO.UTF-8

```

#### Troubleshooting
* Locale not found?
    * Ensure the locale is listed in `/etc/locale.gen` and regenerated with `sudo locale-gen`. 
* Date format unchanged?
    * Verify `LC_TIME` is set in both `/etc/locale.conf` and your shell config. 

#### Final Notes
* **For Beginners:** Follow steps exactly—case sensitivity matters (e.g., `.UTF-8` vs `.utf8`)
* **For Pros:** Extend this to other locales by modifying `LC_*` sections as needed or use [en_ISO](en_ISO).

✅ **Done** 👍 **& Enjoy** ISO-8601 dates system-wide❗️ In Attachment some [pictures](Pictures/) with results, e.g. Dolphin, Konsole, ZFS, etc..

.

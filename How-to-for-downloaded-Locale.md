# How-to-for-downloaded-Locale.md

## General advices

* If your Linux-OS-language is English & you want ISO-8601, no matter in which country you live, this is the right & 
faster solution for accomplish your intent.
* **Note:** All locales-files are stored here: `/usr/share/i18n/locales/`, here is also where you should save/store the modified file, look for your country, e.g. Spain = `es_ES`, 
edit the `en_ISO` &| `en_DE` & replace `de_DE` with e.g. `es_ES`.
* Also good & valid for people with less experience with/on Linux.

### Step 1: Download necessary file

1. Download the file-s where you can manipulate it easily, e.g. `~/Documents` or `~/Downloads` or directly in your home 
folder.

* Download all files in one folder:

```
git clone https://github.com/Advantaged/Create-a-Custom_ISO-8601_Locale-on-Linux.git
```

* Download `en_ISO` or `en_DE` only:

```
wget https://github.com/Advantaged/Create-a-Custom_ISO-8601_Locale-on-Linux/blob/main/en_ISO

wget https://github.com/Advantaged/Create-a-Custom_ISO-8601_Locale-on-Linux/blob/main/en_DE
```

* Download full instructions:

```
wget https://github.com/Advantaged/Create-a-Custom_ISO-8601_Locale-on-Linux/blob/main/README.md
```
To read the Markdown-Code (`*.md`) open the `README.md` with every Linux editor, to read it like here, open it with `ghostwriter`,<br> `vs-code`, `code` or even with a PDF reader.

### Step 2: Modify `en_ISO` &| `en_DE` at your pleasure/needs & save/store at approriate place

1. Modify the `en_ISO` &| `en_DE` as described under "General advices"
2. Save/store your modified file at/with e.g.: `sudo cp en_ISO /usr/share/i18n/locales/en_ISO`, here adjust the name according to your country e.g.: `en_ES`, `en_FR`, `en_IT`, etc..

### Step 3: Compile, configure & test

* [Compile](https://github.com/Advantaged/Create-a-Custom_ISO-8601_Locale-on-Linux/tree/main#step-3-compile-the-locale) from above path (`/usr/share/i18n/locales/`), configure & test your new ISO-8601 as described in the full instructions 🟰 `README.md` 🟰 
last download-link.


✅ **Done** 👍 **& Enjoy**❗️

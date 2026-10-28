# AZEBUCHE: how to look after the archive

AZEBUCHE is a sonic archive of olive harvest songs, voices and field
recordings from across the Mediterranean. It lives at
**https://sonomayrit.com/azebuche/**.

You don't need to install anything or write code. You need:

- a web browser,
- a **GitHub** account that can edit the `jvaleroliet/sonoxhibit` project
  (ask the contact below to add you),
- an **archive.org** account, for the sound files.

Every change you make is saved to GitHub. The site then rebuilds by itself:
**wait about 5 minutes**, then reload the page.

---

## 1. Logging in to the editing panel

The panel is at **https://sonomayrit.com/azebuche/admin/**.

The first time, you need a "token" (a long password that lets the panel save
to GitHub):

1. On github.com, click your picture (top right) → **Settings** →
   **Developer settings** (at the bottom of the left menu) →
   **Personal access tokens** → **Tokens (classic)**.
2. Click **Generate new token** → **Generate new token (classic)**.
3. Note: write `Azebuche panel`. Expiration: choose a date (for example one year).
4. Tick the box **repo**. Nothing else.
5. Click **Generate token** at the bottom, and copy the token (it starts with `ghp_`).
   Keep it somewhere safe, like a password manager. GitHub only shows it once.
6. Open the panel, click **Sign In Using Access Token**, paste it, and confirm.

The browser remembers you. When the token expires, make a new one the same
way. Don't use the **Sign In with GitHub** button: it isn't set up.

---

## 2. Adding a recording

### a. Put the sound on archive.org

1. Prepare an **.opus** file of the recording. If you only have a .wav, ask
   the contact below, or see "For the technical person" at the end of this file.
2. On archive.org, click **Upload** (the arrow at the top).
3. Drop in the .opus file. You can add the original .wav to the same upload.
4. Fill in the form:
   - **Title**: `Azebuche AZB-009: title of the recording` (use the right number).
   - **Description**: a sentence about the recording.
   - **Subject tags**: write `azebuche` (this keeps all the archive's sounds
     findable together), plus the place.
   - **Creative Commons license**: choose the same license as the entry
     (normally Attribution-NonCommercial-ShareAlike 4.0).
5. Click **Upload and create your item**. It can take a few minutes.
6. Open the item. Under **DOWNLOAD OPTIONS** on the right, find the
   **OPUS** file (if it isn't listed, click **SHOW ALL** and look for the
   name ending in `.opus`), right-click it, and choose **Copy link**. The link looks like
   `https://archive.org/download/azebuche-azb-009/azb-009.opus`.
7. Write down the file size shown next to it (for example `4.0 MB`) and the
   length of the recording (for example `11:15`).

### b. Fill in the form

1. In the panel, open **Recordings** and look at the highest number in the
   list (for example `008`).
2. Click **New Recording**.
3. **Number**: the next one, with three digits: `009`. The number can't be
   changed later.
4. Fill in the title, place, region and tags. Choose at least one tag.
5. **Date recorded**: `2024-10` (year and month) or just `2024`.
6. **Audio file address**: paste the link you copied from archive.org.
7. **Length** and **File size**: what you wrote down.
8. **Photo**: click to upload a normal photo from your computer or phone.
   You don't need to edit it: the site turns it into black-and-white dots by
   itself. Write one sentence in **Photo description**, for people who can't
   see it.
9. **Short description**: one or two sentences. They appear in the list.
10. **Lyrics, translation and notes**: write under each heading. Each new line
    you type is a new line on the page. Leave an empty line between verses.
    Under **Notes**, write who sang, the context, and the permissions given.
11. Click **Save**.

After about 5 minutes the recording appears at the top of the archive.

---

## 3. Fixing or hiding an entry

- **To fix a mistake**: open the recording in the panel, change it, and
  click **Save**.
- **To hide it without deleting it**: switch on **Draft (hidden from the
  site)** and save. It disappears from the site but stays in the panel.
  Switch Draft off to bring it back.
- **To delete it for good**: open it and choose **Delete**. Prefer Draft if
  you are not sure.

The sample entry (number `001`, "Sample entry (test tone)") is only there for
testing. Delete it, or switch on Draft, once the first real recording is in.

---

## 4. Adding a new tag (or region)

1. In the panel, open **Archive settings** → **Texts, tags and regions**.
2. Under **Tags**, click **Add**.
3. **Id**: a short word in lowercase, without spaces, for example `harvest-meal`.
   **Label**: what visitors read, for example `Harvest meal`.
4. Save. The new tag appears in the recording form, and in the filters of
   the archive as soon as one recording uses it.

Regions work the same way. The same screen also has the introduction, the
About and Contribute texts, the license note, and the big text at the bottom.

Don't rename the **Id** of a tag that's already in use, or the recordings
using it will lose it. Changing the **Label** is fine.

---

## 5. Where everything lives

| What | Where |
| --- | --- |
| The recordings' texts | GitHub, folder `_azebuche/`, one file per recording (`azb-009.md`) |
| Archive texts, tags and regions | GitHub, file `_data/azebuche.yml` |
| Original photos | GitHub, folder `src/azebuche/raw/` |
| Sound files | archive.org, one item per recording, subject `azebuche` |
| Look of the site | `_layouts/azebuche.html`, `_layouts/azebuche-recording.html`, `azebuche/azebuche.css` |
| Editing panel | `azebuche/admin/` |
| Image and audio tools | `tools/azebuche/` |

### Downloading a full copy of the archive

1. **Texts and photos**: go to https://github.com/jvaleroliet/sonoxhibit,
   click the green **Code** button → **Download ZIP**. The archive is in the
   folders listed above.
2. **Sounds**: on archive.org, search for `subject:azebuche`. Each item has a
   **DOWNLOAD OPTIONS** box with all its files.

Keep both copies together. With them, the whole archive can be rebuilt anywhere.

---

## 6. Contact

**info@sonomayrit.com**: for access to GitHub, help, or anything that
looks broken.

---

## For the technical person

- The site is Jekyll, built and published by GitHub Actions
  (`.github/workflows/jekyll.yml`) on every push to `gh-pages`. You can
  follow the builds on the project's **Actions** tab.
- `_plugins/azebuche.rb` runs `tools/azebuche/dither.py` before each build
  (it needs Python 3 and Pillow), leaves out entries with `draft: true`, keeps
  line breaks in recording texts, and writes the index weight into the footer.
  Dithered PNGs go to `src/azebuche/dithered/`. They aren't committed, and
  every build recreates them.
- Front matter uses `recorded:`, not `date:`, because Jekyll rejects partial
  dates. The `AZB-009` code is derived from `number`.
- To make an .opus file and get its length and size:
  `sh tools/azebuche/encode-audio.sh recording.wav` (needs ffmpeg).
- Fonts are sonomayrit's Suisse Intl (Light, Medium) and Neureal Mono,
  cut down to Latin characters as small WOFF2 files in `azebuche/fonts/`
  (`sh tools/azebuche/subset-fonts.sh` remakes them from `src/Fonts/`).
  Neureal is a trial version with letters only, so it is used just for the
  wordmark and the "sonomayrit" brand.
- Public pages have no JavaScript. Only `azebuche/admin/` loads Sveltia CMS,
  pinned to a version with an integrity hash. To update it, see the comment
  in `azebuche/admin/index.html`.
- To move the archive to its own domain later, the AZEBUCHE files are all
  the paths in the table above, plus `_plugins/azebuche.rb` and
  `_includes/azebuche/`. Links inside them start with `/azebuche/` and
  `/src/azebuche/`.

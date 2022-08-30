# curriculum vitae

* Based on [resume](https://github.com/chmduquesne/resume) by Christophe-Marie Duquesne.
* Modified to fit my needs and embellished.

## To use:

* Upate `metadata.yaml`.
* Run `make all`.
* It is possible that some of the html beautifying tricks found in `scripts/modify_html.sh` have to be partly rewritten. They should work for MacOS now, though.
* For pdf generation:
    - install puppeteer with `nvm`:
        - `cd puppeteer`
        - `npm i puppeteer`
        - `cd ../`
* Only tested on Linux and mac

## List of changes:
* Threw out Word.
* renamed the txt and pdf files.

## versions:
* wkhtmltopdf: [0.12.4](https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz) (with patched qt) (0.12.2.4 does **not** work)
* pandoc: 1.16.0.2


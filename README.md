# Justin's Miscellaneous Scripts

An assortment of various command line scripts I created to help my daily
workflow. Also, just some fun stuff.

## Installation

Run `make install` to copy scripts into your `~/bin` directory. You'll need to
have that in your path.

Alternatively, run `make link` to create symbolic links to this repository
instead of copying files.

### Custom install directory

To install or link to a different directory, set `PREFIX`.

```sh
# Installs scripts to /usr/local/bin
make install PREFIX=/usr/local
```

### Install only some scripts

To install only some scripts, specify `BINS`

```sh
# Installs only ssmc and ec2-search
make install BINS='ssmc ec2-search'
```

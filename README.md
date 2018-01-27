# ruml

[![Build Status](https://img.shields.io/travis/splattael/ruml.svg?branch=master)](https://travis-ci.org/splattael/ruml)
[![Gem Version](https://img.shields.io/gem/v/ruml.svg)](https://rubygems.org/gems/ruml)

Ruby mailing list software


## Installation

    $ gem install ruml


## Configration (ruml)

### File based

<pre>
testml/
├── bounce_to
├── members
├── name
└── to
</pre>

* to        - E-mail of the mailing list
* name      - Name of the mailing list displayed in subject. E.g. \[Fancy ML\] (optional)
* member    - List of member's addresses
* bounce_to - Bounce mails go to this email (optional)


## Configuration (Postfix)

### Postfix

#### /etc/postfix/ml-maps

<pre>
/^testml@example.com$/          ml-testml
/^testml-bounce@mail.info$/     testml-bounce@mail.info
</pre>

#### /etc/postfix/ml-aliases

<pre>
ml-testml:    "|/path/to/bin/ruml /var/spool/ruml/lists/testml"
</pre>

#### /etc/postfix/main.cf

<pre>
virtual_alias_maps = regexp:/etc/postfix/ml-maps
alias_maps = hash:/etc/postfix/ml-aliases
alias_database = hash:/etc/postfix/ml-aliases
</pre>


## TODO

* Write unit tests!


## Release

Follow these steps to release this gem:

    # Bump version in
    edit lib/ruml/version.rb
    edit README.md

    git commit -m "Release X.Y.Z"

    rake release

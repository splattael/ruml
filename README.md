# ruml

Ruby mailing list software


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

* Write tests!

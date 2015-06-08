

IMEMINE: The Personal Preferences Repository
==========================================================

I just got sick of setting up different development machines and
having to pull together all my different preferences.  And also
having to find some way of backing up my preferences.  Hence this
repository.

It is unlikely to be useful directly to anybody other than myself,
but I have tried to comment and explain things as thoroughly as I
can, so you may find it useful into putting together your own
preferences.


Usage
------------------------------

Ultimately that will depend on this system you are trying to
configure.

Start with cloning the repository (or getting the tarball, although
it'll make updating harder).  Then it is mostly a case of setting
up symlinks from ~/imemine/filerc to ~/.filerc, although if there is
host specific config then you might need fancier stuff using
source statements etc.

This is automated by `SETUP.sh`.  It has a preview mode to set what
changes will be made without actually altering anything::

    $ ./SETUP.sh simulate

And then to make the changes::

    $ ./SETUP.sh install



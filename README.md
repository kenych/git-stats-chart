Simple git stats visualiser

Just run 
`./git-log-visualiser.sh $PATH_LOCAL_GIT_REPO`

If you get error:
`fatal: cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE`

here is a hix:

`brew reinstall --with-pcre git`

if you installed git not by brew:
`brew link --overwrite git`

#!/usr/bin/env bash

# Options:
# no option: install
# -u uninstall
# -d test dependencies

bashrc="$HOME/bashrc"

# Termux puts include/ share/ src/ on top level, directly below $PREFIX. To remedy this, we use $PREFIX2 (as specified below) for all subfolders of usr/ and $PREFIX1 for etc/ ...
PREFIX1="$PREFIX"
if [ "$PREFIX1" = /data/data/com.termux/files/usr ]; then
	PREFIX2=/data/data/com.termux/files
else
	PREFIX2="$PREFIX1"
fi

_warn() {
	echo >&2 ":: $*"
}

_prep_man() {
	# extend manpath via man.conf
	if ! grep -qs "$PREFIX2/usr/local/man" "$PREFIX1/etc/man.conf"; then
		if ! [ -s "$PREFIX1/etc/man.conf" ]; then
			cat - >> "$PREFIX1/etc/man.conf" << EOF
manpath $PREFIX2/usr/share/man
manpath $PREFIX2/usr/X11R6/man
EOF
		fi
		cat - >> "$PREFIX1/etc/man.conf" << EOF
manpath $PREFIX2/usr/local/man
EOF
	fi

	# update man db
	makewhatis
}

_prep_completion() {
	# add argument completion
	if ! grep -q "$PREFIX2/usr/local/bash-completion/completions/*" "$bashrc"; then
		echo 'for f in $PREFIX2/usr/local/bash-completion/completions/*; do [[ -f "$f" ]] && source "$f"; done' >> "$bashrc"
	fi

	# add man completion (add $PREFIX2/usr/local/man to bash completion)
	if [ -f "$PREFIX2/usr/share/bash-completion/completions/man" ]; then
		sed -i 's|local manpath="'"$PREFIX2"'/usr/share/man"|local manpath="'"$PREFIX2"'/usr/share/man:'"$PREFIX2"'/usr/local/man"|' "$PREFIX2/usr/share/bash-completion/completions/man"
	fi
}

uninst() {
	rm "$PREFIX2/usr/local/bin/thumbnail"
	rm "$PREFIX2/usr/local/man/man1/thumbnail.1.gz"
	rm "$PREFIX2/usr/local/bash-completion/completions/thumbnail"
}

check_deps() {
	(
		IFS=,
		while read cmd dep; do
			if ( ! which "$cmd" &>/dev/null ) && ( ! busybox which "$cmd" &>/dev/null ); then
				_warn "WARNING! $dep is not installed!"
			fi
		done < prep/install.deps.csv
	)
}

inst() {
	# install bash script, man file and bash completion
	install -D "thumbnail" "$PREFIX2/usr/local/bin/thumbnail"
	if [ -f "thumbnail.1.gz" ]; then
		install -D -m 0644 "thumbnail.1.gz" "$PREFIX2/usr/local/man/man1/thumbnail.1.gz"
		_prep_man
	fi
	if [ -f "completion" ]; then
		install -D -m 0644 "completion" "$PREFIX2/usr/local/bash-completion/completions/thumbnail"
		_prep_completion
	fi
}

main() {
	if [ "$1" = "-u" ]; then
		uninst
	elif [ "$1" = "-d" ]; then
		check_deps
	else
		inst
	fi
}

main "$@"

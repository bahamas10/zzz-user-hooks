.PHONY: all
all:
	@echo 'nothing to do'

.PHONY: install
install:
	cp user-script /etc/zzz.d
	cp hooks/resume/99-user-script /etc/zzz.d/resume
	cp hooks/suspend/99-user-script /etc/zzz.d/suspend

.PHONY: uninstall
uninstall:
	rm -f /etc/zzz.d/resume/99-user-script
	rm -f /etc/zzz.d/suspend/99-user-script
	rm -f /etc/zzz.d/user-script

.PHONY: check
check:
	awk 'length($$0) > 80 { exit(1); }' README.md
	awk 'length($$0) > 80 { exit(1); }' user-script
	shellcheck user-script
	shellcheck hooks/*/99-user-script

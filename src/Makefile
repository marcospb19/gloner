.DEFAULT_GOAL = gloner
.PHONY = clean
.PHONY = install

files = executable header.sh common.sh help.sh parse.sh check.sh clone.sh remote.sh gloner.sh


gloner: $(files)
	cp  executable       gloner
	@echo             >> gloner
	cat header.sh     >> gloner
	@echo             >> gloner
	cat common.sh     >> gloner
	@echo             >> gloner
	cat help.sh       >> gloner
	@echo             >> gloner
	cat parse.sh      >> gloner
	@echo             >> gloner
	cat check.sh      >> gloner
	@echo             >> gloner
	cat clone.sh      >> gloner
	@echo             >> gloner
	cat remote.sh     >> gloner
	@echo             >> gloner
	cat gloner.sh     >> gloner
	@echo

clean:
	@echo "rm gloner"
	@rm gloner 2> /dev/null ; exit 0

install: gloner
	@cp gloner /usr/bin/ 2> /dev/null                   \
		&& echo "Gloner installed, Thank you!"           \
		|| echo "You need permissions to install gloner!" \
		; exit 0

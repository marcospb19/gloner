.DEFAULT_GOAL = gloner
.PHONY = clean

files = header.sh functions.sh parse.sh gloner.sh


gloner: $(files)
	cp  executable       gloner
	echo              >> gloner
	cat header.sh     >> gloner
	echo              >> gloner
	cat functions.sh  >> gloner
	echo              >> gloner
	cat parse.sh      >> gloner
	echo              >> gloner
	cat gloner.sh     >> gloner

# You should run before every stable commit
copy: gloner
	mv gloner ../

clean:
	@echo "rm gloner"
	@rm gloner 2> /dev/null || exit 0

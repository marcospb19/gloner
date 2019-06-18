.DEFAULT_GOAL = gloner
.PHONY = clean

files = header.sh parse.sh gloner.sh


gloner: $(files)
	cp  executable   gloner
	cat header.sh >> gloner
	cat parse.sh  >> gloner
	cat gloner.sh >> gloner

# You should run before every commit
copy: gloner
	mv gloner ../

clean:
	@echo "rm gloner"
	@rm gloner 2> /dev/null || exit 0

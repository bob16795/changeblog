NIMSOURCES := $(shell find $(SOURCEDIR) -name '*.nim')
TMPLSOURCES := $(shell find $(SOURCEDIR) -name '*.tmpl')
HTMLSOURCES := $(shell find $(SOURCEDIR) -name '*.html')

main: $(NIMSOURCES) $(TMPLSOURCES) $(HTMLSOURCES)
	nim -d:ssl --threads:on c main.nim
run: main
	./main
clean:
	rm -f ./main
test: clean
	{ find . -name '*.nim'; find . -name '*.tmpl'; } | entr -r -s "make && ./main"
cleandb: main
	rm -f data/website.db data/keys.csv
	rm -f data/logs/*
	./main newdb
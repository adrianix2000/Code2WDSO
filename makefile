.PHONY: clean install
.SUFFIXES: .c .o .so .a .h

vpath %.c ./src
vpath %.so ./lib
vpath %.a ./lib
vpath %.h ./include

# katalogi w których zainstaluje program
INSTDIR=/usr/local/bin
LIBSPATH=/usr/lib

INCLUDE=./include

# regula przyrostkow do tworzenia plikow obiektowych
.c.o:
	gcc -c -I $(INCLUDE) $<

# reguly wzorcow do tworzenia bibliotek
lib%.a: %.o
	ar rs $@ $^
lib%.so: %.o
	gcc -shared -o $@ $^

# tworzenie plikow obiektowych
pole.o: pole.c
objetosc.o: objetosc.c
main.o: main.c

# tworzenie biblioteki statycznej
libpole.a: pole.o

#tworzenie biblioteki dynamicznej
libobjetosc.so: objetosc.o

Code2: main.o libpole.a libobjetosc.so
	gcc -o $@ $^

# instalacja programu w katalogach systemowych
install: Code2
	@if [ -d $(INSTDIR) ] && [ -d $(LIBSPATH) ]; \
		then \
		sudo cp Code2 $(INSTDIR) ;\
		sudo chmod a+x $(INSTDIR)/$< ;\
		sudo chmod og-w $(INSTDIR)/$< ;\
		sudo cp libobjetosc.so $(LIBSPATH) ;\
		echo "Zainstalowano pomyslnie program Code2 w $(INSTDIR)" ;\
	else \
		echo "nie udalo sie zainstalowac Code2 $(INSTDIR) lub $(LIBSPATH) nie istnieje";\
	fi
	mkdir lib
	mkdir bin
	mv libpole.a lib
	mv libobjetosc.so lib
	mv Code2 bin

clean:
	rm -rf lib
	rm -rf bin
	rm -f *.o
	rm -f *.so
	rm -f *.a
	sudo rm -f $(INSTDIR)/Code2
	sudo rm -f $(LIBSPATH)/libobjetosc.so
	echo "Pomyslnie usunieto pliki Code2"

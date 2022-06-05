.PHONY: clean install

# katalogi w których zainstaluje program
INSTDIR=/usr/local/bin
LIBSPATH=/usr/lib

# tworzenie plikow obiektowych
pole.o: pole.c
	gcc -c $<
objetosc.o: objetosc.c
	gcc -c $<
main.o: main.c
	gcc -c $<

# tworzenie biblioteki statycznej
libpole.a: pole.o
	ar rs $@ $<

#tworzenie biblioteki dynamicznej
libobjetosc.so: objetosc.o
	gcc -shared -o $@ $<

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

clean:
	rm -f *.o
	rm -f *.so
	rm -f *.a
	rm Code2
	sudo rm -f $(INSTDIR)/Code2
	sudo rm -f $(LIBSPATH)/libobjetosc.so
	echo "Pomyslnie usunieto pliki Code2"

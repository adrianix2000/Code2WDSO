.PHONY: clean install


# tworzenie plikow obiektowych
pole.o: pole.c
	gcc -c pole.c
objetosc.o: objetosc.c
	gcc -c objetosc.c
main.o: main.c
	gcc -c main.c

# tworzenie biblioteki statycznej
libpole.a: pole.o
	ar rs libpole.a pole.o

#tworzenie biblioteki dynamicznej
libobjetosc.so: objetosc.o
	gcc -shared -o libobjetosc.so objetosc.o

Code2: main.o libpole.a libobjetosc.so
	gcc -o Code2 main.o libpole.a libobjetosc.so

# instalacja programu w katalogach systemowych
install: Code2
	@if [ -d /usr/local/bin ] && [ -d /usr/lib ]; \
		then \
		sudo cp Code2 /usr/local/bin ;\
		sudo chmod a+x /usr/local/bin/Code2 ;\
		sudo chmod og-w /usr/local/bin/Code2 ;\
		sudo cp libobjetosc.so /usr/lib ;\
		echo "Zainstalowano pomyslnie program Code2 w /usr/local/bin" ;\
	else \
		echo "nie udalo sie zainstalowac Code2 /usr/local/bin lub /usr/lib nie istnieje";\
	fi

clean:
	rm -f *.o
	rm -f *.so
	rm -f *.a
	sudo rm -f /usr/loca/bin/Code2
	sudo rm -f /usr/lib/libobjetosc.so
	echo "Pomyslnie usunieto pliki Code2"

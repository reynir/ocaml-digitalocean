OCAMLBUILD=ocamlbuild -use-ocamlfind

add_www.native: examples/add_www.ml
	${OCAMLBUILD} examples/add_www.native

remove_www.native: examples/remove_www.ml
	${OCAMLBUILD} examples/remove_www.native

remove_gmail.native: examples/remove_gmail.ml
	${OCAMLBUILD} examples/remove_gmail.native

digitalocean.cma: src/digitalocean.ml src/digitalocean.mllib
	${OCAMLBUILD} src/digitalocean.cma

digitalocean.top: src/digitalocean.ml src/digitalocean.mltop
	${OCAMLBUILD} src/digitalocean.top

clean:
	rm -rf _build/ 
	rm -f add_www.native
	rm -f remove_www.native
	rm -f remove_gmail.native

OCAMLBUILD=ocamlbuild -use-ocamlfind

add_www.native: examples/add_www.ml
	${OCAMLBUILD} examples/add_www.native

remove_www.native: examples/remove_www.ml
	${OCAMLBUILD} examples/remove_www.native

digitalocean.cma: src/digitalocean.ml src/digitalocean.mllib
	${OCAMLBUILD} src/digitalocean.cma

clean:
	rm -rf _build/ 
	rm -f add_www.native remove_www.native

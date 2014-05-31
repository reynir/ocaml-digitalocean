OCAMLBUILD=ocamlbuild -use-ocamlfind

all: add_www.native remove_www.native remove_gmail.native digitalocean.cma digitalocean.top myutop.top

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

myutop.top: src/digitalocean.ml src/myutop.mltop src/myutop_main.ml
	${OCAMLBUILD} -pkgs utop,threads src/myutop.top

clean:
	${OCAMLBUILD} -clean

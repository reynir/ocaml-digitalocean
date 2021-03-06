DigitalOcean API client
=======================

A DigitalOcena API client library written in OCaml.

## Toplevel ##

There is a omake target to make a custom ocaml toplevel REPL. To build it run
the following:

    omake top

This should produce a binary file `top`. To run the toplevel REPL you must
provide `-I /path/to/digitalocean.cmi` as an argument. Example:

    $ ./top -I src/
            OCaml version 4.00.1
    
    # Digitalocean.droplets { ApiKey_t.id = "The client ID";
                              ApiKey_t.key = "The super secret key" };;

## TODO ##

- [x] Implement the rest of the API.
- [x] Better types for the function arguments.
- [ ] A command line utility instead of the current "test" program.
- [x] Make all functions return Json instead of string (?)
- [ ] List of dependencies
- [ ] Declare types for each response using atdgen to make the responses easier
      to work with.

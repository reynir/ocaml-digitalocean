module Json = Yojson.Safe
open Http_client.Convenience
open Util
module DO = Digitalocean

let pretty json =
  Json.pretty_to_string json

let () =
  let () = DO.init () in
  let api = load_api_from_file "../do.json" in
  let droplets = DO.droplets_raw api in
  let domains = DO.domains_raw api in
  print_endline droplets;
  print_endline domains

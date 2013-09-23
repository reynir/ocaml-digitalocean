module Json = Yojson.Safe
open Http_client.Convenience
open Util
module DO = Digitalocean

let pretty json =
  Json.pretty_to_string json

let () =
  let () = DO.init () in
  let api = load_api_from_file "../do.json" in
  let droplets = DO.droplets api in
  let regions = DO.regions api in
  print_endline (pretty droplets);
  print_endline (pretty regions);
  print_endline (pretty (DO.domains api))

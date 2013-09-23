module Json = Yojson.Safe
open Http_client.Convenience

let pretty json =
  Json.pretty_to_string json

let () =
  let () = Digitalocean.init () in
  let api = Util.load_api_from_file "../do.json" in
  let droplets = Digitalocean.droplets api in
  let regions = Digitalocean.regions api in
  print_endline (pretty droplets);
  print_endline (pretty regions);
  print_endline (pretty (Digitalocean.domains api))

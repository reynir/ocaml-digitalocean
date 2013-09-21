module Json = Yojson.Safe
open Http_client.Convenience

let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = String.create n in
  really_input ic s 0 n;
  close_in ic;
  s


let () =
  let () = Digitalocean.init () in
  let api = ApiKey_j.api_of_string (load_file "../do.json") in
  let droplets = Digitalocean.droplets api in
  let regions = Digitalocean.regions api in
  print_endline (Json.pretty_to_string (Json.from_string droplets));
  print_endline (Json.pretty_to_string (Json.from_string regions))

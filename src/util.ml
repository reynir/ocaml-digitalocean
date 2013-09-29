let load_api_from_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = String.create n in
  really_input ic s 0 n;
  close_in ic;
  ApiKey_j.api_of_string s

let pretty json = print_endline (Yojson.Safe.pretty_to_string json)

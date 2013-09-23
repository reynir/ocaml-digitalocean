

val request : ApiKey_t.api -> string -> (string * string) list -> Yojson.Safe.json

val init : unit -> unit

val droplets : ApiKey_t.api -> Yojson.Safe.json
val new_droplet : ApiKey_t.api ->
  ?priv:bool -> string -> int -> int -> int -> int list -> Yojson.Safe.json
val get_droplet : ApiKey_t.api -> int -> Yojson.Safe.json
val reboot_droplet : ApiKey_t.api -> int -> Yojson.Safe.json
val power_cycle_droplet : ApiKey_t.api -> int -> Yojson.Safe.json
val shutdown_droplet : ApiKey_t.api -> int -> Yojson.Safe.json
val power_off_droplet : ApiKey_t.api -> int -> Yojson.Safe.json
val power_on_droplet : ApiKey_t.api -> int -> Yojson.Safe.json
val reset_password : ApiKey_t.api -> int -> Yojson.Safe.json
val resize_droplet : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val snapshot_droplet : ApiKey_t.api -> ?name:string -> int -> Yojson.Safe.json
val restore_droplet : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val rebuild_droplet : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val enable_backups : ApiKey_t.api -> int -> Yojson.Safe.json
val disable_backups : ApiKey_t.api -> int -> Yojson.Safe.json
val rename_droplet : ApiKey_t.api -> int -> string -> Yojson.Safe.json
val destroy_droplet : ApiKey_t.api -> ?scrub:bool -> int -> Yojson.Safe.json
val regions : ApiKey_t.api -> Yojson.Safe.json
val images : ?filter:string -> ApiKey_t.api -> Yojson.Safe.json
val get_image : ApiKey_t.api -> int -> Yojson.Safe.json
val destroy_image : ApiKey_t.api -> int -> Yojson.Safe.json
val transfer_image : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val ssh_keys : ApiKey_t.api -> Yojson.Safe.json
val new_ssh_key : ApiKey_t.api -> string -> string -> Yojson.Safe.json
val get_ssh_key : ApiKey_t.api -> int -> Yojson.Safe.json
val edit_ssh_key : ApiKey_t.api -> int -> string -> Yojson.Safe.json
val destroy_ssh_key : ApiKey_t.api -> int -> Yojson.Safe.json
val sizes : ApiKey_t.api -> Yojson.Safe.json
val domains : ApiKey_t.api -> Yojson.Safe.json
val new_domain : ApiKey_t.api -> string -> string -> Yojson.Safe.json
val get_domain : ApiKey_t.api -> int -> Yojson.Safe.json
val destroy_domain : ApiKey_t.api -> int -> Yojson.Safe.json
val get_domain_records : ApiKey_t.api -> int -> Yojson.Safe.json
val new_CNAME : ApiKey_t.api -> int -> string -> string -> Yojson.Safe.json
val new_A : ApiKey_t.api -> int -> string -> string -> Yojson.Safe.json
val new_MX : ApiKey_t.api  -> int -> int -> string -> Yojson.Safe.json
val new_TXT : ApiKey_t.api -> int -> string -> string -> Yojson.Safe.json
val new_NS : ApiKey_t.api -> int -> string -> Yojson.Safe.json
val new_SRV : ApiKey_t.api -> int -> string -> string -> int -> int -> int -> Yojson.Safe.json

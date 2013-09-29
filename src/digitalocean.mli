exception Error of Responses_t.error

val request : ApiKey_t.api -> string -> (string * string) list -> string
val debug : bool ref

val init : unit -> unit

val droplets : ApiKey_t.api -> Responses_t.droplet list
val get_droplet : ApiKey_t.api -> int -> Responses_t.droplet
val reboot_droplet : ApiKey_t.api -> int -> Responses_t.event
val power_cycle_droplet : ApiKey_t.api -> int -> Responses_t.event
val shutdown_droplet : ApiKey_t.api -> int -> Responses_t.event
val power_off_droplet : ApiKey_t.api -> int -> Responses_t.event
val power_on_droplet : ApiKey_t.api -> int -> Responses_t.event
val reset_password : ApiKey_t.api -> int -> Responses_t.event
val resize_droplet : ApiKey_t.api -> int -> int -> Responses_t.event
val snapshot_droplet : ApiKey_t.api -> ?name:string -> int -> Responses_t.event
val restore_droplet : ApiKey_t.api -> int -> int -> Responses_t.event
val rebuild_droplet : ApiKey_t.api -> int -> int -> Responses_t.event
val enable_backups : ApiKey_t.api -> int -> Responses_t.event
val disable_backups : ApiKey_t.api -> int -> Responses_t.event
val rename_droplet : ApiKey_t.api -> int -> string -> Responses_t.event
val destroy_droplet : ApiKey_t.api -> ?scrub:bool -> int -> Responses_t.event
val regions : ApiKey_t.api -> Responses_t.region list
val images : ?filter:string -> ApiKey_t.api -> Responses_t.image list
val get_image : ApiKey_t.api -> int -> Responses_t.image
val destroy_image : ApiKey_t.api -> int -> unit
val transfer_image : ApiKey_t.api -> int -> int -> unit
val ssh_keys : ApiKey_t.api -> Responses_t.ssh_keys_elt list
val new_ssh_key : ApiKey_t.api -> string -> string -> Responses_t.ssh_key
val get_ssh_key : ApiKey_t.api -> int -> Responses_t.ssh_key
val edit_ssh_key : ApiKey_t.api -> int -> string -> Responses_t.ssh_key
val destroy_ssh_key : ApiKey_t.api -> int -> unit
val sizes : ApiKey_t.api -> Responses_t.size list
val domains : ApiKey_t.api -> Responses_t.domain list
val get_domain : ApiKey_t.api -> int -> Responses_t.domain
val new_domain : ApiKey_t.api -> string -> string -> Responses_t.new_domain
val destroy_domain : ApiKey_t.api -> int -> unit
val get_domain_records : ApiKey_t.api -> int -> Responses_t.record list
val get_domain_record : ApiKey_t.api -> int -> int -> Responses_t.record
val new_CNAME : ApiKey_t.api -> int -> string -> string -> Responses_t.record
val new_A : ApiKey_t.api -> int -> string -> string -> Responses_t.record
val new_MX : ApiKey_t.api -> int -> int -> string -> Responses_t.record
val new_TXT : ApiKey_t.api -> int -> string -> string -> Responses_t.record
val new_NS : ApiKey_t.api -> int -> string -> Responses_t.record
val new_SRV : ApiKey_t.api -> int -> string -> string -> int -> int -> int -> Responses_t.record

val droplets_raw : ApiKey_t.api -> string
val new_droplet_raw : ApiKey_t.api ->
  ?priv:bool -> string -> int -> int -> int -> int list -> string
val get_droplet_raw : ApiKey_t.api -> int -> string
val reboot_droplet_raw : ApiKey_t.api -> int -> string
val power_cycle_droplet_raw : ApiKey_t.api -> int -> string
val shutdown_droplet_raw : ApiKey_t.api -> int -> string
val power_off_droplet_raw : ApiKey_t.api -> int -> string
val power_on_droplet_raw : ApiKey_t.api -> int -> string
val reset_password_raw : ApiKey_t.api -> int -> string
val resize_droplet_raw : ApiKey_t.api -> int -> int -> string
val snapshot_droplet_raw : ApiKey_t.api -> ?name:string -> int -> string
val restore_droplet_raw : ApiKey_t.api -> int -> int -> string
val rebuild_droplet_raw : ApiKey_t.api -> int -> int -> string
val enable_backups_raw : ApiKey_t.api -> int -> string
val disable_backups_raw : ApiKey_t.api -> int -> string
val rename_droplet_raw : ApiKey_t.api -> int -> string -> string
val destroy_droplet_raw : ApiKey_t.api -> ?scrub:bool -> int -> string
val regions_raw : ApiKey_t.api -> string
val images_raw : ?filter:string -> ApiKey_t.api -> string
val get_image_raw : ApiKey_t.api -> int -> string
val destroy_image_raw : ApiKey_t.api -> int -> string
val transfer_image_raw : ApiKey_t.api -> int -> int -> string
val ssh_keys_raw : ApiKey_t.api -> string
val new_ssh_key_raw : ApiKey_t.api -> string -> string -> string
val get_ssh_key_raw : ApiKey_t.api -> int -> string
val edit_ssh_key_raw : ApiKey_t.api -> int -> string -> string
val destroy_ssh_key_raw : ApiKey_t.api -> int -> string
val sizes_raw : ApiKey_t.api -> string
val domains_raw : ApiKey_t.api -> string
val new_domain_raw : ApiKey_t.api -> string -> string -> string
val get_domain_raw : ApiKey_t.api -> int -> string
val destroy_domain_raw : ApiKey_t.api -> int -> string
val get_domain_records_raw : ApiKey_t.api -> int -> string
val get_domain_record_raw : ApiKey_t.api -> int -> int -> string
val new_CNAME_raw : ApiKey_t.api -> int -> string -> string -> string
val new_A_raw : ApiKey_t.api -> int -> string -> string -> string
val new_MX_raw : ApiKey_t.api  -> int -> int -> string -> string
val new_TXT_raw : ApiKey_t.api -> int -> string -> string -> string
val new_NS_raw : ApiKey_t.api -> int -> string -> string
val new_SRV_raw : ApiKey_t.api -> int -> string -> string -> int -> int -> int -> string

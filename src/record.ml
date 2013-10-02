type record_A =
  { record_A_name : string;
    record_A_ip : string; }
type record_CNAME =
  { record_CNAME_name : string;
    record_CNAME_hostname : string; }
type record_MX =
  { record_MX_hostname : string;
    record_MX_priority : int; }
type record_TXT =
  { record_TXT_name : string;
    record_TXT_data : string; }
type record_NS =
  { record_NS_ns : string; }
type record_SRV =
  { record_SRV_name : string;
    record_SRV_hostname : string;
    record_SRV_priority : int;
    record_SRV_port : int;
    record_SRV_weight : int; }

type record =
| A of int * int * record_A
| CNAME of int * int * record_CNAME
| MX of int * int * record_MX
| TXT of int * int * record_TXT
| NS of int * int * record_NS
| SRV of int * int * record_SRV

let record_of_responses_record (r : Responses_t.record) : record =
  match r with
  | { Responses_t.record_id = id;
      Responses_t.record_domain_id = domain_id;
      Responses_t.record_type = "A";
      Responses_t.record_name = Some name;
      Responses_t.record_data = ip } ->
    A (domain_id, id, { record_A_name = name; record_A_ip = ip })
  | { Responses_t.record_id = id;
      Responses_t.record_domain_id = domain_id;
      Responses_t.record_type = "CNAME";
      Responses_t.record_name = Some name;
      Responses_t.record_data = hostname } ->
    CNAME (domain_id, id, { record_CNAME_name = name;
			    record_CNAME_hostname = hostname })
  | { Responses_t.record_id = id;
      Responses_t.record_domain_id = domain_id;
      Responses_t.record_type = "MX";
      Responses_t.record_data = hostname;
      Responses_t.record_priority = Some priority } ->
    MX (domain_id, id, { record_MX_hostname = hostname;
	      record_MX_priority = priority })
  | { Responses_t.record_id = id;
      Responses_t.record_domain_id = domain_id;
      Responses_t.record_type = "TXT";
      Responses_t.record_name = Some name;
      Responses_t.record_data = data } ->
    TXT (domain_id, id, { record_TXT_name = name;
			  record_TXT_data = data })
  | { Responses_t.record_id = id;
      Responses_t.record_domain_id = domain_id;
      Responses_t.record_type = "NS";
      Responses_t.record_data = ns } ->
    NS (domain_id, id, { record_NS_ns = ns })
  | { Responses_t.record_id = id;
      Responses_t.record_domain_id = domain_id;
      Responses_t.record_type = "SRV";
      Responses_t.record_name = Some name;
      Responses_t.record_data = hostname;
      Responses_t.record_priority = Some priority;
      Responses_t.record_port = Some port;
      Responses_t.record_weight = Some weight } ->
    SRV (domain_id, id, { record_SRV_name = name;
			  record_SRV_hostname = hostname;
			  record_SRV_priority = priority;
			  record_SRV_port = port;
			  record_SRV_weight = weight })
  | _ -> failwith "Bad record"

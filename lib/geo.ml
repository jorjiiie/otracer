(** geo.ml *)

type vec3 = Core.vec3
type ray = Core.ray
type material = Blue | Red
type shape = Sphere of (vec3 * float)
type primitive = material * shape
type hit_info = { pos : vec3; mat : material }

let sphere_intersect (o, d) (p, r) =
  let a = Core.vec3_norm_sq d in
  let b = -2. *. Core.vec3_dot d (Core.vec3_sub p o) in
  let sb = Core.vec3_sub p o in
  let c = Core.vec3_dot sb sb -. (r *. r) in
  let disc = (b *. b) -. (4. *. a *. c) in
  if disc < 0. then None
  else
    let ins = sqrt disc in
    let s1 = (-.b -. ins) /. (2. *. a) in
    if s1 >= 0. then Some s1
    else
      let s2 = (-.b +. ins) /. (2. *. a) in
      Some s2

let intersect r (m, obj) =
  let int_t =
    match obj with
    | Sphere s -> sphere_intersect r s
    | _ -> failwith "i dont support any other shapes D:"
  in
  let o, d = r in
  if Option.is_some int_t then
    Some
      { pos = Core.vec3_add (Core.vec3_scale (Option.get int_t) d) o; mat = m }
  else None

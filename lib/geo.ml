open Core
(** geo.ml *)

type vec3 = Core.vec3
type ray = Core.ray
type mat_opt = TMatte | TLight
type material = Matte of pixel | Light of pixel

let material_att = function Matte p -> p | Light _ -> pix_make 1.0 1.0 1.0
let material_emit = function Light p -> p | _ -> pix_broadcast 0.
let make_material t c = match t with TMatte -> Matte c | TLight -> Light c

let rec random_sphere _ =
  let x = Random.float 2. -. 1. in
  let y = Random.float 2. -. 1. in
  let z = Random.float 2. -. 1. in
  if (x *. x) +. (y *. y) +. (z *. z) >= 1. then random_sphere 69
  else vec3_make x y z

let matte_sample (o, d) n =
  let v = random_sphere 69 in
  vec3_unit (v ++ n)

let material_sample m r n = match m with Matte _ | Light _ -> matte_sample r n

type shape = Sphere of (vec3 * float)
type primitive = material * shape
type hit_info = { pos : vec3; mat : material; time : float; normal : vec3 }

let shape_normal s v =
  match s with
  | Sphere (o, r) -> (1. /. r) ** (v -- o)
  | _ -> failwith "no more shapes "

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
  match int_t with
  | None -> None
  | Some t ->
      Some
        {
          pos = (t ** d) ++ o;
          mat = m;
          time = t;
          normal = shape_normal obj ((t ** d) ++ o);
        }

type world = primitive list

let make_world lst = lst

(* world -> ray -> Option*)
let rec world_intersect (w : world) (r : ray) (time : float)
    (b : hit_info option) : hit_info option =
  match w with
  | [] -> b
  | h :: t -> (
      match intersect r h with
      | None -> world_intersect t r time b
      | Some { pos = p; mat = m; time = tm; normal = n } as hit ->
          if tm < time then world_intersect t r tm hit
          else world_intersect t r time b)

let rec bounce w r b =
  if b <= 0 then Core.pix_broadcast 0.
  else
    match world_intersect w r max_float None with
    | None -> pix_make 0.2 0.4 0.4
    | Some { pos = p; mat = m; time = t; normal = n } as hit ->
        (* if inside u should really flip the normal here *)
        let new_ray = (p ++ (0.00001 ** n), material_sample m r n) in
        let col = (bounce w new_ray (b-1)) in 
        pix_add (material_emit m)
          (pix_mul (material_att m) col)

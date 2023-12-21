type vec3 = { x : float; y : float; z : float }

let float_cmp a b = abs_float (a -. b) < 0.000001
let vec3_make a b c = { x = a; y = b; z = c }
let vec3_broadcast a = { x = a; y = a; z = a }
let vec3_comp { x = a; y = b; z = c } = (a, b, c)

let vec3_dot v1 v2 =
  let x1, y1, z1 = vec3_comp v1 in
  let x2, y2, z2 = vec3_comp v2 in
  (x1 *. x2) +. (y1 *. y2) +. (z1 *. z2)

let vec3_combine f u v = { x = f u.x v.x; y = f u.y v.y; z = f u.z v.z }
let vec3_add u v = vec3_combine ( +. ) u v
let vec3_sub u v = vec3_combine ( -. ) u v
let vec3_mul u v = vec3_combine ( *. ) u v
let vec3_map f v = { x = f v.x; y = f v.y; z = f v.z }
let vec3_scale s v = vec3_map (fun x -> s *. x) v
let vec3_neg v = vec3_map (fun x -> -.x) v
let ( @@ ) = vec3_dot
let ( ++ ) = vec3_add
let ( -- ) = vec3_sub
let ( ** ) = vec3_scale
let vec3_norm_sq v = v @@ v
let vec3_norm v = sqrt (v @@ v)
let vec3_dist_sq u v = vec3_norm_sq (u -- v)
let vec3_dist u v = vec3_norm (u -- v)
let vec3_unit v = (1.0 /. vec3_norm v) ** v

let vec3_cross u v =
  {
    x = (u.y *. v.z) -. (u.z *. v.y);
    y = (u.z *. v.x) -. (u.x *. v.z);
    z = (u.x *. v.y) -. (u.y *. v.x);
  }

type ray = vec3 * vec3
type pixel = { r : float; g : float; b : float }

let pix_make x y z = { r = x; g = y; b = z }
let pix_broadcast a = { r = a; g = a; b = a }
let vec3_of_pixel p = { x = p.r; y = p.g; z = p.b }
let pixel_of_vec3 v = { r = v.x; g = v.y; b = v.z }
let pix_binop f u v = pixel_of_vec3 (f (vec3_of_pixel u) (vec3_of_pixel v))
let pix_add x y = pix_binop vec3_add x y
let pix_scale r v = pix_binop vec3_mul v (pix_broadcast r)
let pix_mul a b = pix_binop vec3_mul a b

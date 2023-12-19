type vec3 = { x : float; y : float; z : float }

let float_cmp a b = abs_float (a -. b) < 0.000001
let make_vec3 a b c = { x = a; y = b; z = c }
let vec3_comp { x = a; y = b; z = c } = (a, b, c)

let vec3_dot v1 v2 =
  let x1, y1, z1 = vec3_comp v1 in
  let x2, y2, z2 = vec3_comp v2 in
  (x1 *. x2) +. (y1 *. y2) +. (z1 *. z2)

let vec3_add v1 v2 =
  let x1, y1, z1 = vec3_comp v1 in
  let x2, y2, z2 = vec3_comp v2 in
  { x = x1 +. x2; y = y1 +. y2; z = z1 +. z2 }

let vec3_sub v1 v2 =
  let x1, y1, z1 = vec3_comp v1 in
  let x2, y2, z2 = vec3_comp v2 in
  { x = x1 -. x2; y = y1 -. y2; z = z1 -. z2 }

let vec3_scale s v =
  let a, b, c = vec3_comp v in
  { x = s *. a; y = s *. b; z = s *. c }

let vec3_neg v =
  let a, b, c = vec3_comp v in
  { x = -.a; y = -.b; z = -.c }

let ( @@ ) = vec3_dot
let ( ++ ) = vec3_add
let ( -- ) = vec3_sub
let ( ** ) = vec3_scale
let vec3_norm_sq v = v @@ v
let vec3_norm v = sqrt (v @@ v)

open Core
(** cam.ml *)

type cameraMode = Perspective | Orthographic

(* probably better to just make a perspective camera here lol *)
type camera = {
  mode : cameraMode;
  origin : Core.vec3;
  lookAt : Core.vec3;
  up : Core.vec3;
  lowerLeft : Core.vec3;
  fov : float;
  width : int;
  height : int;
  d_v : float;
  v : Core.vec3;
}

let make_camera m o l u f w h =
  let width = float_of_int w in
  let height = float_of_int h in
  let d = Core.vec3_unit (Core.vec3_sub l o) in
  let v = Core.vec3_cross d u in
  (* foc would be the focal distance *)
  let d_v = 2.0 *. Float.tan (f /. 360. *. Float.pi) /. width in
  {
    mode = m;
    origin = o;
    lookAt = l;
    up = u;
    lowerLeft =
      d -- (((width *. d_v /. 2.) ** v) ++ ((height *. d_v /. 2.0) ** u));
    fov = f;
    width = w;
    height = h;
    d_v;
    v;
  }

let perspective_ray cam x_i y_i =
  let x = float_of_int x_i in
  let y = float_of_int y_i in
  let look =
    vec3_unit
      (cam.lowerLeft
      ++ (((x +. Random.float 1.) *. cam.d_v) ** cam.v)
      ++ (((y +. Random.float 1.) *. cam.d_v) ** cam.up))
  in
  (cam.origin, look)

(* we do not support blur/apeture rn *)
let get_ray cam x_i y_i =
  match cam.mode with
  | Perspective -> perspective_ray cam x_i y_i
  | _ -> failwith "no bueno :("

(* this really should match with PerspectiveCamera but whatever *)

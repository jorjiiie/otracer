(** cam.mli *)
type cameraMode =
  | Perspective
  | Orthographic  (** defines type of camera modes *)

type camera
(** generic camera type *)

val make_camera :
  cameraMode ->
  Core.vec3 ->
  Core.vec3 ->
  Core.vec3 ->
  float ->
  int ->
  int ->
  camera
(** [make_camera m o l u f w h] makes a camera with mode [m], origin [o], pointed at [l], with up direction [u], fov [f] with width [w] and height [h]*)
(* doesn't have focal distance yet but that's a pain
   , this would be better if we just passed in options but whatever *)

val get_ray : camera -> int -> int -> Core.ray
(** [get_ray c x y] gets the ray from [c] at canvas position ([x], [y]) *)

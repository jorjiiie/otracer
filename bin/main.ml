open Otracer.Image_io
open Otracer.Core
open Otracer.Geo
open Otracer.Cam
open List

let () = print_endline "Hello, World!"


(*
let pixs =
  init 250000 (fun x ->
      {
        r = 0.2;
        g = float_of_int (x / opts.width) /. float_of_int opts.height;
        b = 0.5;
      })
      *)
let () = Random.init 69
let s1 = Sphere (vec3_make 2.0 0. 0., 0.5)
let s2 = Sphere (vec3_make 2.0 0.  1., 0.25)
let mat1 = make_material TLight (pix_broadcast 1.)
let mat2 = make_material TMatte (pix_make 0.8 0.3 0.3)
let prim1 = (mat1, s1)
let w = make_world [prim1; (mat2,s2)]
let width = 500
let height = 600
let cam = make_camera Perspective (vec3_broadcast 0.) (vec3_make 1. 0. 0.)
  (vec3_make 0. 0. 1.) 90. width height


let run_samples w cam n_samples = 
  let build_lst _ = init (width * height) (fun x -> get_ray cam (x mod width) (x / width)) in 
  let eval lst = map (fun r -> bounce w r 5) lst in 
  let samps = map eval (init n_samples (fun x -> build_lst 0)) in  
  fold_left (fun a b -> map2 pix_add a b) (init (width*height) (fun _ -> pix_broadcast 0.)) samps 
  |> map (fun px -> pix_scale (1. /. (float_of_int n_samples)) px) 


let z = run_samples w cam 50

let opts = { width = width; height = height; gamma = 0.5 }
let () = write_img opts "hi.ppm" z

open Otracer.Image_io
open Otracer.Core
open List

let () = print_endline "Hello, World!"
let opts = { width = 500; height = 500; gamma = 0.5 }

let pixs =
  init 250000 (fun x ->
      {
        r = 0.2;
        g = float_of_int (x / opts.width) /. float_of_int opts.height;
        b = 0.5;
      })

let () = write_img opts "hi.ppm" pixs

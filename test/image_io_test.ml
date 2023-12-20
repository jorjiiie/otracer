open OUnit2
open Otracer.Image_io
open Otracer.Core
open List

let opts = { width = 5; height = 5; gamma = 1. }
let pixs = init 25 (fun _ -> { r = 0.5; g = 0.5; b = 0.5 })
let test_write = write_img opts "hi.ppm" pixs
let tests = "test suite for core" >::: [ ("something" >:: fun _ -> test_write) ]

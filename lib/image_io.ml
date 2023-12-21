(* image_io.ml *)
open Printf
open List

type imageWriter = { width : int; height : int; gamma : float }
type pixel = Core.pixel
type inxel = { ir : int; ig : int; ib : int }

let clamp x mn mx = 
  max mn (min mx x)

let inxel_of_pixel (p : pixel) : inxel =
  {
    ir = clamp (int_of_float (p.r *. 255.)) 0 255;
    ig = clamp (int_of_float (p.g *. 255.)) 0 255;
    ib = clamp (int_of_float (p.b *. 255.)) 0 255;
  }

let comp_map (f : float -> float) ({ r = x; g = y; b = z } : pixel) : pixel =
  { r = f x; g = f y; b = f z }

let correct_pix (p : pixel) g =
  inxel_of_pixel (comp_map (fun x -> Float.pow x g) p)

let print_pix oc { ir = r; ig = g; ib = b } = fprintf oc "%d %d %d\n" r g b

let write_img { width; height; gamma } file pixels =
  assert (List.length pixels = width * height);
  let oc = open_out file in
  let new_pix = map (fun px -> correct_pix px gamma) pixels in
  fprintf oc "P3 %d %d\n255\n" width height;
  iter (fun px -> print_pix oc px) new_pix

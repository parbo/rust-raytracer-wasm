extern crate cfg_if;
extern crate wasm_bindgen;
extern crate rust_raytracer;
extern crate js_sys;

mod utils;

use wasm_bindgen::prelude::*;
use std::rc::Rc;

struct JsRenderer {
    put_pixel_function: js_sys::Function
}

impl JsRenderer {
    fn new(put_pixel: js_sys::Function) -> JsRenderer {
        JsRenderer {
            put_pixel_function: put_pixel
        }
    }
}

impl rust_raytracer::render::Renderer for JsRenderer {
    fn put_pixel(&mut self, x: i64, y: i64, p: rust_raytracer::render::Pixel) {
        let this = JsValue::NULL;
        let jsx = JsValue::from(x as u32);
        let jsy = JsValue::from(y as u32);
        let [r, g, b] = p;
        let jsr = JsValue::from(r);
        let jsg = JsValue::from(g);
        let jsb = JsValue::from(b);
        let mut jsarr = js_sys::Array::new();
        jsarr.push(&jsx);
        jsarr.push(&jsy);
        jsarr.push(&jsr);
        jsarr.push(&jsg);
        jsarr.push(&jsb);
        let _ = self.put_pixel_function.apply(&this, &jsarr);
    }
}

#[wasm_bindgen]
pub fn render_gml(gml: &str, put_pixel: js_sys::Function) {
    let renderer = Box::new(JsRenderer::new(put_pixel));
    rust_raytracer::render::set_renderer(renderer);
    rust_raytracer::render::render_gml(gml);
}

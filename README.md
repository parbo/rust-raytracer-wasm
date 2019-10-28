# wasm raytracer

I got this up and running by copying what was done here: [https://github.com/migerh/rustwasm-gif](https://github.com/migerh/rustwasm-gif)

The regular wasm-pack workflow doesn't support web workers just yet.

## Try it

[https://rust-raytracer-wasm.now.sh/](https://rust-raytracer-wasm.now.sh/)

Click on `snowgoon.gml` or `chess.gml` for nice example images.

## Building

### Prerequisites

```sh
# install wasm-bindgen command line tools
cargo install wasm-bindgen-cli
```

### Build the project

To build the project you have to compile the rust code to a wasm module,
install a few JavaScript tools and libraries and then you can start the webpack
dev server:

```sh
npm run build

# install javascript dependencies
npm install

# run dev server
npm run serve
```

Now you can open your browser and go to <http://localhost:8080>.

## Deploy the project

### Prerequisites

```sh
# install now-cli
npm install -g now
```

### Deploy

```sh
now --prod
```

## License

This project is licensed under the MIT license.

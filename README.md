# wasm raytracer

I got this up and running by copying what was done here: https://raw.githubusercontent.com/migerh/rustwasm-gif

The regular wasm-pack workflow doesn't support web workers just yet.

## Building

### Prerequisites

```sh
# install & switch to the nightly channel
rustup install nightly
rustup default nightly

# install wasm-bindgen command line tools
cargo install wasm-bindgen-cli
```

### Build the project

To build the project you have to compile the rust code to a wasm module,
install a few JavaScript tools and libraries and then you can start the webpack
dev server:

```sh
npm run build-wasm

# install javascript dependencies
npm install

# run dev server
npm run serve
```

Now you can open your browser and go to <http://localhost:8080>.

## License

This project is licensed under the MIT license.

# dartfmt plugin for `micro`

Plugin for the [micro editor](https://github.com/zyedidia/micro) that provides support for:

- `dart format` on save
- `dart analyze` integration with the official linter plugin

for [Dart](https://github.com/dart-lang) files.

## Installation

You can install the plugin in two ways:

### 1. Manually install by cloning this repo as `dartfmt` into your `plug` directory:
   ```sh
   git clone https://github.com/plinkr/micro-dartfmt ~/.config/micro/plug/dartfmt
   ```

### 2. Download the zip release and copy it to the `plug` directory:
   - Download the [zip release](https://github.com/plinkr/micro-dartfmt/archive/v0.1.0.zip).
   - Extract the zip file.
   - Copy the extracted `micro-dartfmt-0.1.0` directory to your `~/.config/micro/plug/` directory and rename it to `dartfmt`:
     ```sh
     unzip v0.1.0.zip
     mv micro-dartfmt-0.1.0 ~/.config/micro/plug/dartfmt
     ```

3. Restart the Micro editor.

## Usage

The plugin requires the `dart` command-line utility in your `$PATH`.

See [the help file](help/dartfmt.md)

Or, after installation, from within micro:

```
> help dartfmt
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any improvements or suggestions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

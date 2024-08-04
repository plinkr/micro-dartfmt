# dart format and linter plugin

The `dartfmt` plugin provides formating and linting for dart files using **micro**.

To format the current file using `dart format` you can run:

```
> dartfmt
```

To run `dart analyze` on the current file (using the linter plugin):

```
> lint
```

To automatically run these when you save the file, use the following
options:

* `dartfmt.fmt`: run `dart format` on file saved (will report parse errors). Default value: `on`
* `dartfmt.lint`: enable `dart analyze` integration with the linter plugin. Default value: `on`

# build-action

This action compile the 4D database.

## Usage

Create a [workflow file](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions) `.github/workflows/build.yml` in your project.

```yml
name: build

on:
  push:
  pull_request:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Action
        uses: mesopelagique/build-action@v1
```

In `on` section choose the event that trigger the build.

## Author

Eric Marchand

## License

MIT

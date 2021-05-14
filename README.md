# build-action

This action compile the 4D database.

## Usage

Create a [workflow file](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions) `.github/workflows/build.yml` in your project.

```yml
name: build

on:
  push:
    branches:
      - main
    paths: 
      - 'Project/**'
      - '.github/workflows/build.yml'
  pull_request:
    branches:
      - main
    paths: 
      - 'Project/**'
      - '.github/workflows/build.yml'
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Action
        uses: mesopelagique/build-action@v1
```

In `on` section choose the event that trigger the build. you could limit to some branches, some files, etc...

## Author

Eric Marchand

## License

MIT

# build-action

This action compile the 4D database and could upload compiled code to release.

⛔️ This project depend on some private access to 4d server instance. So you could not use it in your project.

[test project](https://github.com/mesopelagique/test-build-action)

## Usage

### to check if your code compile when pushing or when making a pull request

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

### to attach the compiled component to a release

Create a [workflow file](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions) `.github/workflows/release.yml` in your project.

```yml
name: release

on:
  release:

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build and release action
        uses: mesopelagique/build-action@releasebeta
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  
          RELEASE: 1
```

## Author

[Eric Marchand](https://github.com/mesopelagique/)

## License

[MIT](LICENSE.md)

# build-action

This github action compile the 4D database and could upload compiled code to release.

⛔️ This project depend on some private access to 4d server instance. So you cannot use it in your project.

But you could use the 4D database in simple github worflow on macOS if you provide the 4D. See [## Usage in workflow](#usage-in-workflow)

## Usage of action

[Example project](https://github.com/mesopelagique/test-build-action)

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
    types: [published]

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build and release action
        uses: mesopelagique/build-action@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  
          RELEASE: 1
```

## Usage in workflow

[Example project](https://github.com/mesopelagique/test-build-workflow)

Download this base and a 4d in your workflow file and launch script entrypoint.sh in a worflow step.

See example in [workflow folder](https://github.com/mesopelagique/test-build-workflow/tree/main/.github/workflows)

## Usage of entrypoint.sh

Move to your database in terminal and then launch

```bash
/path/to/this/project/build-action/entrypoint.sh
```

> You need an instance of 4D v19+ inside `/path/to/this/project/build-action/` (4D.app, 4D Server.app)

### Pass the project file

If there is more one project in your current directory pass it as first argument

```bash
/path/to/this/project/build-action/entrypoint.sh "a/path/Project/base.4DProject"
```

### Ignore warnings

the second arg allow to ignore warnings for exit status code

```bash
/path/to/this/project/build-action/entrypoint.sh "" 0
```

### Pass compilation options

the third arg allow to pass compilation options, see [`Compile project`](https://doc.4d.com/4Dv19/4D/19/Compile-project.301-5457347.en.html)

```bash
/path/to/this/project/build-action/entrypoint.sh "" "" "{\"typeInference\": \"none\"}"
```

## How it works

We launch the current project database with a downloaded 4D or 4D server and pass as parameters the database to compile.

The v19 new command `Compile project` is used for the compilation.
https://blog.4d.com/launch-a-compilation-by-programming/

### options

| option | description | blog|
|---|---|---|
|`--headless` | if not a server app | https://blog.4d.com/headless-4d-applications/|
|`--user-param`| to pass parameters such as the database to compile | https://blog.4d.com/improving-databases-tests/|

## Author

[Eric Marchand](https://github.com/mesopelagique/)

## License

[MIT](LICENSE.md)

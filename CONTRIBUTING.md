# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

Please note we have a [CODE OF CONDUCT][code-of-conduct] please follow it in all your interactions with the project.

## Table of Contents

* [Our conventions](#our-conventions)
* [Auto changelog](#auto-changelog)

## Our conventions

* [Versioning][semver]
* [Git commit message][conventional-commits]
* [Git flow][git-flow]
* [standard-version][standard-version]

## Auto changelog

### Prerequisites

Before using this project you have to be sure npm and node are installed

```
npm -v
node -v
```

Then go to the repository and install dependencies

```
cd /path/to/repository
npm install
```

### Make a new version

Then, after each new release or pre-release (must be on a release/`major`.`minor`.`patch`{-`alpha|beta|other`.`iteration`} according to [semver][semver]) you must run the a command to make a new release according to [standard-version][standard-version].

[semver]: http://semver.org
[conventional-commits]: https://www.conventionalcommits.org
[git-flow]: https://nvie.com/posts/a-successful-git-branching-model
[standard-version]: https://github.com/conventional-changelog/standard-version

[code-of-conduct]: CODE_OF_CONDUCT.md

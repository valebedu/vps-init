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

## Auto changelog

This project use [standard-version][standard-version] to auto changelog this project. Before continuing you need to install following dependencies.

```
npm install standard-version
npm install replace
```

Then, after each new release when everything is merged into `release/X.Y.Z` and before merging into master do:

1. update the version in `package.json` to `X.Y.Z`
2. run the following command:

```
npm run release
```

In case of first release (with [standard-version][standard-version]) please run the following command instead:

```
npm run release -- --first-release
```

[semver]: http://semver.org
[conventional-commits]: https://www.conventionalcommits.org
[git-flow]: https://nvie.com/posts/a-successful-git-branching-model
[standard-version]: https://github.com/conventional-changelog/standard-version

[code-of-conduct]: CODE_OF_CONDUCT.md

# underdogio.github.io [![Build status](https://travis-ci.org/underdogio/underdogio.github.io.png?branch=release)](https://travis-ci.org/underdogio/underdogio.github.io)

Engineering blog for Underdog.io

http://engineering.underdog.io/

This is written on top of [Wintersmith][], a static site generator.

[Wintersmith]: https://github.com/jnordberg/wintersmith

## Documentation
### Development
To get a local development copy of our site running, run `npm start`. This will initialize a preview server via `wintersmith`:

```bash
npm start
# starting preview server
# using config file: /home/underdog/github/underdogio.github.io/config.json
# server running on: http://localhost:8080/
```

A preview of the website should be available at <http://localhost:8080/>.

<http://localhost:8080/>

Additionally, we recommend using `livereload` to watch changes as they occur. Our recommended integration is a LiveReload browser extension and `python-livereload`:

https://github.com/lepture/python-livereload

```bash
# Run this and enable LiveReload in the browser
# Upon change, the browser page will update seamlessly or refresh
livereload
# Serving on http://127.0.0.1:35729
# [I 150619 19:22:15 handlers:109] Browser Connected: http://localhost:8080/
# [I 150619 19:22:15 handlers:118] Start watching changes
```

### Publishing a preview
When submitting a pull request, it is nice to be able to preview changes to the website. We have build `npm run preview-release` for that purpose.

When you run it, it will publish the current branch's build to `{{branch}}.preview` (e.g. `dev/hello` -> `dev/hello.preview`). This branch should be accessible via <https://htmlpreview.github.io/>

```bash
# Publish a preview branch
npm run preview-release

# Access the preview via htmlpreview.github.io
# http://htmlpreview.github.io/?https://github.com/underdogio/underdogio.github.io/blob/{{preview_branch}}/index.html
```

### Releasing
We have automated our release process to keep it consistent among developers. Before releasing, please make sure to update the `CHANGELOG.md`.

```bash
pico CHANGELOG.md
git add CHANGELOG.md
git commit -m "Added June 19 2015 publication notes"
```

To publish a new release, run:

```bash
npm run release
```

Under the hood, this will run the following steps:

1. Build latest vesion of site
2. Creates time-based timestamp for `version`
3. Updates `package.json` with `version`
4. Creates git commit under `version`
5. Creates git tag under `version`
6. Pushes git commit and tags
7. Deploys site to GitHub pages

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Test via `npm test`.

## License
Copyright (c) 2015 Underdog.io

Licensed under the MIT license.

# Image helpers

`resize-images.sh` wraps the built-in macOS `sips` command so screenshots can
be downscaled in-place before committing them to the blog. When `pngquant` is
installed (via `brew install pngquant`), the script also auto-optimizes resized
PNGs for smaller file sizes.

Usage:

```bash
scripts/resize-images.sh [max_width_px] <image>...
```

Example (resize a couple of screenshots to 1400px wide):

```bash
scripts/resize-images.sh 1400 images/blog/tc1.png images/blog/tc2.png
```

Images that are already narrower than the requested width are skipped.

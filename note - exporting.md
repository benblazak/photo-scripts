at the moment (2022 jun 11)

- there are 4 ways to export things (some of this is based on my current settings)

  - ios airdrop
    - preserves: captions, edits
    - omits: live photo, original photo
    - format: original (i think)
  - ios airdrop with "all photos data"
    - preserves: live photo, edits, original photo
    - omits: captions
    - format: original (i think)
  - mac photos export
    - (not sure)
    - format: transcoded in all cases (i think) lol
  - mac photos export original with "export iptc as xmp"
    - preserves: captions (in xmp file), live photo, original photo
    - omits: edits
    - format: original

- caption field in exif
  - for videos, it looks like ios puts the caption in `Description`
  - for images, it looks like it puts it in `ImageDescription`, and
    either `Caption-Abstract`, or `Description`
  - finder shows `ImageDescription` in the 'description' field of 'more info', if both that and `Description` exist and differ
  - if only `Description` exists, it shows that

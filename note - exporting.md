- for unedited videos that we want to rename using caption
  - export originals from mac photos, with xmp data file
  - use script to copy caption from xmp file to exif data
  - use script to rename using caption
  - use script to rename using date
  - move to nas
- for photos
  - note:
    - “unedited photos” includes photos that i’ve added a caption to, but made no other changes
  - export all originals from mac photos, with xmp data file
  - export edits with “all photos data” from ios via airdrop
    - look through folders to make sure everything’s all right
    - move items out of folders, and remove folders
      - `mv */* .`
      - `find . -type d -empty -delete`
      - the original in the folder and the original from mac photos should be identical, so it doesn’t matter which is kept
  - use script to copy caption from xmp file to exif data
  - use script to rename using date
  - move to nas

## notes

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

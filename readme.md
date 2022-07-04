## to use

- copy the `_scripts` folder into the folder to be acted on
- any `.command` should act on the enclosing folder (`..`, from the script's perspective)

## helpful commands

- delete empty directories

  ```fish
  find -type d -empty -delete
  ```

- count files in subdirectories

  ```fish
  for i in *; echo $i; ls $i | wc; end
  ```

- copy to nas using rsync

  - for unsorted files ("year" folder) (remove the `n` option to actually sync)

    ```fish
    rsync -avzn 2* ben-nas.local:"/nas/data/personal/media/by-device/2019-04-30 - iPhone XS/year"
    ```

  - this is much faster for large numbers of files, since finder seems to have some per file overhead for showing the transfer status of each file in the gui

- clone scripts from nas, and then pull from mac to sync

  ```fish
  # clone on mac

  cd /Users/ben/Downloads/photos

  # - using ssh
  git clone ben@ben-nas.local:"/nas/data/personal/media/by-device/2019-04-30 - iPhone XS/_scripts"

  # - using smb share
  git clone /Volumes/data/personal/media/by-device/2019-04-30\ -\ iPhone\ XS/_scripts


  # pull

  # - using ssh on pi
  cd /nas/data/personal/media/by-device/2019-04-30\ -\ iPhone\ XS/_scripts
  git pull ben@ben-mm.local:/Users/ben/Downloads/photos/_scripts

  # - using smb share on mac
  cd /Volumes/data/personal/media/by-device/2019-04-30 - iPhone XS/_scripts
  git pull ~/Downloads/photos/_scripts/
  ```

## process

- for unedited videos that we want to rename using caption
  - export originals from mac photos, with xmp data file
  - use script to copy caption from xmp file to exif data
  - use script to rename using caption
  - use script to rename using date
  - move to nas
- for photos and videos
  - export all originals from mac photos, with xmp data file
    - “unedited photos” includes photos that i’ve added a caption to, but made no other changes
  - export edits with “all photos data” from ios via airdrop
    - look through folders to make sure everything’s all right
      - some "all photos data" exports will have a folder name corresponding to the original file name, and them `IMG_...` files inside. i think this is due to the way edits are named.
        - recommend checking that another `IMG_...` with the same number does not exist in the same export, and renaming (the xmp and original file) to use that naming scheme
    - move items out of folders, and remove folders
      ```fish
      mv */* .
      find . -type d -empty -delete
      ```
      - the original in the folder and the original from mac photos should be identical, so it doesn’t matter which is kept
  - use script to copy caption from xmp file to exif data
  - use script to rename using date
  - move to nas

## notes

- at the moment (2022 jun 11)

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

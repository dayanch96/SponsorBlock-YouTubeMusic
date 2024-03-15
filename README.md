# SponsorBlock for YouTube Music
Skip music off-topic segments

Tweak settings can be accessed through Settings → SponsorBlock.

## Building

- Clone this project.
- Use latest [Theos](https://github.com/theos/theos).
- Clone [YouTubeHeader](https://github.com/PoomSmart/YouTubeHeader) to `$THEOS/include/YouTubeHeader`.
- `cd SponsorBlock-YouTubeMusic` folder and run `make clean package` to build deb for rootful or `make clean package ROOTLESS=1` for rootless

## Credits

The settings code is based on @PoomSmarts's implementation, from [Return-YouTube-Music-Dislikes](https://github.com/PoomSmart/Return-YouTube-Music-Dislikes)

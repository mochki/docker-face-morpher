# face-morpher
This container is a read-to-go docker image for trying out @alyssaq's open source [face-morpher](https://github.com/alyssaq/face_morpher) library. Since it took me forever to get it working, here are all the dependencies ready made for you.

The image contains the following necessary libraries:
- python - 2.7.15
- pip - 9.0.1
- python-tk
- opencv - 3.4.0
- ffmpeg - 3.4.2
- imagemagick
- node - 10.1.0
- npm - 5.6.0
- (built on) Ubuntu 18.04

**Note:** The current release of face-morpher by default needed opencv 3.4.0. You can use a new version but then you have to rebuild stasm. You can also use python 3, but a lot of the libraries defaults seamed to be 2.7 so I went with that. Frankly, the Dockerfile is pretty simple so feel free to hack away at it.

## Usage
You don't need the -v argument but I did because I want to supply pictures to this containter. Once the container is running, `cd` into `home` and start working. From here you will want to read the [face-morpher](https://github.com/alyssaq/face_morpher) docs to get going. I ran the following command to make a gif repeating back and forth of a face morph:

```sh
facemorpher --src=ARG1 --dest=ARG2 --out_video=full.avi && ffmpeg -y -i full.avi -ss 00:00:00.05 -t 00:00:01.85 trim.mp4 && ffmpeg -y -i trim.mp4 -vf reverse rev.mp4 && ffmpeg -y -f concat -i inputs.txt -c copy loop.mp4 && ffmpeg -y -i loop.mp4 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - output.gif
```

Replace ARG1 & ARG2 with the image or path to the image. This also assumes you have a file in the working directory called inputs.txt and has the following contents:

```
file 'trim.mp4'
file 'rev.mp4'
```

This, coupled with the fact that I will be building on top of this to make a webserver, is why I included ffmpeg, imagemagick, & node.

I do suggest you upscale and low resolution images. If your image is too small, this library has a hard time recognizing it, but if you upscale it to some bigger resolution, it seams to work alright. Also, this should be obvious, but try to use images with similar lighting and people looking in the same direction.

If you have questions make a GitHub issue. Cheers.

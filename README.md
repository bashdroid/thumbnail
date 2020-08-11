# thumbnail
**Aggressively compress images and videos**

Resize image and/or video files. For video files adjust also frame rate and audio and video bit rate. By default, write output for `FILE.EXT` to `FILE_tn.EXT`

## Installation
	curl -LO https://github.com/bashdroid/thumbnail/archive/master.tar.gz  
	tar xzf master.tar.gz  
	cd thumbnail-master  
	make install  

Depending on your system, you might need to run `make install` as root.  

If you don't need a manual, you may just download and run **thumbnail** with your preferred tools, e.g.:  

	curl -LO https://raw.githubusercontent.com/bashdroid/thumbnail/master/thumbnail  
	chmod u+x thumbnail

## Dependencies
* graphicsmagick  
* ffmpeg

## Rationale
Ordinary image and video compression methods usually have a limited compression rate. thumbnail allows arbitrary compression rates. With arbitrary quality loss, of course.

## Usage
### Synopsis
**thumbnail** \[*OPTION*\] *FILE1* \[*FILE2*, ...\]

### Options
**-i**     &nbsp;&nbsp;replace *FILEs* in place  
**-r** *R*   &nbsp;&nbsp;resize *FILEs* by *R*% (default: *R*=70)  
**-o** *F*   &nbsp;&nbsp;write output to file *F*; exit after first input file

### Arguments
*FILE* is an image file recognized by GraphicsMagick or a video file recognized by ffmpeg.

## Examples
* Resize `img.jpg` at the default rate and write output to `img_tn.jpg`:  

    thumbnail img.jpg  

* Replace `vid.mpg` by a version resized at rate 50%:  

    thumbnail -ir50 vid.mpg

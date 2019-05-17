# thumbnail
Tool for resizing image and video files.

## Installation
	curl -LO https://github.com/bashdroid/thumbnail/blob/master/thumbnail
	chmod u+x thumbnail

## Dependencies
* graphicsmagick
* ffmpeg

## Rationale
Ordinary image and video compression methods usually have a limited compression rate. thumbnail allows arbitrary compression rates. With arbitrary quality loss, of course.

## Usage
	thumbnail [Options] FILE1 [FILE2, ...]

### Options
`-i`) replace FILES in place
`-r R`) resize R% (default: R=70)
`-o F`) write output to file F; exit after first input file

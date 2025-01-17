@ECHO OFF

:: TODO: Support AARCH64?

IF NOT EXIST bin\ (
  MKDIR bin\
)

IF NOT EXIST bin\pandoc.exe (
  CALL curl -L https://github.com/jgm/pandoc/releases/download/3.6.2/pandoc-3.6.2-windows-x86_64.zip -o pandoc.zip
  CALL tar -xf pandoc.zip -C bin\ --strip-components=1 pandoc-3.6.2/pandoc.exe
  DEL pandoc.zip
)

IF NOT EXIST bin\magick.exe (
  CALL curl -L https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-43-portable-Q16-HDRI-x64.zip -o magick.zip
  CALL tar -xf magick.zip -C bin\ --strip-components=1 ImageMagick-7.1.1-43-portable-Q16-HDRI-x64/magick.exe
  CALL tar -xf magick.zip -C bin\ --strip-components=1 ImageMagick-7.1.1-43-portable-Q16-HDRI-x64/colors.xml
  DEL magick.zip
)

IF NOT EXIST bin\sed.exe (
  CALL curl -L https://github.com/mbuilov/sed-windows/releases/download/sed-4.9-x64-fixed/sed-4.9-x64.exe -o bin\sed.exe
)

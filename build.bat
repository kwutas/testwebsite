@ECHO OFF

:: TODO: Use magick to create images
:: TODO: Use sed to create nav bar
:: TODO: Use sed for everything else, timestamps may not be possible

SET "FILEMISSING="
IF NOT EXIST bin\pandoc.exe FILEMISSING=1
IF NOT EXIST bin\magick.exe FILEMISSING=1
IF NOT EXIST bin\sed.exe FILEMISSING=1
if defined FILEMISSING (
  ECHO "Required binaries are missing, please run setup.sh to acquire them"
  EXIT 1
)

SET PAGES=index projects events about websiteabout

IF NOT EXIST output\assets\ MKDIR output\assets\

(FOR %%o IN (%PAGES%) DO (
  IF NOT EXIST pages\%%o.md (
    ECHO Page %%o is missing, skipping
  ) ELSE (
    CALL bin\pandoc.exe templates\setup.yaml -s --template templates\template.html -f markdown-implicit_figures^
                        --wrap=preserve -B templates\header.html -A templates\footer.html "pages\%%o.md"^
                        -o "output\%%o.html"
  )
))

COPY assets\style.css output\assets\style.css

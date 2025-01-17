@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

:: TODO: Use sed for everything else, timestamps may not be possible

SET "FILEMISSING="
IF NOT EXIST bin\pandoc.exe FILEMISSING=1
IF NOT EXIST bin\magick.exe FILEMISSING=1
IF NOT EXIST bin\sed.exe FILEMISSING=1
IF DEFINED FILEMISSING (
  ECHO "Required binaries are missing, please run setup.sh to acquire them"
  EXIT 1
)

SET "PAGES=index projects events about websiteabout"

:: From https://superuser.com/a/1541378
(SET LF=^
%=EMPTY=%
)

IF NOT EXIST output\assets\ MKDIR output\assets\

(FOR %%o IN (%PAGES%) DO (
  IF NOT EXIST pages\%%o.md (
    ECHO Page %%o is missing, skipping
  ) ELSE (
    SET "navbar=\!LF!"
    (FOR %%n IN (%PAGES%) DO (
      IF EXIST pages\%%n.md (
        SET "ignore="
        SET "name="
        FOR /F "tokens=* USEBACKQ" %%F IN (`bin\sed.exe -n "s/^no-nav-entry: //p" pages/"%%n".md`) DO SET "ignore=%%F"
        IF NOT DEFINED ignore (
          FOR /F "tokens=* USEBACKQ" %%F IN (`bin\sed.exe -n "s/^pagetitle: //p" pages/%%n.md`) DO SET "name=%%F"
          IF NOT DEFINED name FOR /F "tokens=* USEBACKQ" %%F IN (`bin\sed.exe -n "s/^title: //p" pages/%%n.md`) DO SET "name=%%F"
          IF NOT DEFINED name (
            ECHO Skipping %%n due to missing yaml title
          ) ELSE (
            SET navbar=!navbar!                ^<li class=^"nav-item mb-2 px-2^"^>\!LF!
            SET navbar=!navbar!                  ^<a class=^"nav-link pt-1^"
            IF "%%o" == "%%n" (
              SET navbar=!navbar! aria-current=^"page^" href=^"#
            ) ELSE (
              SET navbar=!navbar! href=^"%%n.html
            )
            SET navbar=!navbar!^"^>!name!^</a^>\!LF!
            SET navbar=!navbar!                ^</li^>\!LF!
          )
        )
      )
    ))
    SET navbar=!navbar!              

    bin\pandoc.exe templates\setup.yaml -s --template templates\template.html -f markdown-implicit_figures^
                   --wrap=preserve -B templates\header.html -A templates\footer.html "pages\%%o.md"^
                   -o "output\%%o.html"
    :: TODO: Figure out how to make sed.exe accept input directly
    ECHO s$%%NAVBAR_ITEMS%%$!navbar!$> sed.txt
    bin\sed.exe -i.tmp -f sed.txt  "output\%%o.html"
    del sed.txt
    del "output\%%o.html.tmp"
  )
))

COPY assets\style.css output\assets\style.css

bin\magick.exe assets\DraftPCLogoV2.png -strip -background none -resize 32x32 -density 32x32 output\assets\favicon.ico
bin\magick.exe assets\DraftPCLogoV2.png -strip -background none -resize 250x253 -density 250x253 output\assets\icon.png

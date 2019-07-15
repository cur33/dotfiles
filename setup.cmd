REM xcopy /Y /E /I .vim H:\vimfiles
REM copy /Y .vim\.vimrc H:\_vimrc

SET root=%HOMEPATH%
SET vimfiles=%root%\vimfiles
SET vimrc=%root%\_vimrc

IF NOT EXIST %vimfiles% (
    mklink %vimfiles% .vim
) ELSE (
    ECHO vimfiles already exists
)

IF NOT EXIST %vimrc% (
    mklink %vimrc% %vimfiles%\.vimrc
) ELSE (
    ECHO vimrc already exists
)

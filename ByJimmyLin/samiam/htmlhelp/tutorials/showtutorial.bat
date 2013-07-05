@echo off
rem msdos script to invoke an type-associated file (e.g. a video tutorial)
rem designed to work under Windows 98/NT/2000/XP
rem see http://support.microsoft.com/default.aspx?kbid=126410
rem since 030804

rem %1 =	first parameter must be the absolute
rem		path of the directory that contains
rem		the type-associated file, quoted

rem %2 =	second parameter must be the file
rem		name, containing no spaces, unquoted

cd %1
start %2

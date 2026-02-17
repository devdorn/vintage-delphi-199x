SFX Programming example for Delphi3
-----------------------------------
Copyright 1998 Easycash Software / Alexander Halser
Internet homepage: http://www.easycash.co.at

This package contains a programming example how to create 
SELF EXTRACTING EXE FILES (SFX). You can run the SFXBuilder
as well as the created SFX on any Windows95/98/NT computer.


>  This example is FREEWARE!
>  -------------------------
>  NO SUPPORT IS PROVIDED NEIGHTER FOR THE COMPONENT TBACKUPFILE NOR 
>  FOR THIS EXAMPLE PROGRAM. 
>
>  AND WE ARE NOT RESPONSIBLE FOR YOUR PROGRAMMING QUESTIONS.
>
>  No warranty is given by the author, expressed or implied.
>  Do not distribute modified versions without our agreement.



CONTENT OF THIS PACKAGE
=======================

SFX.*		Source code and compiled EXE of the SFX template.
		The file SFX.EXE is used by the SFXBuilder and 
		must be located in the same directory.

SFXBuilder.*	Source code and compiled EXE of the SFX creator.
		This program is used to create a self extracting EXE.

README.TXT	This file.


IMPORTANT ! 
===========

If you want to explore the source code which is included, you must 
download and install the Delphi component TBackupFile 3.00 or later.


INSTALLATION
============

None. TBackupFile must be installed to compile the examples. 
The examples itself are ready to go. Please copy all files into one 
directory.


USAGE
=====

1) Start SFXBuilder.exe
2) Select the files you want to store in the self extracting exe
3) Click "Create SFX" and enter a name for the target file
   NOTE: the template program "SFX.EXE" must be located in the 
   same directory as the SFXBuilder. Do NOT overwrite this file.


HOW IT WORKS
============
Simply speaking, the SFX is a small program with a large hatchback or
better: a rucksack. In fact, the SFXBuilder simply copies the template
file SFX.EXE and then adds the (compressed) backup data at the end of 
the newly created file. The resulting exe file knows its own total size 
and it knows where the program stuff ends and the data rucksack starts. 

When starting the SFX, it opens itself and checks about the data it has
'on board'. The extraction of this data is completely done by the backup
/restore component.

Please open the source code of both, the SFXBuilder and the SFX example.
There are just a couple of procedures and only 2 (yes, TWO) procedures
are responsible for the SFX creation and extraction. 
Please check out the comments of the source code.

Before you start working on your own SFX you should be familiar with 
TBackupFile. TBackupFile can be downloaded from our homepage and comes 
with a very good help file.


WHAT'S MISSING ?
================
This is a programming EXAMPLE. It is not a new Winzip. We only took care 
about the major errors in the SFX template. The SFXBuilder has no error trapping. 
You also may want to reduce the size of the empty SFX (about 300 KB). 
This is possible, of course. But if you want to have at least one form in 
your SFX, the size will never be less than about 200 KB.


---------- Enjoy! -------------------------------------------------------


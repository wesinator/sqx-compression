# Microsoft Developer Studio Generated NMAKE File, Format Version 4.20
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=unsqx - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to unsqx - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "unsqx - Win32 Release" && "$(CFG)" != "unsqx - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "unsqx.mak" CFG="unsqx - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "unsqx - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "unsqx - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "unsqx - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\Release
INTDIR=.\Release

ALL : "$(OUTDIR)\unsqx.exe"

CLEAN : 
	-@erase "$(INTDIR)\aes_c.obj"
	-@erase "$(INTDIR)\aescrypt.obj"
	-@erase "$(INTDIR)\aeskey.obj"
	-@erase "$(INTDIR)\aestab.obj"
	-@erase "$(INTDIR)\arcio.obj"
	-@erase "$(INTDIR)\bf_crypt.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\ctab.obj"
	-@erase "$(INTDIR)\cx_audio.obj"
	-@erase "$(INTDIR)\md5c.obj"
	-@erase "$(INTDIR)\mm_coder.obj"
	-@erase "$(INTDIR)\rcoder.obj"
	-@erase "$(INTDIR)\sqx_dec.obj"
	-@erase "$(INTDIR)\sqx_main.obj"
	-@erase "$(INTDIR)\sqx_os.obj"
	-@erase "$(INTDIR)\sqx_vars.obj"
	-@erase "$(INTDIR)\t_coder.obj"
	-@erase "$(INTDIR)\uarde.obj"
	-@erase "$(OUTDIR)\unsqx.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /YX /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /YX /c
CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"\
 /Fp"$(INTDIR)/unsqx.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=.\.
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x407 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/unsqx.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)/unsqx.pdb" /machine:I386 /out:"$(OUTDIR)/unsqx.exe" 
LINK32_OBJS= \
	"$(INTDIR)\aes_c.obj" \
	"$(INTDIR)\aescrypt.obj" \
	"$(INTDIR)\aeskey.obj" \
	"$(INTDIR)\aestab.obj" \
	"$(INTDIR)\arcio.obj" \
	"$(INTDIR)\bf_crypt.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\ctab.obj" \
	"$(INTDIR)\cx_audio.obj" \
	"$(INTDIR)\md5c.obj" \
	"$(INTDIR)\mm_coder.obj" \
	"$(INTDIR)\rcoder.obj" \
	"$(INTDIR)\sqx_dec.obj" \
	"$(INTDIR)\sqx_main.obj" \
	"$(INTDIR)\sqx_os.obj" \
	"$(INTDIR)\sqx_vars.obj" \
	"$(INTDIR)\t_coder.obj" \
	"$(INTDIR)\uarde.obj"

"$(OUTDIR)\unsqx.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "unsqx - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
OUTDIR=.\Debug
INTDIR=.\Debug

ALL : "$(OUTDIR)\unsqx.exe"

CLEAN : 
	-@erase "$(INTDIR)\aes_c.obj"
	-@erase "$(INTDIR)\aescrypt.obj"
	-@erase "$(INTDIR)\aeskey.obj"
	-@erase "$(INTDIR)\aestab.obj"
	-@erase "$(INTDIR)\arcio.obj"
	-@erase "$(INTDIR)\bf_crypt.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\ctab.obj"
	-@erase "$(INTDIR)\cx_audio.obj"
	-@erase "$(INTDIR)\md5c.obj"
	-@erase "$(INTDIR)\mm_coder.obj"
	-@erase "$(INTDIR)\rcoder.obj"
	-@erase "$(INTDIR)\sqx_dec.obj"
	-@erase "$(INTDIR)\sqx_main.obj"
	-@erase "$(INTDIR)\sqx_os.obj"
	-@erase "$(INTDIR)\sqx_vars.obj"
	-@erase "$(INTDIR)\t_coder.obj"
	-@erase "$(INTDIR)\uarde.obj"
	-@erase "$(INTDIR)\vc40.idb"
	-@erase "$(INTDIR)\vc40.pdb"
	-@erase "$(OUTDIR)\unsqx.exe"
	-@erase "$(OUTDIR)\unsqx.ilk"
	-@erase "$(OUTDIR)\unsqx.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /YX /c
# ADD CPP /nologo /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /YX /c
CPP_PROJ=/nologo /MLd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /Fp"$(INTDIR)/unsqx.pch" /YX /Fo"$(INTDIR)/" /Fd"$(INTDIR)/" /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.\.
# ADD BASE RSC /l 0x407 /d "_DEBUG"
# ADD RSC /l 0x407 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/unsqx.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)/unsqx.pdb" /debug /machine:I386 /out:"$(OUTDIR)/unsqx.exe" 
LINK32_OBJS= \
	"$(INTDIR)\aes_c.obj" \
	"$(INTDIR)\aescrypt.obj" \
	"$(INTDIR)\aeskey.obj" \
	"$(INTDIR)\aestab.obj" \
	"$(INTDIR)\arcio.obj" \
	"$(INTDIR)\bf_crypt.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\ctab.obj" \
	"$(INTDIR)\cx_audio.obj" \
	"$(INTDIR)\md5c.obj" \
	"$(INTDIR)\mm_coder.obj" \
	"$(INTDIR)\rcoder.obj" \
	"$(INTDIR)\sqx_dec.obj" \
	"$(INTDIR)\sqx_main.obj" \
	"$(INTDIR)\sqx_os.obj" \
	"$(INTDIR)\sqx_vars.obj" \
	"$(INTDIR)\t_coder.obj" \
	"$(INTDIR)\uarde.obj"

"$(OUTDIR)\unsqx.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "unsqx - Win32 Release"
# Name "unsqx - Win32 Debug"

!IF  "$(CFG)" == "unsqx - Win32 Release"

!ELSEIF  "$(CFG)" == "unsqx - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\uarde.c
DEP_CPP_UARDE=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\ctab.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	"..\..\..\uarde.h"\
	

"$(INTDIR)\uarde.obj" : $(SOURCE) $(DEP_CPP_UARDE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\arcio.c
DEP_CPP_ARCIO=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crc32.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_c.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\os\sqx_os.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	"..\..\..\t_coder.h"\
	"..\..\..\uarde.h"\
	
NODEP_CPP_ARCIO=\
	"..\..\..\os\´.\cx_type.h"\
	

"$(INTDIR)\arcio.obj" : $(SOURCE) $(DEP_CPP_ARCIO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crc32.c
DEP_CPP_CRC32=\
	"..\..\..\config.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_type.h"\
	

"$(INTDIR)\crc32.obj" : $(SOURCE) $(DEP_CPP_CRC32) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\ctab.c
DEP_CPP_CTAB_=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\ctab.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\mm_coder.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	"..\..\..\t_coder.h"\
	

"$(INTDIR)\ctab.obj" : $(SOURCE) $(DEP_CPP_CTAB_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\cx_audio.c
DEP_CPP_CX_AU=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crc32.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\ctab.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\os\sqx_os.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	
NODEP_CPP_CX_AU=\
	"..\..\..\os\´.\cx_type.h"\
	

"$(INTDIR)\cx_audio.obj" : $(SOURCE) $(DEP_CPP_CX_AU) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\mm_coder.c
DEP_CPP_MM_CO=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\rcoder.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	

"$(INTDIR)\mm_coder.obj" : $(SOURCE) $(DEP_CPP_MM_CO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\rcoder.c
DEP_CPP_RCODE=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\rcoder.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	

"$(INTDIR)\rcoder.obj" : $(SOURCE) $(DEP_CPP_RCODE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\sqx_dec.c
DEP_CPP_SQX_D=\
	"..\..\..\arcio.h"\
	"..\..\..\config.h"\
	"..\..\..\crc32.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_c.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\ctab.h"\
	"..\..\..\cx_audio.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\os\sqx_os.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	"..\..\..\uarde.h"\
	
NODEP_CPP_SQX_D=\
	"..\..\..\os\´.\cx_type.h"\
	

"$(INTDIR)\sqx_dec.obj" : $(SOURCE) $(DEP_CPP_SQX_D) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\sqx_main.c
DEP_CPP_SQX_M=\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_err.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\os\sqx_os.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	
NODEP_CPP_SQX_M=\
	"..\..\..\os\´.\cx_type.h"\
	

"$(INTDIR)\sqx_main.obj" : $(SOURCE) $(DEP_CPP_SQX_M) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\sqx_vars.c
DEP_CPP_SQX_V=\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\sqx_h.h"\
	

"$(INTDIR)\sqx_vars.obj" : $(SOURCE) $(DEP_CPP_SQX_V) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\t_coder.c
DEP_CPP_T_COD=\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	

"$(INTDIR)\t_coder.obj" : $(SOURCE) $(DEP_CPP_T_COD) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\os\sqx_os.c
DEP_CPP_SQX_O=\
	"..\..\..\config.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\os\dos\dos_inc.c"\
	"..\..\..\os\linux\linux_inc.c"\
	"..\..\..\os\win32\win32_inc.c"\
	

"$(INTDIR)\sqx_os.obj" : $(SOURCE) $(DEP_CPP_SQX_O) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crypt\md5c.c
DEP_CPP_MD5C_=\
	"..\..\..\crypt\md5.h"\
	

"$(INTDIR)\md5c.obj" : $(SOURCE) $(DEP_CPP_MD5C_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crypt\bf\bf_crypt.c
DEP_CPP_BF_CR=\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\crypt\md5.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	

"$(INTDIR)\bf_crypt.obj" : $(SOURCE) $(DEP_CPP_BF_CR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crypt\aes\aestab.c
DEP_CPP_AESTA=\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\aesopt.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	
NODEP_CPP_AESTA=\
	"..\..\..\crypt\aes\crypt.h"\
	"..\..\..\crypt\crypt.h"\
	

"$(INTDIR)\aestab.obj" : $(SOURCE) $(DEP_CPP_AESTA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crypt\aes\aes_c.c
DEP_CPP_AES_C=\
	"..\..\..\config.h"\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	"..\..\..\crypt\bf\bf_crypt.h"\
	"..\..\..\crypt\md5.h"\
	"..\..\..\cx_dino.h"\
	"..\..\..\cx_type.h"\
	"..\..\..\sqx_h.h"\
	"..\..\..\sqx_vars.h"\
	

"$(INTDIR)\aes_c.obj" : $(SOURCE) $(DEP_CPP_AES_C) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crypt\aes\aescrypt.c
DEP_CPP_AESCR=\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\aesopt.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	
NODEP_CPP_AESCR=\
	"..\..\..\crypt\aes\crypt.h"\
	"..\..\..\crypt\crypt.h"\
	

"$(INTDIR)\aescrypt.obj" : $(SOURCE) $(DEP_CPP_AESCR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=\PROGRAM\Squeez4\RSQX\Source\crypt\aes\aeskey.c
DEP_CPP_AESKE=\
	"..\..\..\crypt\aes\aes.h"\
	"..\..\..\crypt\aes\aes_comp.h"\
	"..\..\..\crypt\aes\aesopt.h"\
	"..\..\..\crypt\aes\uitypes.h"\
	
NODEP_CPP_AESKE=\
	"..\..\..\crypt\aes\crypt.h"\
	"..\..\..\crypt\crypt.h"\
	

"$(INTDIR)\aeskey.obj" : $(SOURCE) $(DEP_CPP_AESKE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
# End Target
# End Project
################################################################################

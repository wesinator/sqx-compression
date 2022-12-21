{Projekt SQX-SDK
 SpeedProject
 Copyright © 1995 - 2005. Alle Rechte vorbehalten.
 ***************************************************
 * Orginaldateien          : SqxArchiveDll.ccp ,   *
 *                           SqxArchive.h,         *
 *                           Sqx.h                 *
 *                                                 *
 * Autor der Orginaldatei  : Sven Ritter           *
 *                                                 *
 * Datum der Orginaldatei  : 21.05.2005            *
 ***************************************************

 ***************************************************
 * Dateiname               : SqxArchiveDll.pas     *
 *                                                 *
 * Umsetzung in Delphi     : Reimar Beyer          *
 *                           Sascha Düsing         *
 *                                                 *
 * Datum                   : 31.08.2006            *
 *                                                 *
 * Änderungen              : 22.01.2008            *
 *   Fehlerbehebung in LoadarchiveDLL              *
 *   Fehlerbehebung in TSQX_CallbackInfo           *
 *   Beispiel in der Callbackfunktion eingefügt    *                            
 ***************************************************

 UEBERBLICK
 ==========
 Quelltextdatei fuer die Implementation von CSqxArchiveDll in Delphi

 Getestet wurde unter folgenden Delphi-Versionen und
 Betriebssystemen:
 
 - Delphi 5 Professional 
 - Delphi 2005 Personal Edition
 
 - Windows 98 SE
 - Windows 2000
 - Windows XP Home Edition
 - Windows XP Professional Edition
 - Windows Vista Ultimate
}

Unit SQXArchiveDLL;
// ****************************************************************************
// ******                  Delphiversion bestimmen                       ******
// ****************************************************************************

{$ifdef VER180}
  {$define DELPHI_2006_UP}
  {$define DELPHI_2005_UP}
  {$define DELPHI_8_UP}
  {$define DELPHI_7_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER170}
  {$define DELPHI_2005_UP}
  {$define DELPHI_8_UP}
  {$define DELPHI_7_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER160}
  {$define DELPHI_8_UP}
  {$define DELPHI_7_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER150}
  {$define DELPHI_7_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER140}
  {$define DELPHI_6_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER130}
  {$define DELPHI_5_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER120}
  {$define DELPHI_4_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER100}
  {$define DELPHI_3_UP}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER90}
  {$define DELPHI_2_UP}
  {$define DELPHI_1_UP}
{$endif}

{$ifdef VER80}
  {$define DELPHI_1_UP}
{$endif}

Interface

// ****************************************************************************
// ******                  ausgerichtete Rekordfelder                    ******
// ****************************************************************************

{$ifdef DELPHI_6_UP} // evtl. ist der Schalter erst in höheren Versionen verfügbar
  {$A1}
{$else}
  {$A+}
{$endif}


Uses
  SysUtils,
  Dialogs,
  Windows;

// ****************************************************************************
// ******                      Unicodetypen                              ******
// ****************************************************************************
Type
{$ifdef Unicode}
  TChar=WideChar;
  TPChar=PWideChar;
  TString=WideString;
{$else}
  TChar=Char;
  TPChar=PChar;
  TString=String;
{$endif}

Const

// ****************************************************************************
// ******                 Aktionen fuer Fortschrittsanzeige              ******
// ****************************************************************************

  SQX_PROGRESS_CANCEL                        =   0;
  SQX_PROGRESS_OK                            =   1;

// ****************************************************************************
// ******                Aktionen fuer 'Datei ueberschreiben'            ******
// ****************************************************************************

  SQX_REPLACE_OVERWRITE                      =   0;
  SQX_REPLACE_SKIP                           =   1;
  SQX_REPLACE_CANCEL                         =   2;

// ****************************************************************************
// ******                  Aktionen fuer 'Kennwortabfrage'               ******
// ****************************************************************************

  SQX_PASSWORD_CANCEL                        =   0;
  SQX_PASSWORD_OK                            =   1;

// ****************************************************************************
// ******                      Aktionen fuer 'SkipFile'                  ******
// ****************************************************************************

  SQX_SKIPFILE_SKIP                          =   1;
  SQX_SKIPFILE_CANCEL                        =   2;

// ****************************************************************************
// ******                  Aktionen fuer naechste Diskette               ******
// ****************************************************************************

  SQX_NEXTDISK_CANCEL                        =   0;
  SQX_NEXTDISK_OK                            =   1;

// ****************************************************************************
// ******                            Dateiformat                         ******
// ****************************************************************************

  SQX_FILEFORMAT_10                          =   0;
  SQX_FILEFORMAT_20                          =   1;

// ****************************************************************************
// ******                          Speichergroessen                      ******
// ****************************************************************************

  SQX_DICTIONARY_0K                          =   0;
  SQX_DICTIONARY_8K                          =   1;
  SQX_DICTIONARY_16K                         =   2;
  SQX_DICTIONARY_32K                         =   3;
  SQX_DICTIONARY_64K                         =   4;
  SQX_DICTIONARY_128K                        =   5;
  SQX_DICTIONARY_256K                        =   6;
  SQX_DICTIONARY_512K                        =   7;
  SQX_DICTIONARY_1M                          =   8;
  SQX_DICTIONARY_2M                          =   9;
  SQX_DICTIONARY_4M                          =  10;
  SQX_DICTIONARY_8M                          =  11;
  SQX_DICTIONARY_16M                         =  12;
  SQX_DICTIONARY_32M                         =  13;
  SQX_DICTIONARY_64M                         =  14;
  SQX_DICTIONARY_128M                        =  15;
  SQX_DICTIONARY_256M                        =  16;

// ****************************************************************************
// ******                             Dateinamen                         ******
// ****************************************************************************

  SQX_FILENAME_ANSI                          =   0;
  SQX_FILENAME_ASCII                         =   1;
  SQX_FILENAME_UNICODE                       =   2;

// ****************************************************************************
// ******                          Verschluesselung                      ******
// ****************************************************************************

  SQX_ENCRYPTION_NONE                        =   0;
  SQX_ENCRYPTION_AES_128BIT                  =   2;
  SQX_ENCRYPTION_AES_256BIT                  =   4;


// ****************************************************************************
// ******                              Signatur                          ******
// ****************************************************************************

  SQX_AVENVELOPE_128BIT                      =   0;
  SQX_AVENVELOPE_256BIT                      =   1;
  SQX_AVENVELOPE_512BIT                      =   2;

// ****************************************************************************
// ******                          Kompressionsrate                      ******
// ****************************************************************************

  SQX_COMPRATE_STORED                        =   0;  // Keine Kompression
  SQX_COMPRATE_FAST                          =   1;  // Schnelle Kompression
  SQX_COMPRATE_NORMAL                        =   2;  // Gute Kompression
  SQX_COMPRATE_HIGH                          =   3;  // Hohe Kompression
  SQX_COMPRATE_MAXIMIUM                      =   4;  // Maximale Kompression
  SQX_COMPRATE_ULTRA                         =   5;  // Ultra-Kompression

// ****************************************************************************
// ******                        Kompressionsmethoden                    ******
// ****************************************************************************

  SQX_METHOD_STORED                          =   0;  // stored (no compression), compression type 1 (lzh)
  SQX_METHOD_NORMAL                          =   1;  // compressed, normal compression, compression type 1 (lzh)
  SQX_METHOD_GOOD                            =   2;  // compressed, good compression, compression type 1 (lzh)
  SQX_METHOD_HIGH                            =   3;  // compressed, high compression, compression type 1 (lzh)
  SQX_METHOD_BEST                            =   4;  // compressed, best compression, compression type 1 (lzh)
  SQX_METHOD_AUDIO                           =   5;  // true audio (wav, pcm) compression
  SQX_METHOD_TEXT                            =   6;  // text compression (ppmd)
  SQX_METHOD_ULTRA                           =   7;  // ultra compression (lz77 + rc)

// ****************************************************************************
// ******                           Reparaturdaten                       ******
// ****************************************************************************

  SQX_RECOVERYDATA_NONE                      =   0;
  SQX_RECOVERYDATA_1                         =   1;
  SQX_RECOVERYDATA_2                         =   2;
  SQX_RECOVERYDATA_3                         =   3;
  SQX_RECOVERYDATA_4                         =   4;
  SQX_RECOVERYDATA_5                         =   5;

// ****************************************************************************
// ******                            Kompressoren                        ******
// ****************************************************************************

  SQX_SPECIALCOMP_DISABLED                   =   0;
  SQX_SPECIALCOMP_AUTOMATIC                  =   1;
  SQX_SPECIALCOMP_FORCE                      =   2;

// ****************************************************************************
// ******                          Betriebssysteme                       ******
// ****************************************************************************

  SQX_HOSTOS_DOSWIN                          =   0;
  SQX_HOSTOS_DOS                             =   1;
  SQX_HOSTOS_OS2                             =   2;
  SQX_HOSTOS_WIN32                           =   3;
  SQX_HOSTOS_WINNT                           =   4;
  SQX_HOSTOS_UNIX                            =   5;
  SQX_HOSTOS_MAC                             =   6;
  SQX_HOSTOS_WINNT_ALPHA                     =   7;
  SQX_HOSTOS_ATARI                           =   8;
  SQX_HOSTOS_VAX_VMS                         =   9;
  SQX_HOSTOS_AMIGA                           =  10;
  SQX_HOSTOS_NEXT                            =  11;
  SQX_HOSTOS_LINUX                           =  12;
  SQX_HOSTOS_CPM                             =  13;
  SQX_HOSTOS_ZSYS                            =  14;
  SQX_HOSTOS_VMCMS                           =  15;
  SQX_HOSTOS_BEOS                            =  16;
  SQX_HOSTOS_UNKNOWN                         =  17;
  SQX_HOSTOS_OS2_HPFS                        =  18;
  SQX_HOSTOS_WIN32_FAT32                     =  19;
  SQX_HOSTOS_WINNT_NTFS                      =  20;
  SQX_HOSTOS_WINNTAXP_NTFS                   =  21;
  SQX_HOSTOS_MVS                             =  22;
  SQX_HOSTOS_VSE                             =  23;
  SQX_HOSTOS_ARCORN_RISC                     =  24;
  SQX_HOSTOS_MVS_ALT                         =  25;

// ****************************************************************************
// ******                        Callback-Funktionen                     ******
// ****************************************************************************

  SQX_Callback_FILENAME                      =   0;
  SQX_Callback_PROGRESS                      =   1;
  SQX_Callback_REPLACE                       =   2;
  SQX_Callback_PASSWORD                      =   3;
  SQX_Callback_PASSWORD_HEADER               =   4;
  SQX_Callback_SKIP                          =   5;
  SQX_Callback_NEXTDISK                      =   6;
  SQX_Callback_SIGNAL                        =   7;

// ****************************************************************************
// ******                          Signalfunktionen                      ******
// ****************************************************************************

  SQX_SIGNAL_COMPRESS                        =   1;
  SQX_SIGNAL_UNCOMPRESS                      =   2;
  SQX_SIGNAL_DELETE                          =   3;
  SQX_SIGNAL_TEMP_ARC_COPY                   =   4;
  SQX_SIGNAL_CREATE_AV_SIG                   =   5;
  SQX_SIGNAL_TEST_AV_SIG                     =   6;
  SQX_SIGNAL_ADD_MV_UNCOMPRESS               =   7;
  SQX_SIGNAL_CREATE_RDATA                    =   8;
  SQX_SIGNAL_REPAIR_ARCHIVE                  =   9;
  SQX_SIGNAL_STRIP_RDATA                     =  10;
  SQX_SIGNAL_TEST_ARCHIVE                    =  11;
  SQX_SIGNAL_CREATE_SFX_ARCHIVE              =  12;
  SQX_SIGNAL_ADD_MV_TEST                     =  13;
  SQX_SIGNAL_EX_TEST_ARCHIVE                 =  14;
  SQX_SIGNAL_ADD_MV_EX_TEST                  =  15;


// ****************************************************************************
// ******                          Fehlermeldungen                       ******
// ****************************************************************************

  SQX_ERR_SUCCESS                            =   0;  // No error.
  SQX_ERR_ERROR                              =   1;  // Unknown error in the last archive operation.
  SQX_ERR_FILE_NOT_FOUND                     =   2;  // The system cannot find the file specified.
  SQX_ERR_PATH_NOT_FOUND                     =   3;  // The system cannot find the path specified.
  SQX_ERR_TOO_MANY_FILES                     =   4;  // The system cannot open the file.
  SQX_ERR_ACCESS_DENIED                      =   5;  // Access is denied.
  SQX_ERR_INVALID_HANDLE                     =   6;  // The file handle is invalid.
  SQX_ERR_DISK_FULL                          =   7;  // The disk is full.
  SQX_ERR_OUT_OF_MEMORY                      =   8;  // Not enough memory is available to complete this operation.
  SQX_ERR_CANT_ACCESS_TEMP_DIR               =   9;  // Cannot access temp folder during a delete or update operation on a solid archive.
  SQX_ERR_TEMP_DIR_FULL                      =  10;  // Not enough space on drive for the temporary folder.
  SQX_ERR_USER_ABORT                         =  11;  // Cancelled by user.
  SQX_ERR_INVALID_ARC_HANDLE                 =  12;  // Invalid archive handle.
  SQX_ERR_CANT_FIND_LANG_DATA                =  13;  // Could not find the selected language file for self-extracting archives.
  SQX_ERR_UNKNOWN_SUBSTREAM                  =  14;  // The archive contains at least one unknown alternate data stream.
  SQX_ERR_BAD_SUBSTREAM_CRC                  =  15;  // Bad alternate stream CRC. Archive is probably corrupted.
  SQX_ERR_UNKNOWN_METHOD                     =  16;  // This method of compression is not supported by the archiver.
  SQX_ERR_FILE_ENCRYPTED                     =  17;  // Archive is encrypted with a password.
  SQX_ERR_BAD_CRC                            =  18;  // Bad CRC. Archive is probably corrupted.
  SQX_ERR_CANT_CREATE_FILE                   =  19;  // Could not create file or folder.
  SQX_ERR_BAD_FILE_FORMAT                    =  20;  // Bad archive file format.
  SQX_ERR_FUNCTION_NOT_SUPPORTED             =  21;  // Function is not supported.
  SQX_ERR_FUNC_NOT_SUPPORTED_BY_ARCHIVE      =  22;  // Function is not supported for this archive type.
  SQX_ERR_CANT_CREATE_ARC_DIR                =  23;  // Could not create folder in archive. It already exists a folder with this name.
  SQX_ERR_INVALID_DIR_NAME                   =  24;  // Could not create folder in archive. The folder name contains invalid characters.
  SQX_ERR_INVALID_FILE_NAME                  =  25;  // Could not create file in archive. The file name contains invalid characters.
  SQX_ERR_TOO_MANY_BROKEN_FBLOCKS            =  26;  // The archive file contains too many damaged file blocks and cannot be repaired.
  SQX_ERR_ARCHIVE_OK_RDATA_NOT               =  27;  // It seems that the archive has no errors, but the recovery data does not match the archive. Maybe this archive was edited by a program that could not identify the recovery data.
  SQX_ERR_RDATA_DAMAGED                      =  28;  // The recovery data of the archive file is damaged, too. This archive file cannot be repaired.
  SQX_ERR_RDATA_NEW_VERSION                  =  29;  // The archive contains recovery data that cannot be used with this version of our software.The newest versions of our software are always available at http://www.speedproject.de/.
  SQX_ERR_RDATA_DOES_NOT_MATCH               =  30;  // The recovery data does not match the archive. It seems that this archive was edited by a program that could not identify the recovery data.
  SQX_ERR_CANT_FIND_RDATA                    =  31;  // It seems that the archive does not contain any recovery data.
  SQX_ERR_ARCHIVE_IS_LOCKED                  =  32;  // Cannot modify locked archive.
  SQX_ERR_CANT_ADD_TO_MV                     =  33;  // It is not possible to add files to a multi-volume archive.
  SQX_ERR_CANT_DELETE_FROM_MV                =  34;  // It is not possible to delete files from a multi-volume archive.
  SQX_ERR_NEED_1ST_VOLUME                    =  35;  // This file is part of a multi-volume archive. The first volume of the archive is needed to open it. Please select the first volume to open the archive.
  SQX_ERR_MISSING_VOLUME                     =  36;  // The last volume of the archive could not be found.
  SQX_ERR_VOLUME_LIMIT_REACHED               =  37;  // Cannot create more than 999 volumes.
  SQX_ERR_SFXSTUB_NOT_INSTALLED              =  38;  // This system lacks the support for the SFX type you have selected. Please visit the download section of http://ww.speedproject.de/ to obtain complete support for SFX archives.
  SQX_ERR_BACKUP_READ_ACCESS_DENIED          =  39;  // Read access to alternate data stream was denied. Only the file itself is being compressed.
  SQX_ERR_BACKUP_WRITE_ACCESS_DENIED         =  40;  // Could not write alternate data stream (e.g. file comments).
  SQX_ERR_ACL_READ_ACCESS_DENIED             =  41;  // Could not read security attributes. Only the file itself is being compressed.
  SQX_ERR_ACL_WRITE_ACCESS_DENIED            =  42;  // Could not write security attributes.
  SQX_ERR_WRONG_ARCHIVER_VERSION             =  43;  // This archive contains data created with a higher version of this software. Please download the lastest update of the software from http://www.speedproject.de/.
  SQX_ERR_CANT_COPY_SOURCE_TO_SOURCE         =  44;  // Cannot copy an archive to itself. Please choose a different target name.
  SQX_ERR_VOLUMES_TOO_SMALL                  =  45;  // The volume size cannot be smaller than 130 kByte.
  SQX_ERR_ARCHIVE_VERSION_TOO_HIGH           =  46;  // This archive can only be extracted. It is not possible to add files.
  SQX_ERR_EXT_RDATA_DOES_NOT_MATCH           =  47;  // The external recovery data don't seem to belong to the selected archive.
  SQX_ERR_BAD_PARAMETER                      =  48;  // Invalid Parameter
  SQX_ERR_EQUAL_PASSWORDS                    =  49;  // The passwords for the archive files and archive directory are identical. Please enter different passwords.
  SQX_ERR_REQUIRES_ENCRYPTION                =  50;  // You cannot encrypt the archive directory without encrypting the files. Please enter one password for the archive directory and another password for the files.
  SQX_ERR_MISSING_HEADER_PASSWORD            =  51;  // Please enter a password to encrypt the archive directory.
  SQX_ERR_MISSING_SQX_PRIVATE_KEY            =  52;  // Could not find/access the private key required to encrypt the archive. Please make sure that the software can access all the keys in question.
  SQX_ERR_MISSING_SQX_AVKEY                  =  53;  // Could not find the key required to create a digital signature. Please make sure that the software can access the authentication key.
  SQX_ERR_MISSING_EXTERNAL_AVKEY             =  54;  // Could not find/access the external key necessary to sign the archive. Please make sure that the software  can access all keys in question.
  SQX_ERR_INVALID_SQX_AVKEY                  =  55;  // The key you have selected to create digital signatures is invalid.
  SQX_ERR_SQX_AVKEY_VERSION                  =  56;  // This version of the software cannot use the existing key to create digital signatures. Please download the lastest update of the software from http://www.speedproject.de/.
  SQX_ERR_SQX_AVDATA_VERSION                 =  57;  // This version of the software cannot process the digital signature embedded within the archive. Please download the lastest update of the software from http://www.speedproject.de/.
  SQX_ERR_SQX_BROKEN_AVRECORD                =  58;  // The archive contains an invalid digital signature. The archive is either damaged or it has been manipulated.
  SQX_ERR_RIJNDAEL_RSA                       =  59;  // Unexpected error in an encryption function. Please contact our product support.
  SQX_ERR_REQUIRES_NTFS                      =  60;  // An option you selected requires NTFS.
  SQX_ERR_REQUIRES_WINNT                     =  61;  // An option you selected requires Windows NT.
  SQX_ERR_REQUIRES_W2K                       =  62;  // An option you selected requires Windows 2000.
  SQX_ERR_REQUIRES_WINXP                     =  63;  // An option you selected requires Windows XP.
  SQX_ERR_REQUIRES_WINXP_SP1                 =  64;  // An option you selected requires Windows XP SP1.
  SQX_ERR_REQUIRES_WINXP_SP2                 =  65;  // An option you selected requires Windows XP SP2.
  SQX_ERR_REQUIRES_LONGHORN                  =  66;  // An option you selected requires Longhorn.
  SQX_ERR_NO_RESOURCES_FOUND                 =  67;  // The selected SFX stub does not contain resources. Can not modify SFX stub.
  SQX_ERR_UNKNOWN_ICON_FORMAT                =  68;  // Could not determine the format of the selected icon file.
  SQX_ERR_NO_MATCHING_ICON_SIZE              =  69;  // The selected SFX stub does not contain icons with valid sizes. Can not modify SFX stub.
  SQX_ERR_UNKNOWN_EXE_FORMAT                 =  70;  // The format of the selected SFX stub is unknown.
  SQX_ERR_REQUIRES_SOURCE_PATH               =  71;  // The extended archive test requires the source path.
  SQX_ERR_FILE_DATA_NOT_EQUAL                =  72;  // Extended archive test: The source on hard disk is different from the file in the archive.
  SQX_ERR_COMMENT_BIGGER_4K                  =  73;  // You cannot add to the archive comments longer than 4096 chars. Please shorten your comments and try again.
  SQX_ERR_CANT_CREATE_SFX_FROM_MV            =  74;  // Cannot create a self-extracting archive from a multi-volume archive.


// ****************************************************************************
// ******                   Definition zu TSQX_FileTime                  ******
// ****************************************************************************
Type
  TSQX_PFileTime          = ^TSQX_FileTime;
  TSQX_FileTime           = Packed Record
                              fBlockPresent    : BOOL;       // Dateizeit ist gueltig
                              ftCreationTime   : Int64;      // Erstellung
                              ftLastAccessTime : Int64;      // Letzter Zugriff
                              ftLastWriteTime  : Int64;      // Letzter Schreibzugriff
                            End;
         
// ****************************************************************************
// ******                   Definition zu TSQX_ArcNode                   ******
// ****************************************************************************

  TSQX_PArcNode           = ^TSQX_ArcNode;
  TSQX_ArcNode            = Packed Record
                              pszFileName     : TPChar;           // Dateiname
                              dwFileNameLen   : LongWord;         // Laenge des Dateinamens
                              pExtraName      : TPChar;
                              dwExtraNameLen  : LongWord;
                              dwFileNameType  : LongWord;         // Filename base (0 ASCII, 1 ANSI, 2 UNICODE)
                              dwlSize         : Int64;            // Komprimierte Groesse
                              dwlSizeOrig     : Int64;            // Entpackte Groesse
                              dwDosFileTime   : LongWord;         // DOS-Zeit
                              dwAttributes    : LongWord;         // Dateiattribute
                              dwArcerVersion  : LongWord;         // Versionsnummer des Archivers
                              dwFileCRC       : LongWord;         // CRC der Datei
                              dwHostOS        : LongWord;         // OS, unter welchem die Datei komprimiert wurde
                              dwMethod        : LongWord;         // Kompressionsmethode
                              dwCommentLen    : LongWord;         // Laenge des Dateikommentars
                              pszComment      : TPChar;           // Dateikommentar
                              fEncrypted      : BOOL;             // Verschluesselung
                              fTagged         : BOOL;             // Eintrag ist gueltig, wenn ungleich 0
                              dwMappedMethod  : LongWord;         // Kompressionsmethode (SQ4)
                              dwExtendedError : LongWord;         // used when repairing archives
                              win32FileTime   : TSQX_FILETIME;    // Dateizeit
                           End;

// ****************************************************************************
// ******                   Definition zu TSQX_ArcListNode               ******
// ****************************************************************************

  TSQX_PArcListNode       = ^TSQX_ArcListNode;
  TSQX_ArcListNode        = Packed Record
                              pNext    : TSQX_PArcListNode;       // Naechster Eintrag
                              pArcNode : TSQX_PArcNode;           // Daten
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_ArcList                   ******
// ****************************************************************************

  TSQX_PArcList           = ^TSQX_ArcList;
  TSQX_ArcList            = Packed Record
                              dwItemCount : LongWord;             // Anzahl der Eintraege
                              pHead       : TSQX_PArcListNode;
                              pTail       : TSQX_PArcListNode;
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_AVInfo                    ******
// ****************************************************************************

  TSQX_PAVInfo            = ^TSQX_AVInfo;
  TSQX_AVInfo             = Packed Record
                              fAVInfoPresent : BOOL;                               // AV-Info ist da
                              szAV_ID        : Array[0..MAX_PATH - 1] Of TChar;    // AV-String
                              ftCreationTime : Int64;                              // Erstellzeit
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_ArcInfo                   ******
// ****************************************************************************

  TSQX_PArcInfo           = ^TSQX_ArcInfo;
  TSQX_ArcInfo            = Packed Record
                             cbSize              : LongWord;        // Groesse der Struktur
                             dwFileFormat        : LongWord;        // Archivformat
                             dwArcerMajorVersion : LongWord;        // Hauptversion des Archivers
                             dwArcerMinorVersion : LongWord;        // Nebenversion des Archivers
                             dwDictionarySize    : LongWord;        // Speichergroesse
                             fRecoveryData       : BOOL;            // Reparaturdaten
                             dwEncryption        : LongWord;        // Verschluesslung
                             fSolid              : BOOL;            // Solid-Archiv
                             dwHostOS            : LongWord;        // Betriebssystem
                             dwTotalFiles        : LongWord;        // Anzahl der Dateien
                             dwlCompressedSize   : Int64;           // Komprimierte Groesse
                             dwlUncompressedSize : Int64;           // Unkomprimierte Groesse
                             iRatio              : Integer;         // Einsparung
                             fHeaderEncrypted    : BOOL;            // Archivverzeichnis verschluesselt
                             fIsMultiVolume      : BOOL;            // Multivolume?
                             fArchiveComment     : BOOL;            // Archivkommentar
                             fFileComments       : BOOL;            // Dateikommentare
                             avInfo              : TSQX_AVInfo;     // AV-Info
                           End;
                  
// ****************************************************************************
// ******                   Definition zu TSQX_ExtractOptions            ******
// ****************************************************************************

  TSQX_PExtractOptions    = ^TSQX_ExtractOptions;
  TSQX_ExtractOptions     = Packed Record
                              cbSize                      : LongWord;                          // Groesse der Struktur
                     
                              szPassword                  : Array[0..MAX_PATH - 1] Of TChar;   // Kennwort
                              szPasswordHeader            : Array[0..MAX_PATH - 1] Of TChar;   // Kennwort fuer Archivverzeichnis
                              szTempDir                   : Array[0..MAX_PATH - 1] Of TChar;   // Temporaeres Verzeichnis
                              szRelativePath              : Array[0..MAX_PATH - 1] Of TChar;   // Relativer Ordner im Archiv
                              szOutputPath                : Array[0..MAX_PATH - 1] Of TChar;   // Ausgabeverzeichnis

                              fResetArchiveAttribute      : BOOL;                              // Archivattribut zuruecksetzen
                              fOverwriteAlways            : BOOL;                              // Immer ueberschreiben
                              fKeepBrokenFiles            : BOOL;                              // Beschaedigte Dateien erhalten
                              fCreateFolders              : BOOL;                              // Verzeichnisse erstellen
                     
                              fRestoreACLs                : BOOL;                              // ACL wiederherstellen
                              fRestoreStreams             : BOOL;                              // Streams wiederherstellen
                              fRestoreUnicodeNames        : BOOL;                              // Unicode-Dateien wiederherstellen
                              fRestoreWin32FileTimes      : BOOL;                              // Erweiterte Zeitstempel wiederherstellen
                              fRestoreDirectoryTimeStamps : BOOL;                              // Zeitstempel fuer Verzeichnisse wiederherstellen
                              fAutoRestoreComments        : BOOL;                              // Kommentare wiederherstellen
                              fSetZoneID                  : BOOL;                              // ZoneID wiederherstellen (0,Auto,Force)
                            End;
                     
// ****************************************************************************
// ******                   Definition zu TSQX_ForceComp                 ******
// ****************************************************************************

  TSQX_PForceComp         = ^TSQX_ForceComp;
  TSQX_ForceComp          = Packed Record
                              dwCompRate              : LongWord;   // Kompressionsrate
                              fSolidFlag              : BOOL;       // Solid-Archiv
                              dwDictionarySize        : LongWord;   // Speichergroesse
                              dwExeCompression        : LongWord;   // EXE-Komprimierung
                              dwTextCompression       : LongWord;   // PPM
                              dwTextMemory            : LongWord;   // Groesse in MB (4 - 128)
                              dwTextOrder             : LongWord;   // Ordnung vom PPM (1 - 16)
                              dwMultimediaCompression : LongWord;   // Multimedia-Kompression
                              dwMultimediaChannels    : LongWord;   // 0 - Automatisch (1-256)
                              dwAudioCompression      : LongWord;   // Audio-Kompression
                              dwAudioChannels         : LongWord;   // 0 - Automatisch (1-32)
                              dwAudioChannelsWidth    : LongWord;   // 8, 16
                              dwRgbCompression        : LongWord;   // RGB-Kompression
                              dwUltraMatchLink        : LongWord;   // Schnellere gegen bessere Kompression (1 - 10)
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_VersionInfo               ******
// ****************************************************************************                            

  TSQX_PVersionInfo       = ^TSQX_VersionInfo;
  TSQX_VersionInfo        = Packed Record
                             szLegalCopyright  : Array[0..39] Of TChar;
                             szCompanyName     : Array[0..39] Of TChar;
                             szFileDescription : Array[0..39] Of TChar;
                             szFileVersion     : Array[0..39] Of TChar;
                             szProductName     : Array[0..39] Of TChar;
                             szProductVersion  : Array[0..39] Of TChar;
                           End;

// ****************************************************************************
// ******                   Definition zu TSQX_SFXCommand                ******
// ****************************************************************************

  TSQX_PSFXCommand        = ^TSQX_SFXCommand;
  TSQX_SFXCommand         = Packed Record
                              fCreateSfx                  : BOOL;                              // SFX erstellen

                              // Allgemein
                              dwSfxType                   : LongWord;                          // Typ (Normal - SWInstall)
                              dwSfxSystem                 : LongWord;                          // System (DOS - WIN16 - WIN32 - WIN32 Alpha)

                              // HintDlg
                              szSfxHintTitle              : Array[0..255] Of TChar;            // Titel
                              szSfxHintMsg                : Array[0..4095] Of TChar;           // Text
                              dwSfxHintBtn                : LongWord;                          // Button (OK - YES/NO - OK/CANCEL)

                              // InfoAbout
                              szSfxInfoAboutMsg           : Array[0..255] Of TChar;            // Text

                              // Normale SFX'e
                              szSfxNormalFolder           : Array[0..MAX_PATH - 1] Of TChar;   // Zielordner
                              szSfxNormalCmd              : Array[0..MAX_PATH - 1] Of TChar;   // Befehl
                              fSfxNormalOverwriteWOPrompt : BOOL;                              // Immer ueberschreiben (Nur Normal)
                              fSfxNormalAutoExtract       : BOOL;                              // Sofort entpacken (Nur Normal)

                              // SW-Install
                              szSfxInstallMsg             : Array[0..255] Of TChar;            // Installationshinweis
                              szSfxInstallCmd             : Array[0..MAX_PATH - 1] Of TChar;   // Befehl
                              szSfxInstallWaitFor         : Array[0..MAX_PATH - 1] Of TChar;   // WaitFor

                              // Sonstiges
                              szIconFile                  : Array[0..MAX_PATH - 1] Of TChar;   // Iconpfad
                              szLanguageFile              : Array[0..MAX_PATH - 1] Of TChar;   // Sprachdatei
                    
                              // Versionsinfos
                              versionInfo                 : TSQX_VersionInfo;                  // Versionsinformation
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_CompressOptions           ******
// ****************************************************************************

  TSQX_PCompressOptions   = ^TSQX_CompressOptions;
  TSQX_CompressOptions    = Packed Record
                              cbSize                  : LongWord;                          // Groesse der Struktur
                              dwFileFormat            : LongWord;                          // Archivformat

                              compOptions             : TSQX_ForceComp;                    // Komprimierung
                              sfxCommand              : TSQX_SFXCommand;                   // SFX-Struktur
                      
                              dwRecoveryData          : LongWord;                          // Reparaturdaten
                              fExternalRecoveryData   : BOOL;                              // Externe Reparaturdaten
                              pszMainComment          : TPChar;                            // Hauptkommentar

                              // Verschluesselung und Signatur
                              dwEncryption            : LongWord;                          // Verschluesselung (Keine / Symmetrisch / Asymmetrisch)
                              fEncryptHeaders         : BOOL;                              // Archivverzeichnis verschluesseln
                              fAVSignature            : BOOL;                              // Signatur erstellen
                              fAVSignatureExternal    : BOOL;                              // Externe Signatur erstellen
                              dwAVEnvelope            : LongWord;                          // Verschluesslungsverfahren fuer die Signatur
                              szSignatureFile         : Array[0..MAX_PATH - 1] Of TChar;   // Alternative Signatur
                              szPassword              : Array[0..MAX_PATH - 1] Of TChar;   // Kennwort
                              szPasswordHeader        : Array[0..MAX_PATH - 1] Of TChar;   // Kennwort fuer Archivverzeichnis

                              // Diverses
                              fRetainFolderStructure  : BOOL;                              // Ordnerstruktur beibehalten
                              fRetainDrivePart        : BOOL;                              // Laufwerksbezeichner speichern
                              szRelativePath          : Array[0..MAX_PATH - 1] Of TChar;   // Relativer Pfad im Archiv
                              szInputPath             : Array[0..MAX_PATH - 1] Of TChar;   // Eingabeverzeichnis
                              dwFileNames             : LongWord;                          // Speicherung der Dateinamen
                              fStoreWin32FileTime     : BOOL;                              // Win32-Zeitangaben speichern
                              fStoreACL               : BOOL;                              // ACL speichern
                              fStoreStreams           : BOOL;                              // Streams speichern
                              fAutoSaveComments       : BOOL;                              // Kommentare automatisch speichern
                              fExtendedTest           : BOOL;                              // Testen nach Archivieren

                              szTempDir               : Array[0..MAX_PATH - 1] Of TChar;   // Temporaerer Ordner
                              dwlVolumeSize           : Int64;                             // Groesse der einzelnen Volumes
                              fAutoVolumeSize         : BOOL;                              // Volumegroesse selbstaendig berechnen
                              fCreateAlwaysNewArchive : BOOL;                              // Immer neues Archiv erstellen
                              fResetArchiveAttribute  : BOOL;                              // Archivattribut zuruecksetzen
                              dwLogType               : LongWord;                          // Logging
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_CallbackInfo              ******
// ****************************************************************************

  TSQX_PCallbackInfo      = ^TSQX_CallbackInfo;
  TSQX_CallbackInfo       = Packed Record
                              dwCallbackType   : LongWord;

                              // Dateiname
                              pszSourceFileName : TPChar;
                              pszTargetFileName : TPChar;

                              // Fortschritt
                              iProgress         : Integer;

                              // Ersetzen
                              pFindDataExist    : ^WIN32_FIND_DATA;
                              pFindDataReplace  : ^WIN32_FIND_DATA;

                              // Kennwortabfrage
                              szCryptKey        : Array[0..MAX_PATH - 1] Of TChar;
                              szOldCryptKey     : Array[0..MAX_PATH - 1] Of TChar;
                              szCryptFileName   : Array[0..MAX_PATH - 1] Of TChar;

                              // Naechste Disk
                              dwTotalSize       : LongWord;
                              dwDiskNum         : LongWord;
                              szNextDiskPath    : Array[0..MAX_PATH - 1] Of TChar;

                              // Signalfunktion und Fortschritt
                              dwSignal          : LongWord;
                              dwlBlockSize      : Int64;
                            End;

// ****************************************************************************
// ******                   Definition zu TSQX_Callback                  ******
// ****************************************************************************

  TSQX_PCallback          = ^TSQX_Callback;
  TSQX_Callback           = Function(
                              pParam        : Pointer;
                              pCallbackInfo : TSQX_PCallbackInfo): Integer;

// ****************************************************************************
// ******                   Definition zu TSQX_InitArchive               ******
// ****************************************************************************

  TSQX_PInitArchive       = ^TSQX_InitArchive;
  TSQX_InitArchive        = Function(
                              pszArchiveName : TPChar;
                              pfnCallback    : TSQX_Callback;
                              pParam         : Pointer;
                              Var phArchiver : THandle): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_DoneArchive               ******
// ****************************************************************************

  TSQX_PDoneArchive       = ^TSQX_DoneArchive;
  TSQX_DoneArchive        = Procedure(
                              hArchive: THandle); StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_InitFileList              ******
// ****************************************************************************

  TSQX_PInitFileList      = ^TSQX_InitFileList;
  TSQX_InitFileList       = Function(
                              hArchive: THandle): THandle; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_AppenFileList             ******
// ****************************************************************************

  TSQX_PAppendFileList    = ^TSQX_AppendFileList;
  TSQX_AppendFileList     = Procedure(
                              hArchive      : THandle;
                              hFileMaskList : THandle;
                              pszFileName   : TPChar); StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_DoneFileList              ******
// ****************************************************************************

  TSQX_PDoneFileList      = ^TSQX_DoneFileList;
  TSQX_DoneFileList       = Procedure(hArchive      : THandle;
                                      hFileMaskList : THandle); StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_InitArcFileList           ******
// ****************************************************************************

  TSQX_PInitArcFileList   = ^TSQX_InitArcFileList;
  TSQX_InitArcFileList    = Function(
                              hArchive: THandle): TSQX_PArcList; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_DoneArcFileList           ******
// ****************************************************************************

  TSQX_PDoneArcFileList   = ^TSQX_DoneArcFileList;
  TSQX_DoneArcFileList    = Procedure(
                              hArchive : THandle;
                              pList    : TSQX_PArcList); StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_ListFiles                 ******
// ****************************************************************************

  TSQX_PListFiles         = ^TSQX_ListFiles;
  TSQX_ListFiles          = Function(
                              hArchive      : THandle;
                              hFileMaskList : THandle;
                              pArcFileList  : TSQX_PArcList;
                              pArchiveInfo  : TSQX_PArcInfo): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_CompressFiles             ******
// ****************************************************************************

  TSQX_PCompressFiles     = ^TSQX_CompressFiles;
  TSQX_CompressFiles      = Function(
                              hArchive         : THandle;
                              pfnCallback      : TSQX_Callback;
                              pParam           : Pointer;
                              hFileMaskList    : THandle;
                              pCompressOptions : TSQX_PCompressOptions): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_ExtractFiles              ******
// ****************************************************************************

  TSQX_PExtractFiles      = ^TSQX_ExtractFiles;
  TSQX_ExtractFiles       = Function(
                              hArchive       : THandle;
                              pfnCallback    : TSQX_Callback;
                              pParam         : Pointer;
                              hFileMaskList  : THandle;
                              pExtractOption : TSQX_PExtractOptions): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_DeleteFiles               ******
// ****************************************************************************

  TSQX_PDeleteFiles       = ^TSQX_DeleteFiles;
  TSQX_DeleteFiles        = Function(
                              hArchive      : THandle;
                              pfnCallback   : TSQX_Callback;
                              pParam        : Pointer;
                              hFileMaskList : THandle): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_TestArchive               ******
// ****************************************************************************

  TSQX_PTestArchive       = ^TSQX_TestArchive;
  TSQX_TestArchive        = Function(
                              hArchive    : THandle;
                              pfnCallback : TSQX_Callback;
                              pParam      : Pointer): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_RepairArchive             ******
// ****************************************************************************

  TSQX_PRepairArchive     = ^TSQX_RepairArchive;
  TSQX_RepairArchive      = Function(
                              hArchive        : THandle;
                              pszRepairedFile : TPChar;
                              pGoodFileList   : TSQX_PArcList;
                              pBadFileList    : TSQX_PArcList): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_AddArchiveComment         ******
// ****************************************************************************

  TSQX_PAddArchiveComment = ^TSQX_AddArchiveComment;
  TSQX_AddArchiveComment  = Function(
                              hArchive       : THandle;
                              pszMainComment : TPChar): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_GetArchiveComment         ******
// ****************************************************************************

  TSQX_PGetArchiveComment = ^TSQX_GetArchiveComment;
  TSQX_GetArchiveComment  = Function(
                              hArchive       : THandle;
                              pszMainComment : TPChar;
                              cchMainComment : LongWord): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_AddFileComments           ******
// ****************************************************************************

  TSQX_PAddFileComments   = ^TSQX_AddFileComments;
  TSQX_AddFileComments    = Function(
                            hArchive      : THandle;
                            hFileMaskList : THandle;
                            pszComment    : TPChar): Integer; StdCall;

// ****************************************************************************
// ******                   Definition zu TSQX_CreateFolder              ******
// ****************************************************************************

  TSQX_PCreateFolder      = ^TSQX_CreateFolder;
  TSQX_CreateFolder       = Function(
                              hArchive  : THandle;
                              pszFolder : TPChar): Integer; StdCall;


// ****************************************************************************
// ******                  Implementation zu TSqxArchiveDll              ******
// ****************************************************************************
  THInstance = LongWord;
  TSQX_ArchiveDLL = Class

    // Konstruktion
    Public

      Constructor Create;
      Destructor  Destroy; Override;

    // Operationen
    Public

      // DLL
      Function  LoadArchiveDLL: Boolean;
      Procedure FreeArchiveDLL;

      // Initialisierung
      Function  InitArchive(
                  pszArchiveName : TPChar;
                  pfnCallback    : TSQX_Callback;
                  pParam         : Pointer): Integer;

      Procedure DoneArchive;

      // Dateilisten
      Function  InitFileList: THandle;

      Procedure AppendFileList(
                  hFileMaskList : THandle;
                  pszFileName   : TPChar);

      Procedure DoneFileList(
                  hFileMaskList: THandle);

      Function  InitArcFileList: TSQX_PArcList;

      Procedure DoneArcFileList(
                  pArcFileList: TSQX_PArcList);

      // Archivfunktionen
      Function ListFiles(
                 hFileMaskList : THandle;
                 pArcFileList  : TSQX_PArcList;
                 pArchiveInfo  : TSQX_PArcInfo): Integer;

      Function CompressFiles(
                 pfnCallback      : TSQX_Callback;
                 pParam           : Pointer;
                 hFileMaskList    : THandle;
                 pCompressOptions : TSQX_PCompressOptions): Integer;

      Function ExtractFiles(
                 pfnCallback     : TSQX_Callback;
                 pParam          : Pointer;
                 hFileMaskList   : THandle;
                 pExtractOptions : TSQX_PExtractOptions): Integer;

      Function DeleteFiles(
                 pfnCallback   : TSQX_Callback;
                 pParam        : Pointer;
                 hFileMaskList : THandle): Integer;

      Function TestArchive(
                 pfnCallback : TSQX_Callback;
                 pParam      : Pointer): Integer;

      Function RepairArchive(
                 pszRepairedFile : TPChar;
                 pGoodFileList   : TSQX_PArcList;
                 pBadFileList    : TSQX_PArcList): Integer;

      Function AddArchiveComment(
                 pszMainComment: TPChar): Integer;

      Function GetArchiveComment(
                 pszMainComment: TPChar;
                 cchMainComment: LongWord): Integer;

      Function AddFileComments(
                 hFileMaskList: THandle;
                 pszComment: TPChar): Integer;

      Function CreateFolder(
                 pszFolder: TPChar): Integer;

    // Implementation
    Protected

      Procedure ResetSQXFunctions;

    // Attribute
    Protected

      hInstSQXDLL             : THInstance;                // Instanz der DLL
      hArchive                : THandle;                   // Archivehandle

      // Funktionen
      SQXInitArchive       : TSQX_InitArchive;         // SQXInitArchive
      SQXDoneArchive       : TSQX_DoneArchive;         // SQXDoneArchive
      SQXInitFileList      : TSQX_InitFileList;        // SQXInitFileList
      SQXAppendFileList    : TSQX_AppendFileList;      // SQXAppendFileList
      SQXDoneFileList      : TSQX_DoneFileList;        // SQXDoneFileList
      SQXInitArcFileList   : TSQX_InitArcFileList;     // SQXInitArcFileList
      SQXDoneArcFileList   : TSQX_DoneArcFileList;     // SQXDoneArcFileList
      SQXListFiles         : TSQX_ListFiles;           // SQXListFiles
      SQXCompressFiles     : TSQX_CompressFiles;       // SQXCompressFiles
      SQXExtractFiles      : TSQX_ExtractFiles;        // SQXExtractFiles
      SQXDeleteFiles       : TSQX_DeleteFiles;         // SQXDeleteFiles
      SQXTestArchive       : TSQX_TestArchive;         // SQXTestArchive
      SQXRepairArchive     : TSQX_RepairArchive;       // SQXRepairArchive
      SQXAddArchiveComment : TSQX_AddArchiveComment;   // SQXAddArchiveComment
      SQXGetArchiveComment : TSQX_GetArchiveComment;   // SQXGetArchiveComment
      SQXAddFileComments   : TSQX_AddFileComments;     // SQXAddFileComments
      SQXCreateFolder      : TSQX_CreateFolder;        // SQXCreateFolder
  End;

  Function SQXCallback(pParam: Pointer;pCallbackInfo: TSQX_PCallbackInfo): Integer; StdCall;

Implementation

// ****************************************************************************
// ******                   Implementation zu SqxCallback                ******
// ****************************************************************************

  Constructor TSQX_ArchiveDLL.Create;

  Begin   { Create }

    hInstSQXDLL := 0;
    hArchive    := 0;

    ResetSQXFunctions;

  End;   { Create }

  // Aufraeumen
  Destructor TSQX_ArchiveDLL.Destroy;

  Begin   { Destroy }

    FreeArchiveDLL;

  End;   { Destroy }

  // SQX-DLL laden
  Function TSQX_ArchiveDLL.LoadArchiveDLL: Boolean;

  Var
    szDLLFileName            : TString;
    szFileNameA                      : Array[0..MAX_PATH] Of Char;
    szFileNameW                      : Array[0..MAX_PATH] Of WideChar;

  Begin   { LoadArchiveDLL }

    // DLL ist schon geladen
    If hInstSQXDLL <> 0 Then
      Result := True
    Else
    Begin
      // Name der DLL
      {$IfDef UNICODE}
      // Pfad zur DLL
      FillChar(szFileNameW, SizeOf(szFileNameW), 0);
      GetModuleFileNameW(hInstance, szFileNameW, MAX_PATH);

      szDLLFileName := ExtractFilePath(szFileNameW) + '\SQX20U.DLL';
      //ExtractFilePath muss noch für UnicodeDateinamen implementiert werden
      hInstSQXDLL := LoadLibraryW(PWideChar(szDLLFileName));
      {$Else}
      FillChar(szFileNameA, SizeOf(szFileNameA), 0);
      GetModuleFileNameA(hInstance, szFileNameA, MAX_PATH);

      szDLLFileName := ExtractFilePath(szFileNameA) + '\SQX20.DLL';
      hInstSQXDLL := LoadLibraryA(PChar(szDLLFileName));
      {$EndIf};
      

      If hInstSQXDLL = 0 Then
        Result := False
      Else
      Begin
        // Funktionen importieren
        SQXInitArchive       := GetProcAddress(hInstSQXDLL,'SqxInitArchive');
        SQXDoneArchive       := GetProcAddress(hInstSQXDLL,'SqxDoneArchive');
        SQXInitFileList      := GetProcAddress(hInstSQXDLL,'SqxInitFileList');
        SQXAppendFileList    := GetProcAddress(hInstSQXDLL,'SqxAppendFileList');
        SQXDoneFileList      := GetProcAddress(hInstSQXDLL,'SqxDoneFileList');
        SQXInitArcFileList   := GetProcAddress(hInstSQXDLL,'SqxInitArcFileList');
        SQXDoneArcFileList   := GetProcAddress(hInstSQXDLL,'SqxDoneArcFileList');
        SQXListFiles         := GetProcAddress(hInstSQXDLL,'SqxListFiles');
        SQXCompressFiles     := GetProcAddress(hInstSQXDLL,'SqxCompressFiles');
        SQXExtractFiles      := GetProcAddress(hInstSQXDLL,'SqxExtractFiles');
        SQXDeleteFiles       := GetProcAddress(hInstSQXDLL,'SqxDeleteFiles');
        SQXTestArchive       := GetProcAddress(hInstSQXDLL,'SqxTestArchive');
        SQXRepairArchive     := GetProcAddress(hInstSQXDLL,'SqxRepairArchive');
        SQXAddArchiveComment := GetProcAddress(hInstSQXDLL,'SqxAddArchiveComment');
        SQXGetArchiveComment := GetProcAddress(hInstSQXDLL,'SqxGetArchiveComment');
        SQXAddFileComments   := GetProcAddress(hInstSQXDLL,'SqxAddFileComments');
        SQXCreateFolder      := GetProcAddress(hInstSQXDLL,'SqxCreateFolder');

        // Fehlerhafter Import
        If (@SQXInitArchive = Nil)       Or (@SQXDoneArchive = Nil)       Or (@SQXInitFileList = Nil)
           Or
           (@SQXDoneFileList = Nil)      Or (@SQXInitArcFileList = Nil)   Or (@SQXDoneArcFileList = Nil)
           Or
           (@SQXListFiles = Nil)         Or (@SQXCompressFiles = Nil)     Or (@SQXExtractFiles = Nil)
           Or
           (@SQXDeleteFiles = Nil)       Or (@SQXTestArchive = Nil)       Or (@SQXRepairArchive = Nil)
           Or
           (@SQXAddArchiveComment = Nil) Or (@SQXGetArchiveComment = Nil) Or (@SQXAddFileComments = Nil)
           Or
           (@SQXCreateFolder = Nil)      Or (@SQXAppendFileList = Nil) Then
        Begin
          // DLL freigeben
          FreeArchiveDLL;

          // Fehler
          Result := False;
        End
        Else
          // Alles ok
        Result := True;
      End;
    End;
    
  End;   { LoadArchiveDLL }

  // SQX-DLL freigeben
  Procedure TSQX_ArchiveDLL.FreeArchiveDLL;

  Begin   { FreeArchiveDLL }

    // Archiver freigeben
    If hArchive <> 0 Then
      DoneArchive;

    // DLL entladen
    If hInstSQXDLL <> 0 Then
    Begin
      FreeLibrary(hInstSQXDLL);
      hInstSQXDLL := 0;
    End;

    // Funktionen zuruecksetzen
    ResetSQXFunctions;

  End;   { FreeArchiveDLL }

  // Dateiliste initialisieren
  Function TSQX_ArchiveDLL.InitFileList: THandle;

  Begin   { InitFileList }

    If hArchive <> 0 Then
      Result := SQXInitFileList(hArchive)
    Else
      Result := INVALID_HANDLE_VALUE;

  End;   { InitFileList }

  // Eintrag an Dateiliste anfuegen
  Procedure TSQX_ArchiveDLL.AppendFileList(hFileMaskList: THandle;pszFileName: TPChar);

  Begin   { AppendFileList }

    If hArchive <> 0 Then
      SQXAppendFileList(hArchive,hFileMaskList,pszFileName);
  End;   { AppendFileList }

  // Dateiliste freigeben
  Procedure TSQX_ArchiveDLL.DoneFileList(hFileMaskList: THandle);

  Begin   { DoneFileList }

    If hArchive <> 0 Then
      SQXDoneFileList(hArchive,hFileMaskList);

  End;   { DoneFileList }

  // Archivdateiliste initialisieren
  Function TSQX_ArchiveDLL.InitArcFileList: TSQX_PArcList;

  Begin   { InitArcFileList }

    If hArchive <> 0 Then
      Result := SQXInitArcFileList(hArchive)
    Else
      Result := Nil;

  End;   { InitArcFileList }

  // Archivdateiliste freigeben
  Procedure TSQX_ArchiveDLL.DoneArcFileList(pArcFileList: TSQX_PARCLIST);

  Begin   { DoneArcFileList }

    If hArchive <> 0 Then
      SQXDoneArcFileList(hArchive,pArcFileList);

  End;   { DoneArcFileList }

  // Archiv initialisieren
  Function TSQX_ArchiveDLL.InitArchive(pszArchiveName: TPChar;pfnCallback: TSQX_Callback;pParam: Pointer): Integer;

  Begin   { InitArchive }

    If hArchive = 0 Then
      Result := SQXInitArchive(pszArchiveName,pfnCallback,pParam,hArchive)
    Else
      Result := SQX_ERR_ERROR;

  End;   { InitArchive }

  // Archiv freigeben
  Procedure TSQX_ArchiveDLL.DoneArchive;

  Begin   { DoneArchive }

    If hArchive <> 0 Then
    Begin
      SQXDoneArchive(hArchive);
      hArchive := 0;
    End;

  End;   { DoneArchive }

  // Archivinhalt auflisten
  Function TSQX_ArchiveDLL.ListFiles(hFileMaskList : THandle;
                                     pArcFileList  : TSQX_PArcList;
                                     pArchiveInfo  : TSQX_PArcInfo): Integer;

  Begin   { ListFiles }

    If hArchive <> 0 Then
      Result := SQXListFiles(hArchive,hFileMaskList,pArcFileList,pArchiveInfo)
    Else
      Result := SQX_ERR_ERROR;

  End;   { ListFiles }

  // Dateien packen
  Function TSQX_ArchiveDLL.CompressFiles(pfnCallback      : TSQX_Callback;
                                         pParam           : Pointer;
                                         hFileMaskList    : THandle;
                                         pCompressOptions : TSQX_PCompressOptions): Integer;

  Begin   { CompressFiles }

    If hArchive <> 0 Then
      Result := SQXCompressFiles(hArchive,pfnCallback,pParam,hFileMaskList,pCompressOptions)
    Else
      Result := SQX_ERR_ERROR;

  End;   { CompressFiles }

  // Dateien entpacken
  Function TSQX_ArchiveDLL.ExtractFiles(pfnCallback     : TSQX_Callback;
                                        pParam          : Pointer;
                                        hFileMaskList   : THandle;
                                        pExtractOptions : TSQX_PExtractOptions): Integer;

  Begin   { ExtractFiles }

    If hArchive <> 0 Then
      Result := SQXExtractFiles(hArchive,pfnCallback,pParam,hFileMaskList,pExtractOptions)
    Else
      Result := SQX_ERR_ERROR;

  End;   { ExtractFiles }

  // Dateien loeschen
  Function TSQX_ArchiveDLL.DeleteFiles(pfnCallback   : TSQX_Callback;
                                       pParam        : Pointer;
                                       hFileMaskList : THandle): Integer;

  Begin   { DeleteFiles }

    If hArchive <> 0 Then
      Result :=  SQXDeleteFiles(hArchive,pfnCallback,pParam,hFileMaskList)
    Else
      Result := SQX_ERR_ERROR;

  End;   { DeleteFiles }

  // Archiv testen
  Function TSQX_ArchiveDLL.TestArchive(pfnCallback : TSQX_Callback;
                                       pParam      : Pointer): Integer;

  Begin   { TestArchive }

    If hArchive <> 0 Then
      Result := SQXTestArchive(hArchive,pfnCallback,pParam)
    Else
      Result := SQX_ERR_ERROR;

  End;   { TestArchive }

  // Archiv reparieren
  Function TSQX_ArchiveDLL.RepairArchive(pszRepairedFile : TPChar;
                                         pGoodFileList   : TSQX_PArcList;
                                         pBadFileList    : TSQX_PArcList): Integer;

  Begin   { RepairArchive }

    If hArchive <> 0 Then
      Result := SQXRepairArchive(hArchive,pszRepairedFile,pGoodFileList,pBadFileList)
    Else
      Result := SQX_ERR_ERROR;

  End;   { RepairArchive }

  // Archivkommentar setzen
  Function TSQX_ArchiveDLL.AddArchiveComment(pszMainComment: TPChar): Integer;

  Begin   { AddArchiveComment }

    If hArchive <> 0 Then
      Result :=  SQXAddArchiveComment(hArchive,pszMainComment)
    Else
      Result := SQX_ERR_ERROR;

  End;   { AddArchiveComment }

  // Archivkommentar abfragen
  Function TSQX_ArchiveDLL.GetArchiveComment(pszMainComment : TPCHAR;
                                             cchMainComment : LongWord): Integer;

  Begin   { GetArchiveComment }

    If hArchive <> 0 Then
      Result := SQXGetArchiveComment(hArchive,pszMainComment,cchMainComment)
    Else
      Result := SQX_ERR_ERROR;

  End;   { GetArchiveComment }

  // Dateikommentare hinzufuegen
  Function TSQX_ArchiveDLL.AddFileComments(hFileMaskList : THandle;
                                           pszComment    : TPChar): Integer;

  Begin   { AddFileComments }

    If hArchive <> 0 Then
      Result := SQXAddFileComments(hArchive,hFileMaskList,pszComment)
    Else
      Result := SQX_ERR_ERROR;

  End;   { AddFileComments }

  // Ordner erstellen
  Function TSQX_ArchiveDLL.CreateFolder(pszFolder: TPChar): Integer;

  Begin   { CreateFolder }

    If hArchive <> 0 Then
      Result := SQXCreateFolder(hArchive,pszFolder)
    Else
      Result := SQX_ERR_ERROR;

  End;   { CreateFolder }

  // Funktionen zuruecksetzen
  Procedure TSQX_ArchiveDLL.ResetSQXFunctions;

  Begin   { ResetSQXFunction }
    SQXInitArchive       := Nil;
    SQXDoneArchive       := Nil;
    SQXInitFileList      := Nil;
    SQXDoneFileList      := Nil;
    SQXInitArcFileList   := Nil;
    SQXDoneArcFileList   := Nil;
    SQXListFiles         := Nil;
    SQXCompressFiles     := Nil;
    SQXExtractFiles      := Nil;
    SQXDeleteFiles       := Nil;
    SQXTestArchive       := Nil;
    SQXRepairArchive     := Nil;
    SQXAddArchiveComment := Nil;
    SQXGetArchiveComment := Nil;
    SQXAddFileComments   := Nil;
    SQXCreateFolder      := Nil;

  End;   { ResetSQXFunctions }

  Function SQXCallback(pParam        : Pointer;
                       pCallbackInfo : TSQX_PCallbackInfo): Integer; StdCall;

  Var
    iResult                  : Integer;
    tstr                              : tString;
 
  Begin   { SQXCallback }

    iResult := 1;

    Case pCallbackInfo^.dwCallbackType Of
      // Dateiname fuer aktuelle Operation
      SQX_Callback_FILENAME        : Begin
                                       // Quell- und Zieldateiname
                                       // pCallbackInfo^.pszSourceFileName;
                                       // pCallbackInfo^.pszTargetFileName;

                                       iResult := SQX_PROGRESS_OK;
                                     End;

      // Fortschritt
      SQX_Callback_PROGRESS        : Begin
                                       // Einzelfortschritt und Blockgroesse
                                       // pCallbackInfo^.iProgress;
                                       // pCallbackInfo^.dwlBlockSize;

                                       iResult := SQX_PROGRESS_OK;
                                     End;

      // Datei ersetzen?
      SQX_Callback_REPLACE         : Begin
                                       // Infos fuer beide Dateien
                                       // pCallbackInfo^.pFindDataExist;
                                       // pCallbackInfo^.pFindDataReplace;

                                       iResult := SQX_REPLACE_OVERWRITE;
                                     End;

      // Kennwort abfragen
      SQX_Callback_PASSWORD        : Begin
                                       // Kennwort, vorheriges eingegebenes Kennwort (falls vorhanden) und Name der Datei
                                       // pCallbackInfo^.szCryptKey; // Out
                                       // pCallbackInfo^.szOldCryptKey;
                                       // pCallbackInfo^.szCryptFileName;
                                       {$ifdef unicode}
                                       showmessage('Datei Passwort geschützt');
                                       {$else}
                                       Lstrcpy(pCallbackInfo^.szCryptFileName, TPChar(tStr));
                                       If InputQuery('Passworteingabe', 'Passwort', tstr) Then
                                       Begin
                                         Lstrcpy(pCallbackInfo^.szCryptKey, TPChar(tStr));
                                         Lstrcpy(TPChar(tStr), pCallbackInfo^.szCryptFileName);
                                         iResult := SQX_PASSWORD_OK;
                                       End
                                       Else
                                       {$endif}
                                         iResult := SQX_PASSWORD_CANCEL;
                                     End;

      // Kennwort fuer Archivverzeichnis abfragen
      SQX_Callback_PASSWORD_HEADER : Begin
                                       // Kennwort, vorheriges eingegebenes Kennwort (falls vorhanden) und Name der Datei
                                       // pCallbackInfo^.szCryptKey; // Out
                                       // pCallbackInfo^.szOldCryptKey;
                                       // pCallbackInfo^.szCryptFileName;

                                       iResult := SQX_PASSWORD_OK;
                                     End;

      // Gesperrte Datei ueberspringen
      SQX_Callback_SKIP            : Begin
                                       // Name der gesperrten Datei
                                       // pCallbackInfo^.pszSourceFileName;

                                       iResult := SQX_SKIPFILE_SKIP;
                                     End;

      // Naechsten Datentraeger anfordern
      SQX_Callback_NEXTDISK        : Begin
                                       // Benoetigter Platz, Nummer des Dateitraegers, Pfad zum naechsten Volume
                                       // pCallbackInfo^.dwTotalSize;
                                       // pCallbackInfo^.dwDiskNum;
                                       // pCallbackInfo^.szNextDiskPath; // Out

                                       iResult := SQX_NEXTDISK_OK;
                                     End;

      // Aktion
      SQX_Callback_SIGNAL          : Begin
                                       Case pCallbackInfo^.dwSignal Of
                                         // Komprimieren
                                         SQX_SIGNAL_COMPRESS           : Begin
                                                                           // Gesamtanzahl an zu komprimierenden Bytes
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Entpacken
                                         SQX_SIGNAL_UNCOMPRESS         : Begin
                                                                           // Gesamtanzahl an zu entpackenden Bytes
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Loeschen
                                         SQX_SIGNAL_DELETE             : Begin
                                                                           // Anzahl der zu loeschenden Dateien
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Archiv temporaer kopieren
                                         SQX_SIGNAL_TEMP_ARC_COPY      : Begin
                                                                           // Anzahl der zu kopierenden Bytes
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // AV-Signatur erstellen
                                         SQX_SIGNAL_CREATE_AV_SIG      : Begin
                                                                           // Gesamtgroesse des Blocks
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // AV-Signatur testen
                                         SQX_SIGNAL_TEST_AV_SIG        : Begin
                                                                           // Gesamtgroesse des Blocks
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Multivolume entpacken
                                         SQX_SIGNAL_ADD_MV_UNCOMPRESS  : Begin
                                                                           // Groesse des aktuellen Volumes, muss zur Gesamtgroesse addiert werden
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Reparaturdaten erstellen
                                         SQX_SIGNAL_CREATE_RDATA       : Begin
                                                                           // Gesamtgroesse des Blocks
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Archiv reparieren
                                         SQX_SIGNAL_REPAIR_ARCHIVE     : Begin
                                                                           // Anzahl der Dateien
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Reparaturdaten entfernen
                                         SQX_SIGNAL_STRIP_RDATA        : Begin
                                                                           // Gesamtgroesse des Blocks
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // SFX erstellen
                                         SQX_SIGNAL_CREATE_SFX_ARCHIVE : Begin
                                                                         End;

                                         // Archiv testen
                                         SQX_SIGNAL_TEST_ARCHIVE       : Begin
                                                                           // Gesamtgroesse des Blocks
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Archiv testen (neues Volume)
                                         SQX_SIGNAL_ADD_MV_TEST        : Begin
                                                                           // Groesse des aktuellen Volumes, muss zur Gesamtgroesse addiert werden
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Erweitertes Testen nach dem Archivieren
                                         SQX_SIGNAL_EX_TEST_ARCHIVE    : Begin
                                                                           // Gesamtgroesse des Blocks
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;

                                         // Erweitertes Testen nach dem Archivieren (neues Volume)
                                         SQX_SIGNAL_ADD_MV_EX_TEST     : Begin
                                                                           // Groesse des aktuellen Volumes, muss zur Gesamtgroesse addiert werden
                                                                           // pCallbackInfo^.dwlBlockSize;
                                                                         End;
                                       End;
                                     End;
    End;

    // Alles ok
    Result := iResult;

    
  End;   { SQXCallback }

End.


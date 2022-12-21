Unit SQXDemoUnit;

Interface

Uses
  Classes,
  Controls,
  Dialogs,
  Forms,
  Graphics,
  Messages,
  SQXarchiveDLL,
  StdCtrls,
  SysUtils,
  Windows,
  Buttons;

Type
  TSQXForm = Class(TForm)
    btnCompressingFiles : TButton;
    btnExtractingFiles : TButton;
    btnListingFiles : TButton;
    bitbtnClose : TBitBtn;

    Procedure btnCompressingFilesClick(Sender : TObject);
    Procedure btnExtractingFilesClick(Sender : TObject);
    Procedure btnListingFilesClick(Sender : TObject);

  Private
    { Private-Deklarationen }
  Public
    { Public-Deklarationen }
  End;

Var
  SQXForm                     : TSQXForm;

Implementation

{$R *.DFM}

Procedure TSQXForm.btnCompressingFilesClick(Sender : TObject);

Var
  archiveDLL                  : TSQX_archiveDLL;
  iStatus                     : Integer;
  hFileMaskList               : THandle;
  compressOptions             : TSQX_CompressOptions;
  hFile                       : THandle;
  naechste                    : Boolean;
  {$IFDEF Unicode}
  si                          : TWin32FindDataW;
  {$ELSE}
  si                          : TWin32FindData;
  {$ENDIF}
  TStr                        : TString;
Begin { btnCompressingFilesClick }

  archiveDLL := TSQX_archiveDLL.Create;

  If (archiveDLL <> Nil) And (archiveDLL.LoadarchiveDLL) Then
  Begin
    tStr := 'Test.sqx';
    {$IFDEF Unicode}
    DeleteFileW(Pwidechar(tStr));
    {$ELSE}
    DeleteFile(Pchar(tStr));
    {$ENDIF}
    iStatus := archiveDLL.InitArchive(TPCHAR(tStr),@SQXCallback,Self);
    tStr := GetCurrentDir + '\Test\*.*';

    {$IFDEF Unicode}
    hFile := FindFirstFileW(TPChar(tStr),si);
    {$ELSE}
    hFile := FindFirstFile(TPChar(tStr),si);
    {$ENDIF}

    naechste := true;
    If (hFile <> INVALID_HANDLE_VALUE) Then
      If (SQX_ERR_SUCCESS = iStatus) Then
      Begin
        // Create a file list
        hFileMaskList := archiveDLL.InitFileList;
        While naechste Do
        Begin
          tStr := si.cFileName;
          If Not (si.dwFileAttributes = si.dwFileAttributes Or FILE_ATTRIBUTE_DIRECTORY) Then
            archiveDLL.AppendFileList(hFileMaskList,TPChar(tStr));
          {$IFDEF Unicode}
          naechste := FindNextFileW(hFile,si);
          {$ELSE}
          naechste := FindNextFile(hFile,si);
          {$ENDIF}
        End;

        FindClose(hFile);

        // Compress options
        FillChar(compressOptions,SizeOf(compressOptions),0);
        compressOptions.cbSize := SizeOf(compressOptions);

        // Create SQX2 archive
        compressOptions.dwFileFormat := SQX_FILEFORMAT_20;

        // SaveUnicodeFilename
        compressOptions.dwFileNames := SQX_FILENAME_UNICODE;
                               
        // Core compression options
        compressOptions.compOptions.dwCompRate := SQX_COMPRATE_FAST;
        compressOptions.compOptions.dwDictionarySize := SQX_DICTIONARY_4M;
        compressOptions.compOptions.fSolidFlag := True;

        (*//Beispiel für die Passwortvergabe
        compressOptions.dwEncryption:=3;
        tStr := 'SpeedProject';
        {$IFDEF Unicode}
        LstrcpyW(compressOptions.szPassword,TPChar(tStr));
        {$ELSE}
        Lstrcpy(compressOptions.szPassword,TPChar(tStr));
        {$ENDIF}*)

        // Extended compression options
        compressOptions.compOptions.dwExeCompression := SQX_SPECIALCOMP_AUTOMATIC;
        compressOptions.compOptions.dwRgbCompression := SQX_SPECIALCOMP_AUTOMATIC;
        compressOptions.compOptions.dwTextCompression := SQX_SPECIALCOMP_AUTOMATIC;
        compressOptions.compOptions.dwAudioCompression := SQX_SPECIALCOMP_AUTOMATIC;
        compressOptions.compOptions.dwMultimediaCompression := SQX_SPECIALCOMP_AUTOMATIC;

        // Additional options
        compressOptions.fRetainFolderStructure := True;

        // Source path for the files to be compressed
        tStr := Getcurrentdir + '\Test';

        {$IFDEF Unicode}
        LstrcpyW(compressOptions.szInputPath,TPChar(tStr));
        {$ELSE}
        Lstrcpy(compressOptions.szInputPath,TPChar(tStr));
        {$ENDIF}

        // Compress the files
        iStatus := archiveDLL.CompressFiles(@SQXCallback,Self,hFileMaskList,@compressOptions);

        If SQX_ERR_SUCCESS <> iStatus Then
          Showmessage(inttostr(iStatus));

        // Free the file list
        archiveDLL.DoneFileList(hFileMaskList);
      End;

    // Close the archive
    archiveDLL.DoneArchive;

  End;

End; { btnCompressingFilesClick }

Procedure TSQXForm.btnExtractingFilesClick(Sender : TObject);

Var
  archiveDll                  : TSQX_archiveDLL;
  iStatus                     : Integer;
  hFileMaskList               : THandle;
  extractOptions              : TSQX_EXTRACTOPTIONS;
  tStr                        : TString;

Begin { btnExtractingFilesClick }

  archiveDLL := TSQX_archiveDLL.Create;

  If archiveDll.LoadArchiveDll Then
  Begin
    tStr := 'TEST.SQX';
    iStatus := archiveDll.InitArchive(TPCHAR(tStr),@SqxCallback,Self);
    If SQX_ERR_SUCCESS = iStatus Then
    Begin
      // Create a file list
      hFileMaskList := archiveDll.InitFileList;

      // Extracting all files
      archiveDll.AppendFileList(hFileMaskList, '*.*');

      // Extract options
      fillchar(extractOptions,sizeof(extractOptions),0);
      extractOptions.cbSize := sizeof(extractOptions);

      // Extract to C:\Test
      CreateDir(getcurrentdir + '\OutTest');

      tStr := getcurrentdir + '\OutTest\';
      {$IFDEF Unicode}
      LstrcpyW(extractOptions.szOutputPath,TPChar(tStr));
      {$ELSE}
      Lstrcpy(extractOptions.szOutputPath,TPChar(tStr));
      {$ENDIF}

      extractOptions.fCreateFolders := TRUE;

      extractOptions.fRestoreUnicodeNames := TRUE;

      // Extract the archive
      iStatus := archiveDll.ExtractFiles(@SqxCallback,Self,hFileMaskList,@extractOptions);
      If (SQX_ERR_SUCCESS <> iStatus) Then
      Begin
        // Error
      End;

      // Free the file list
      archiveDll.DoneFileList(hFileMaskList);
    End;

    // Close the archive
    archiveDll.DoneArchive;
  End;

End; { btnExtractingFilesClick }

Procedure TSQXForm.btnListingFilesClick(Sender : TObject);

Var
  archiveDll                  : TSQX_archiveDLL;
  iStatus                     : Integer;
  hFileMaskList               : THandle;
  pArcFileList                : TSQX_PArcList;
  archiveInfo                 : TSQX_ARCINFO;
  pListNode                   : TSQX_PArcListNode;
  tStr                        : TString;

Begin { btnListingFilesClick }

  archiveDLL := TSQX_archiveDLL.Create;

  If archiveDll.LoadArchiveDll Then
  Begin
    tStr := 'TEST.SQX';
    iStatus := archiveDll.InitArchive(TPCHAR(tStr),@SqxCallback,Self);
    If SQX_ERR_SUCCESS = iStatus Then
    Begin
      // Create the lists
      hFileMaskList := archiveDll.InitFileList;
      pArcFileList := archiveDll.InitArcFileList();

      // Initialize archive information
      FillChar(archiveInfo,SizeOf(archiveInfo),0);
      archiveInfo.cbSize := SizeOf(archiveInfo);

      // Listing all files
      archiveDll.AppendFileList(hFileMaskList, '*.*');

      // List the archive
      iStatus := archiveDll.ListFiles(hFileMaskList,pArcFileList,@archiveInfo);
      If SQX_ERR_SUCCESS = iStatus Then
      Begin
        // Getting the first node
        pListNode := pArcFileList^.pHead;
        While pListNode <> Nil Do
        Begin
          // Node is valid
          If pListNode^.pArcNode^.fTagged Then
            {$IFDEF Unicode}
            MessageBoxW(0,pListNode^.pArcNode^.pszFileName, 'Listing Files',0);
            {$ELSE}
            Showmessage(pListNode^.pArcNode^.pszFileName);
            {$ENDIF}
          // Next node
          pListNode := pListNode^.pNext;
        End;
      End;

      // Free the lists
      archiveDll.DoneFileList(hFileMaskList);
      archiveDll.DoneArcFileList(pArcFileList);
    End;
    // Close the archive
    archiveDll.DoneArchive;
  End;

End; { btnListingFilesClick }

End.


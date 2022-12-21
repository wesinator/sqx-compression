/*
 * Created by SharpDevelop.
 * User: LYCJ
 * Date: 29/11/2006
 * Time: 17:24
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

/* Copyright (c) 2007, Leung Yat Chun Joseph (LYCJ)
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the QuickZip.org nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY LYCJ ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL LYCJ BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;

namespace Cake3.SqxArc
{
	public class Kernel
	{
		public const Int32 MAXPATH = 260;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_FILETIME 
	{
		public bool fBlockPresent;
		public Int64 ftCreationTime;
		public Int64 ftLastAccessTime;
		public Int64 ftLastWriteTime;			
	}								
		
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_ARCNODE
	{
		[MarshalAs(UnmanagedType.LPStr)]public string pszFileName;
		public Int32 dwFileNameLen;
		[MarshalAs(UnmanagedType.LPStr)]public string pszExtraName;
		public Int32 dwExtraNameLen;
		public Int32 dwFileNameType;
		public Int64 dwlSize;
		public Int64 dwlSizeOrig;
		public Int32 dwDosFileTime;
		public Int32 dwAttributes;
		public Int32 dwArcerVersion;
		public Int32 dwFileCRC;
		public Int32 dwHostOS;
		public Int32 dwMethod;
		public Int32 dwCommentLen;
		[MarshalAs(UnmanagedType.LPStr)]public string pszComment;
		public bool fEncrypted;
		public bool fTagged;
		public Int32 dwMappedMethod;
		public Int32 dwExtendedError;
		public SQX_FILETIME win32FileTime;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_ARCLISTNODE
	{
		public IntPtr pNext; 	//SQX_ARCLISTNODE
		public IntPtr pArcNode; //SQX_ARCNODE
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_AVINFO
	{
		public bool fAVInfoPresent;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 255)]
		public string szAV_ID;
		public Int64 ftCreationTime;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_ARCINFO
	{
		public UInt32 cbSize;
		public UInt32 dwFileFormat;
		public UInt32 dwArcerMajorVersion;
		public UInt32 dwArcerMinorVersion;
		public UInt32 dwDictionarySize;
		public bool fRecoveryData;
		public UInt32 dwEncryption;
		public bool fSolid;
		public UInt32 dwHostOS;
		public UInt32 dwTotalFiles;
		public Int64 dwlCompressedSize;
		public Int64 dwlUncompressedSize;
		public Int32 iRatio;
		public bool fHeaderEncrypted;
		public bool fIsMultiVolume;
		public bool fArchiveComment;
		public bool fFileComments;
		public SQX_AVINFO avInfo;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_ARCLIST
	{
		public UInt32 dwItemCount;
		public IntPtr pHead;
		public IntPtr pTail;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_EXTRACTOPTIONS
	{
		public Int32 cbSize;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szPassword;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szPasswordHeader;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szTempDir;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szRelativePath;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szOutputPath;
		public bool fResetArchiveAttribute;
		public bool fOverwriteAlways;
		public bool fKeepBrokenFiles;
		public bool fCreateFolders;
		public bool fRestoreACLs;
		public bool fRestoreStreams;
		public bool fRestoreUnicodeNames;
		public bool fRestoreWin32FileTimes;
		public bool fRestoreDirectoryTimeStamps;
		public bool fAutoRestoreComments;
		public bool fSetZoneID;		
		
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_FORCECOMP 
	{
		public Int32 dwCompRate;
		public bool fSolidFlag;
		public Int32 dwDictionarySize;
		public Int32 dwExeCompression;
		public Int32 dwTextCompression;
		public Int32 dwTextMemory;
		public Int32 dwTextOrder;
		public Int32 dwMultimediaCompression;
		public Int32 dwMultimediaChannels;
		public Int32 dwAudioCompression;
		public Int32 dwAudioChannels;
		public Int32 dwAudioChannelsWidth;
		public Int32 dwRgbCompression;
		public Int32 dwUltraMatchLink;
	}
	
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_VERSIONINFO
	{
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 40)]public string szLegalCopyright;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 40)]public string szCompanyName;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 40)]public string szFileDescription;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 40)]public string szFileVersion;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 40)]public string szProductName;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 40)]public string szProductVersion;		
    }
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_SFXCOMMAND
	{
		public bool fCreateSfx;
		public Int32 dwType;
		public Int32 dwSystem;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]public string szHintTitle;	
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst =4096)]public string szHintMsg;	
		public Int32 dwHintBtn;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]public string szInfoAboutMsg;	
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szNormalFolder;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szNormalCmd;
		public bool fNormalOverwriteWOPrompt;
		public bool fNormalAutoExtract;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]public string szInstallMsg;	
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szInstallCmd;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szInstallWaitFor;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szIconFile;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szLanguageFile;
		public SQX_VERSIONINFO versionInfo;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_COMPRESSOPTIONS
	{
		public Int32 cbSize;
		public Int32 dwFileFormat;
		public SQX_FORCECOMP compOptions;
		public SQX_SFXCOMMAND sfxCommand;
		public Int32 dwRecoveryData;
		public bool fExternalRecoveryData;
		[MarshalAs(UnmanagedType.LPStr)]public string pszMainComment;
		public Int32 dwEncryption;
		public bool fEncryptHeaders;
		public bool fAVSignature;
		public bool fAVSignatureExternal;
		public Int32 dwAVEnvelope;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szSignatureFile;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szPassword;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szPasswordHeader;
		public bool fRetainFolderStructure;
		public bool fRetainDrivePart;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szRelativePath;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szInputPath;
		public Int32 dwFileNames;
		public bool fStoreWin32FileTime;
		public bool fStoreACL;
		public bool fStoreStreams;
		public bool fAutoSaveComments;
		public bool fExtendedTest;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szTempDir;
		public Int64 dwlVolumeSize;
		public bool fAutoVolumeSize;
		public bool fCreateAlwaysNewArchive;
		public bool fResetArchiveAttribute;
		public Int32 dwLogType;
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct FILETIME
	{
		public UInt32 dwLowDateTime;
		public UInt32 dwHighDateTime;		
	}
	
	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct LPWIN32_FIND_DATA
	{
		public UInt32 dwFileAttributes;
		public FILETIME ftCreationTime;
		public FILETIME ftLastAccessTime;
		public FILETIME ftLastWriteTime;
		public UInt32 nFileSizeHigh;
		public UInt32 nFileSizeLow;
		public UInt32 dwReserved0;
		public UInt32 dwReserved1;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string cFileName;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 14)]public string cAlternateFileName;
	}

	[StructLayout(LayoutKind.Sequential, Pack=1, CharSet=CharSet.Ansi)]
	public struct SQX_CALLBACKINFO
	{
		public UInt32 dwCallbackType;
		[MarshalAs(UnmanagedType.LPStr)]public string pszSourceFileName;
		[MarshalAs(UnmanagedType.LPStr)]public string pszTargetFileName;
		public Int32 iProgress;		
		public LPWIN32_FIND_DATA pFindDataExist;		//LPWIN32_FIND_DATA
		public LPWIN32_FIND_DATA pFindDataReplace;		//LPWIN32_FIND_DATA
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szCryptKey;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szOldCryptKey;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szCryptFileName;
		public UInt32 dwTotalSize;
		public UInt32 dwDiskNum;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = Kernel.MAXPATH)]public string szNextDiskPath;
		public UInt32 dwSignal;
		public Int64 dwlBlockSize;
	}
	
	
	public delegate int dSqxCallback(IntPtr pParam, ref SQX_CALLBACKINFO CallbackInfo);
	
	[StructLayoutAttribute( LayoutKind.Sequential, CharSet = CharSet.Ansi )]
	public struct Delegate_Wrapper
	{
    	[MarshalAsAttribute(UnmanagedType.FunctionPtr)]
    	public dSqxCallback  _delegate;
	};
}

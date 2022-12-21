/*
 * Created by SharpDevelop.
 * User: LYCJ
 * Date: 27/1/2007
 * Time: 16:33
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
using System.Runtime.InteropServices;

namespace Cake3.SqxArc
{
	/// <summary>
	/// Description of Header.
	/// </summary>
	public class Header
	{
		#region Constants		
		public enum ErrorCodes
		{
			SQX_ERR_SUCCESS = 0,
			SQX_ERR_ERROR,
			SQX_ERR_FILE_NOT_FOUND,
			SQX_ERR_PATH_NOT_FOUND,
			SQX_ERR_TOO_MANY_FILES,
			SQX_ERR_ACCESS_DENIED,
			SQX_ERR_INVALID_HANDLE,
			SQX_ERR_DISK_FULL,
			SQX_ERR_OUT_OF_MEMORY,
			SQX_ERR_CANT_ACCESS_TEMP_DIR,
			SQX_ERR_TEMP_DIR_FULL,
			SQX_ERR_USER_ABORT,
			SQX_ERR_INVALID_ARC_HANDLE,
			SQX_ERR_CANT_FIND_LANG_DATA,
			SQX_ERR_UNKNOWN_SUBSTREAM,
			SQX_ERR_BAD_SUBSTREAM_CRC,
			SQX_ERR_UNKNOWN_METHOD,
			SQX_ERR_FILE_ENCRYPTED,
			SQX_ERR_BAD_CRC,
			SQX_ERR_CANT_CREATE_FILE,
			SQX_ERR_BAD_FILE_FORMAT,
			SQX_ERR_FUNCTION_NOT_SUPPORTED,
			SQX_ERR_FUNC_NOT_SUPPORTED_BY_ARCHIVE,
			SQX_ERR_CANT_CREATE_ARC_DIR,
			SQX_ERR_INVALID_DIR_NAME,
			SQX_ERR_INVALID_FILE_NAME,
			SQX_ERR_TOO_MANY_BROKEN_FBLOCKS,
			SQX_ERR_ARCHIVE_OK_RDATA_NOT,
			SQX_ERR_RDATA_DAMAGED,
			SQX_ERR_RDATA_NEW_VERSION,
			SQX_ERR_RDATA_DOES_NOT_MATCH,
			SQX_ERR_CANT_FIND_RDATA,
			SQX_ERR_ARCHIVE_IS_LOCKED,
			SQX_ERR_CANT_ADD_TO_MV,
			SQX_ERR_CANT_DELETE_FROM_MV,
			SQX_ERR_NEED_1ST_VOLUME,
			SQX_ERR_MISSING_VOLUME,
			SQX_ERR_VOLUME_LIMIT_REACHED,
			SQX_ERR_SFXSTUB_NOT_INSTALLED,
			SQX_ERR_BACKUP_READ_ACCESS_DENIED,
			SQX_ERR_BACKUP_WRITE_ACCESS_DENIED,
			SQX_ERR_ACL_READ_ACCESS_DENIED,
			SQX_ERR_ACL_WRITE_ACCESS_DENIED,
			SQX_ERR_WRONG_ARCHIVER_VERSION,
			SQX_ERR_CANT_COPY_SOURCE_TO_SOURCE,
			SQX_ERR_VOLUMES_TOO_SMALL,
			SQX_ERR_ARCHIVE_VERSION_TOO_HIGH,
			SQX_ERR_EXT_RDATA_DOES_NOT_MATCH,
			SQX_ERR_BAD_PARAMETER,
			SQX_ERR_EQUAL_PASSWORDS,
			SQX_ERR_REQUIRES_ENCRYPTION,
			SQX_ERR_MISSING_HEADER_PASSWORD,
			SQX_ERR_MISSING_SQX_PRIVATE_KEY,
			SQX_ERR_MISSING_SQX_AVKEY,
			SQX_ERR_MISSING_EXTERNAL_AVKEY,
			SQX_ERR_INVALID_SQX_AVKEY,
			SQX_ERR_SQX_AVKEY_VERSION,
			SQX_ERR_SQX_AVDATA_VERSION,
			SQX_ERR_SQX_BROKEN_AVRECORD,
			SQX_ERR_RIJNDAEL_RSA,
			SQX_ERR_REQUIRES_NTFS,
			SQX_ERR_REQUIRES_WINNT,
			SQX_ERR_REQUIRES_W2K,
			SQX_ERR_REQUIRES_WINXP,
			SQX_ERR_REQUIRES_WINXP_SP1,
			SQX_ERR_REQUIRES_WINXP_SP2,
			SQX_ERR_REQUIRES_LONGHORN,
			SQX_ERR_NO_RESOURCES_FOUND,
			SQX_ERR_UNKNOWN_ICON_FORMAT,
			SQX_ERR_NO_MATCHING_ICON_SIZE,
			SQX_ERR_UNKNOWN_EXE_FORMAT,
			SQX_ERR_REQUIRES_SOURCE_PATH,
			SQX_ERR_FILE_DATA_NOT_EQUAL,
			SQX_ERR_COMMENT_BIGGER_4K,
			SQX_ERR_CANT_CREATE_SFX_FROM_MV
		}	
		
		public const string DllName = "sqx20.dll";		
		public enum FileFormat
		{
			SQX_FILEFORMAT_10 = 0,
			SQX_FILEFORMAT_20 = 1
		};
		public enum CompressRate
		{
			SQX_COMPRATE_STORED 	= 0,
			SQX_COMPRATE_FAST 		= 1,
			SQX_COMPRATE_NORMAL 	= 2,
			SQX_COMPRATE_HIGH 		= 3,
			SQX_COMPRATE_MAXIMIUM 	= 4,
			SQX_COMPRATE_ULTRA 		= 5			
		};
		
		public enum CompressMethod
		{
			SQX_METHOD_STORED	= 0,
			SQX_METHOD_NORMAL	= 1,
			SQX_METHOD_GOOD		= 2,
			SQX_METHOD_HIGH		= 3,
			SQX_METHOD_BEST		= 4,
			SQX_METHOD_AUDIO	= 5,
			SQX_METHOD_TEXT		= 6,
			SQX_METHOD_ULTRA	= 7,
		}
		
		public enum DictionarySize
		{
			SQX_DICTIONARY_32K 	= 3,
			SQX_DICTIONARY_64K 	= 4,
			SQX_DICTIONARY_128K = 5,
			SQX_DICTIONARY_256K	= 6,
			SQX_DICTIONARY_512K	= 7,
			SQX_DICTIONARY_1M	= 8,
			SQX_DICTIONARY_2M	= 9,
			SQX_DICTIONARY_4M	= 10,
			SQX_DICTIONARY_8M	= 11,
			SQX_DICTIONARY_16M	= 12,
			SQX_DICTIONARY_32M	= 13,
		};
		
		public enum FileNameEncode
		{
			SQX_FILENAME_ANSI	= 0,
			SQX_FILENAME_ASCII	= 1,
			SQX_FILENAME_UNICODE= 2
		};
		
		public enum SpecialCompressor
		{
			SQX_SPECIALCOMP_DISABLED	= 0, 
			SQX_SPECIALCOMP_AUTOMATIC	= 1, 
			SQX_SPECIALCOMP_FORCE		= 2
		}
		
		public enum Callback
		{
			SQX_CALLBACK_FILENAME 		= 0,
			SQX_CALLBACK_PROGRESS		= 1,
			SQX_CALLBACK_REPLACE		= 2,
			SQX_CALLBACK_PASSWORD		= 3,
			SQX_CALLBACK_PASSWORD_HEADER= 4,
			SQX_CALLBACK_SKIP			= 5,
			SQX_CALLBACK_NEXTDISK		= 6,
			SQX_CALLBACK_SIGNAL			= 7
		}
		#endregion
		
		#region DllHeader
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static Int32 SqxInitArchive([MarshalAs(UnmanagedType.LPStr)]string pszArchiveName,
		                                           dSqxCallback pfnCallback,
		                                           IntPtr pParam,
		                                           ref IntPtr phArchive);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static void SqxDoneArchive(IntPtr hArchive);
				
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static IntPtr SqxInitFileList(IntPtr hArchive);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static void SqxDoneFileList(IntPtr hArchive, IntPtr hFileMaskList);

		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static IntPtr SqxInitArcFileList(IntPtr hArchive);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static void SqxDoneArcFileList(IntPtr hArchive, IntPtr pArcFileList);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static Int32 SqxListFiles(IntPtr hArchive, IntPtr hFileMaskList, ref SQX_ARCLIST pArcFileList,ref SQX_ARCINFO pArchiveInfo);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static void SqxAppendFileList(IntPtr hArchive, IntPtr hFileMaskList, string pszFileName);
					
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static Int32 SqxTestArchive(IntPtr hArchive, dSqxCallback pfnCallback, IntPtr pParam);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static Int32 SqxExtractFiles(IntPtr hArchive, dSqxCallback pfnCallback, IntPtr pParam, 
		                                            IntPtr hFileMaskList, 	
		                                            ref SQX_EXTRACTOPTIONS pExtractOptions); 		
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static Int32 SqxCompressFiles(IntPtr hArchive, dSqxCallback pfnCallback, IntPtr pParam,
		                                             IntPtr hFileMaskList,
		                                             ref SQX_COMPRESSOPTIONS pCompressOptions);
		
		[DllImport(DllName, CharSet=CharSet.Ansi, CallingConvention=CallingConvention.StdCall)]
		private extern static Int32 SqxDeleteFiles(IntPtr hArchive, dSqxCallback pfnCallback, IntPtr pParam,
		                                             IntPtr hFileMaskList);
		#endregion
		
		static IntPtr harc;
		
		public static Int32 InitArchive(string pszArchiveName,
		                                           dSqxCallback pfnCallback,
		                                           IntPtr pParam)
		{
			return SqxInitArchive(pszArchiveName, pfnCallback, pParam, ref harc);
		}
				
		public static void DoneArchive()
		{
			SqxDoneArchive(harc);
			harc = IntPtr.Zero;
		}						
				
		public static IntPtr InitFileList()
		{
			return SqxInitFileList(harc);
		}
				
		public static void DoneFileList(IntPtr hFileMaskList)
		{
			SqxDoneFileList(harc, hFileMaskList);
		}
				
		public  static IntPtr InitArcFileList()
		{
			return SqxInitArcFileList(harc);
		}
				
		public static void DoneArcFileList(IntPtr pArcFileList)
		{
			SqxDoneArcFileList(harc, pArcFileList);
		}
				
		public static Int32 ListFiles(IntPtr hFileMaskList, ref SQX_ARCLIST pArcFileList,ref SQX_ARCINFO pArchiveInfo)
		{
			return SqxListFiles(harc, hFileMaskList, ref pArcFileList,ref pArchiveInfo);
		}
		
		public static void AppendFileList(IntPtr hFileMaskList, string pszFileName)
		{
			SqxAppendFileList(harc, hFileMaskList, pszFileName);
		}
							
		public static Int32 TestArchive(dSqxCallback pfnCallback, IntPtr pParam)
		{
			return SqxTestArchive(harc, pfnCallback, pParam);
		}
				
		public static Int32 ExtractFiles(dSqxCallback pfnCallback, IntPtr pParam, 
		                                            IntPtr hFileMaskList, 	
		                                            ref SQX_EXTRACTOPTIONS pExtractOptions)
		{
			return SqxExtractFiles(harc, pfnCallback, pParam, hFileMaskList, ref pExtractOptions);
		}
				
		public static Int32 CompressFiles(dSqxCallback pfnCallback, IntPtr pParam,
		                                             IntPtr hFileMaskList,
		                                             ref SQX_COMPRESSOPTIONS pCompressOptions)
		{
			return SqxCompressFiles(harc, pfnCallback, pParam, hFileMaskList, ref pCompressOptions);
		}
				
		public static Int32 DeleteFiles(dSqxCallback pfnCallback, IntPtr pParam,
		                                             IntPtr hFileMaskList)
		{
			return SqxDeleteFiles(harc, pfnCallback, pParam, hFileMaskList);
		}
		
	}
}

/*
 * Created by SharpDevelop.
 * User: LYCJ
 * Date: 27/1/2007
 * Time: 16:31
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Threading;

namespace Cake3.SqxArc
{
	class MainClass
	{		
		
		static string archiveName = "";
		static dSqxCallback SqxCallBackProc;
		
		public static void Main(string[] args)
		{
			Console.WriteLine("Hello World! This is Sqx dotNet implementation Test 0.2 by LYCJ!");			
			Console.WriteLine("Release under BSD License. ");
			Console.WriteLine("If you found any bug, please submit to (author2004 at quickzip dot org)");			
			Console.WriteLine("---------------------------------------");
			
			SqxCallBackProc = new dSqxCallback(SqxCallback);		
			
			if (args.Length < 2) 
			{
				Console.WriteLine("SqxArc.exe list <archivename>");
				Console.WriteLine("SqxArc.exe test <archivename>");
				Console.WriteLine("SqxArc.exe extract <archivename> <extractto>");
				Console.WriteLine("SqxArc.exe add <archivename> <file2add>");
				Console.WriteLine("SqxArc.exe delete <archivename> <file2delete>");
				Console.WriteLine("---------------------------------------");
			}
			else
			{
				Console.Write("Param : ");
				foreach (string item in args)
					Console.Write(item + " ");				
				Console.WriteLine();
				
				archiveName = args[1];
				if (Header.InitArchive(archiveName, SqxCallBackProc, IntPtr.Zero) == (Int32)Header.ErrorCodes.SQX_ERR_SUCCESS)
				{
					switch (args[0])
					{
						case "list":
							List();
							break;
						case "test":
							Test();
							break;
						case "extract":
							Extract("*.*", args[2]);
							break;
						case "add":
							Add(args[2]);
							break;
						case "delete":
							Delete(args[2]);
							break;
					}
					
					Header.DoneArchive();
				}
			}
			Console.WriteLine();
			Console.WriteLine("Press <enter> to continue.");
			Console.ReadLine();
		}
		
		public static bool CheckError(Int32 errorCode)
		{
			return errorCode == (Int32)Header.ErrorCodes.SQX_ERR_SUCCESS;
		}
		
		public static void Test()
		{
			Console.WriteLine(CheckError(Header.TestArchive(SqxCallBackProc, Marshal.StringToHGlobalAuto("Test"))));
		}
		
		public static void Extract(string mask, string path)
		{
			SQX_EXTRACTOPTIONS extractOptions = new SQX_EXTRACTOPTIONS();
			
			extractOptions.szOutputPath 	= path;
			extractOptions.szPassword 		= "";
			extractOptions.fKeepBrokenFiles = true;
			extractOptions.fCreateFolders   = true;
			
			extractOptions.cbSize = Marshal.SizeOf(typeof(SQX_EXTRACTOPTIONS));
			
			IntPtr hFileMaskList = Header.InitFileList();
			Header.AppendFileList(hFileMaskList, mask);							
			Header.ExtractFiles(SqxCallBackProc, Marshal.StringToHGlobalAuto("Extract"),
				                          hFileMaskList, ref extractOptions);
				
			Header.DoneFileList(hFileMaskList);							
		}
				
		public static void Add(string item)
		{
			SQX_COMPRESSOPTIONS compressOptions = new SQX_COMPRESSOPTIONS();
								
			compressOptions.dwFileFormat = (int)Header.FileFormat.SQX_FILEFORMAT_20;
			compressOptions.compOptions.dwCompRate = (int)Header.CompressRate.SQX_COMPRATE_ULTRA;
			compressOptions.compOptions.dwDictionarySize = (int)Header.DictionarySize.SQX_DICTIONARY_2M;
			compressOptions.compOptions.fSolidFlag = false;
			
			compressOptions.compOptions.dwExeCompression = (int)Header.SpecialCompressor.SQX_SPECIALCOMP_AUTOMATIC;
			compressOptions.compOptions.dwRgbCompression = (int)Header.SpecialCompressor.SQX_SPECIALCOMP_AUTOMATIC;;
			compressOptions.compOptions.dwTextCompression = (int)Header.SpecialCompressor.SQX_SPECIALCOMP_AUTOMATIC;;
			compressOptions.compOptions.dwAudioCompression = (int)Header.SpecialCompressor.SQX_SPECIALCOMP_AUTOMATIC;;
			compressOptions.compOptions.dwMultimediaCompression = (int)Header.SpecialCompressor.SQX_SPECIALCOMP_AUTOMATIC;;
			compressOptions.fRetainFolderStructure = true;
			compressOptions.cbSize = Marshal.SizeOf(typeof(SQX_COMPRESSOPTIONS));
			
			IntPtr hFileMaskList = Header.InitFileList();

			string filename = "";
			string baseFolder = "";
			
			filename = getFullPath(item, ref baseFolder);
			
			Header.AppendFileList(hFileMaskList, filename);
			compressOptions.szInputPath = baseFolder;
									
			Header.CompressFiles(SqxCallBackProc, 
			                     Marshal.StringToHGlobalAuto("Add"),
				                           hFileMaskList, ref compressOptions);
				
			Header.DoneFileList(hFileMaskList);			
		}
		
		public static void Delete(string item)
		{
			IntPtr hFileMaskList = Header.InitFileList();			
			
			Header.AppendFileList(hFileMaskList, item);
			
			Header.DeleteFiles(SqxCallBackProc,
			            Marshal.StringToHGlobalAuto("Delete"),
			            hFileMaskList);
			Header.DoneFileList(hFileMaskList);
		}
		
		public static void List()
		{
			IntPtr hFileMaskList = Header.InitFileList();			
			IntPtr pArcFileList = Header.InitArcFileList();
			try
			{								
				SQX_ARCLIST ArcFileList = (SQX_ARCLIST)Marshal.PtrToStructure(pArcFileList, typeof(SQX_ARCLIST));
				
				SQX_ARCINFO ArcInfo = new SQX_ARCINFO();
				ArcInfo.cbSize = (UInt32)System.Runtime.InteropServices.Marshal.SizeOf(typeof(SQX_ARCINFO));
				
				Header.AppendFileList(hFileMaskList, "*.*");
				if (CheckError(Header.ListFiles(hFileMaskList, ref ArcFileList, ref ArcInfo)))
				{
					
					SQX_ARCLISTNODE aNode = (SQX_ARCLISTNODE)Marshal.PtrToStructure(ArcFileList.pHead, typeof(SQX_ARCLISTNODE));
					SQX_ARCNODE fileNode = (SQX_ARCNODE)Marshal.PtrToStructure(aNode.pArcNode, typeof(SQX_ARCNODE));			
					Console.WriteLine(fileNode.pszFileName);
					
					for (Int32 i = 1; i < ArcFileList.dwItemCount; i++)
						if (aNode.pNext != IntPtr.Zero)
					{
						aNode = (SQX_ARCLISTNODE)Marshal.PtrToStructure(aNode.pNext, typeof(SQX_ARCLISTNODE));
						fileNode = (SQX_ARCNODE)Marshal.PtrToStructure(aNode.pArcNode, typeof(SQX_ARCNODE));	
						Console.WriteLine(fileNode.pszFileName);
					}					
				}
			}
			finally
			{				
				try
				{
					if (pArcFileList != IntPtr.Zero)
						Header.DoneArcFileList(pArcFileList);
					if (hFileMaskList != IntPtr.Zero)
						Header.DoneFileList(hFileMaskList);
				}	
				catch
				{
					
				}
			}										
						
		}
		
		
		public static int SqxCallback(IntPtr pParam, ref Cake3.SqxArc.SQX_CALLBACKINFO CallbackInfo)
		{
			if (CallbackInfo.pszSourceFileName != null)
			{							
				Console.WriteLine("Processing..."+CallbackInfo.pszSourceFileName);				
			}									
						
			return 1;
		}
		
		
		public static string RemoveFileDrive(string input)
		{
			if (input.Length >= 3) //"C:\"
			{
				if (input.Substring(1,2) == @":\")
				{
					return input.Substring(3);
				}
			}			
			return "";				
		}
		
		public static char GetFileDrive(string input)
		{
			if (input.Length >= 3) //"C:\"
			{
				if (input.Substring(1,2) == @":\")
				{
					return input[0];
				}
			}			
			return ' ';				
		}		
		
		public static string getFullPath(string filePath, ref string basePath)
		{
			basePath = GetFileDrive(filePath) + @":\";
			return RemoveFileDrive(filePath);
		}		
		
	}
}

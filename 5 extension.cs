using System;
using System.Collections.Generic;

namespace hw_5 {
	public static class hw_5 {
		public static Int32[] StringToInt32Array (this String str)
		{
			string[] stringArray = str.Split (',');
			Int32[] Array = new Int32[stringArray.Length];

			//for (Int32 i=0; i<stringArray.Length; i++) Array[i] = Int32.Parse(stringArray[i]);
			for (Int32 i=0; i<stringArray.Length; i++) {
				Int32 temp;
				Int32.TryParse (stringArray[i], out temp);
				Array[i]=temp;

			}
			return Array;
		}

		static void Main (string[] args) {
			try {
                string sourse = "17,8,6,9,8,5,4";
                foreach (int elem in sourse.StringToInt32Array())
                    Console.Write(elem + " ");
                Console.WriteLine();
            }
            catch (Exception ex) {
                Console.WriteLine(ex.Message);
            }
		}
	}
}

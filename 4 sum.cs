using System;
namespace hw_4 {
	class MainClass {
		static Int32 sum (params int[] array) {
			Int32 sum=0;
			foreach (int elem in array) sum+=elem;
			return sum;
        }

		public static void Main (string[] args) {
			Console.WriteLine (sum (1,2,3,4,5,6,7,8,9));
			Console.WriteLine (sum(1,9));
		}
	}
}


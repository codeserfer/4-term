using System;

namespace hw1 {
	class Program {
		static void Main(string[] args) {
			Int32[] array=new Int32[10000000];
			for (int i=0; i<10000000; i++) {
				array[i]=i;
			}

			Int32 sum=0; 
			var dt=DateTime.Now;
			for (int i=0; i<10000000; i++) {
				sum+=i;
			}     
			var time=DateTime.Now-dt;
			Console.WriteLine ("Цикл for: {0}", time);

			sum=0;
			dt=DateTime.Now;
			foreach (int item in array) {
				sum+=item;
			}     
			time=DateTime.Now-dt;
			Console.WriteLine("Цикл foreach: {0}", time);
		}
	}
}


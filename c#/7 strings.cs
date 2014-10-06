using System;
using System.Text;
using System.Diagnostics;

namespace hw_7 {
	class MainClass {
		public static void Main (string[] args) {
			String s="";
			var timer = Stopwatch.StartNew();
			for (int i=0;i<10000;i++) s+="Same";
			String s_int = String.Intern(s);
			timer.Stop();
			Console.WriteLine("Конкатенация с интернированием заняла {0} мс", timer.ElapsedMilliseconds);
			timer.Reset ();

			s="";
			timer.Start ();
			for (int i=0;i<10000;i++) s+="Same";
			timer.Stop();
			Console.WriteLine("Конкатенация без интернирования заняла {0} мс", timer.ElapsedMilliseconds);
			timer.Reset ();

			for (int k=1; k<21; k++) {
				s="";
				string adding_str="";
				for (int i=0; i<k; i++) adding_str+="a";
				timer.Start ();
				for (int i=0; i<10000; i++) s+=adding_str;
				timer.Stop ();
				Console.WriteLine ("Конкатенация строк String с длиной подстроки {1} заняла {0} мс", timer.ElapsedMilliseconds, k);
			}
			timer.Reset ();

			for (int k=1; k<21; k++) {
				var sb=new StringBuilder ();
				string adding_str="";
				for (int i=0; i<k; i++) adding_str+="a";
				timer.Start ();
				for (int i=0; i<10000; i++) sb.Append (adding_str);//s+=adding_str;
				timer.Stop ();
				Console.WriteLine ("Конкатенация строк StringBuilder с длиной подстроки {1} заняла {0} мс", timer.ElapsedMilliseconds, k);
			}
		}
	}
}


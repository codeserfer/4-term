//Домашнее задание №6
using System;

namespace man {
	class Man {
		protected string _name;
		protected int _age;
		public string name{ get; set; }
		public virtual int age{ get; set;}
		public override string ToString() {
			return "Человек, " + name + ", " + age;
		}
	}
	class Teenager : Man {
		public override int age {
			get {
				return _age;
			}
			set {
				if (value < 13 || value > 19) throw new Exception();
				_age = value;
			}
		}
		public override string ToString() {
			return "Подросток, " + name + ", " + age;
		}
	}
	class Worker : Man {
		public override int age {
			get {
				return _age;
			}
			set {
				if (value < 16 || value > 70) throw new Exception();
				_age = value;
			}
		}
		public override string ToString() {
			return "Работник, " + name + ", " + age;
		}
	}
	class List {
		Man[] mass;
		public List (params Man[] values) {
			mass = new Man[values.Length];
			for (int i = 0; i < values.Length; i++) mass[i] = values[i];
		}
		public Man this[int i] {
			set {
				mass[i] = value;
			}
			get {
				return mass[i];
			}
		}
	}
	class Program {
		static void Main(string[] args) {
			Man m = new Man(); 
			m.name = "Михаил"; 
			m.age = 28;
			Teenager t = new Teenager(); 
			t.name = "Олег"; 
			t.age = 13;
			Worker w = new Worker(); 
			w.name = "Борис"; 
			w.age = 69;
			List l = new List(m, t, w);
			Console.WriteLine(l[0]);
			Console.WriteLine(l[1]);
			Console.WriteLine(l[2]);
		}
	}
}

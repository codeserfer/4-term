using System;
using System.IO;
using System.Text;


namespace lab {

	public static class constants {
		public const string filename="db.csv";
		public const string changing="changing.csv";
		public const string error_input="Ошибка ввода, повторите ввод";
	};

	public class change {
		public decimal profit {get; set; }
		public decimal new_cost {get; set; }
		public float percent { get; set; }
	}

	public class GUI {
		private static void input_data (out string name, out DateTime date, out Int32 count, out Decimal cost) {
			Console.WriteLine ("Добавление нового элемента\n");
			Console.WriteLine ("Введите имя фирмы ");
			while (true) {
				name = Console.ReadLine ();
				if (name != "") {
					break;
				}
				else {
					Console.WriteLine (constants.error_input);
				}
			}
			Console.WriteLine ("Введите дату покупки в формате дд.мм.гггг ");
			while (true) {
				string temp=Console.ReadLine ();
				if (DateTime.TryParse (temp, out date)) {
					break;
				}
				else {
					Console.WriteLine (constants.error_input);
				}
			}
			Console.WriteLine ("Введите количество акций ");
			while (true) {
				string temp=Console.ReadLine ();
				if (Int32.TryParse (temp, out count)) {
					break;
				}
				else {
					Console.WriteLine (constants.error_input);
				}
			}

			Int32 int_temp=0;
			Console.WriteLine ("Введите стоимость акций ");
			while (true) {
				string temp=Console.ReadLine ();
				if (Int32.TryParse (temp, out int_temp)) {
					cost=int_temp;
					break;
				}
				else {
					Console.WriteLine (constants.error_input);
				}
			}
			return;
		}


		public static void show_menu () {
			var text =
				"1. Добавить элемент\n" +
				"2. Вывести все элементы\n" +
				"3. Вывести элемент по id\n" +
				"4. Изменить элемент\n" +
				"5. Удалить элемент\n" +
				"6. Вычислить цену акций для указанной фирмы\n" +
				"7. Выход";

			bool f=true;
			while (f) {
				Console.WriteLine (text);
				Int32 input;
				if (!Int32.TryParse (Console.ReadLine (), out input)) input=100;
				switch (input) {
					case 1:
					//Добавление элемента
						string name;
						DateTime date;
						Int32 count;
						Decimal cost;
						input_data (out name, out date, out count, out cost);
						BL.add (name, date, count, cost);
						break;
					case 2:
					//Вывод всех элементов
						Console.WriteLine (BL.show_all ());
						break;
					case 3:
					//Вывод элемента по id
						Console.WriteLine (BL.show_all (true));
						Console.WriteLine ("Введите id выводимого элемента. Для отмены введите 0 ");
						int int_temp=0;
						Entity current;
						while (true) {
							string temp=Console.ReadLine ();
							if (Int32.TryParse (temp, out int_temp)) {
								current=BL.show_current (int_temp);
								if (int_temp==0) break;
								if (current!=null) break;
								else Console.WriteLine (constants.error_input);
							}
							else {
								Console.WriteLine (constants.error_input);
							}
						}

						if (current==null) Console.WriteLine (constants.error_input);
						else {
							string s=
								"Наименование фирмы: "+current.name + "\n" +
								"Дата покупки: "+current.date.ToString("d") + "\n" +
								"Количество: " + current.count + "\n" +
								"Стоимость: " + current.cost;
							Console.WriteLine (s);
						}
						break;
					case 4:
					//Изменение элемента
						Console.WriteLine (BL.show_all (true));
						Console.WriteLine ("Введите id изменяемого элемента. Для отмены введите 0 ");
						Int32 id=0;
						while (true) {
							string temp=Console.ReadLine ();
							if (Int32.TryParse (temp, out id)) {
								current=BL.show_current (id);
								if (id==0) break;
								if (current!=null) break;
								break;
							}
							else {
								Console.WriteLine (constants.error_input);
							}
						}
						if (id!=0) {
							Console.WriteLine ("Старые значения:");

							string s=
								"Наименование фирмы: "+current.name + "\n" +
								"Дата покупки: "+current.date.ToString("d") + "\n" +
								"Количество: " + current.count + "\n" +
								"Стоимость: " + current.cost;
							Console.WriteLine (s);
							input_data (out name, out date, out count, out cost);
							BL.edit (id, name, date, count, cost);
						}
						break;
					case 5:
					//Удаление элемента
						Console.WriteLine (BL.show_all (true));
						Console.WriteLine ("Введите id удаляемого элемента ");
						while (true) {
							string temp=Console.ReadLine ();
							if (Int32.TryParse (temp, out id)) {
								break;
							}
							else {
								Console.WriteLine (constants.error_input);
							}
						}
						BL.delete (id);
						break;

					case 6:
						//Вычисление цен акций
						Console.WriteLine (BL.show_all (true));
						Console.WriteLine ("Введите id фирмы\n" +
											"Можно ввести любой id интересующей фирмы");
						while (true) {
							string temp=Console.ReadLine ();
							if (Int32.TryParse (temp, out id)) {
								break;
							}
							else {
								Console.WriteLine (constants.error_input);
							}
						}

						change cur=BL.view_changing (id);

						Console.WriteLine ("Текущая стоимость акций данной компании: {0:0.000}", cur.new_cost);
						if (cur.profit>=0) Console.WriteLine ("Прибыль: {0:0.000}", cur.profit);
						else Console.WriteLine ("Убыль: {0:0.000}", cur.profit);
						if (cur.percent>=0) Console.WriteLine ("Процент роста: {0}%", cur.percent);
						else Console.WriteLine ("Процент спада: {0:0.00}%", cur.percent);
						break;
					case 0:
					case 7:
					//Выход
						f=false;
						break;
					default:
						Console.WriteLine ("Неверный ввод!");
						break;
				}
			}
		}
	};

	public class BL {
		public static void add (string name, DateTime date, Int32 count, Decimal cost) {
			Entity entity=new Entity (name, date, count, cost);
			DL.add_to_list (entity);
		}
		public static void edit (Int32 id, string name, DateTime date, Int32 count, Decimal cost) {
			DL temp=new DL ();
			temp[id].cost=cost;
			temp[id].count=count;
			temp[id].date=date;
			temp[id].name=name;
		}

		public static string show_all (bool id=false) {
			//return DL.export_to_string_all ("\t", "\n", id);
			//????
			string s = "";
			DL temp = new DL ();
			for (int i=1; temp[i]!=null; i++) {
				if (id) s+=temp[i].id+"\t";
				s += temp [i].name + "\t" +
					temp [i].date.ToString("d") + "\t" +
					temp [i].count + "\t" +
					temp [i].cost + "\n";
			}
			return s;
		}

		public static Entity show_current (Int32 id) {
			DL temp=new DL ();
			return (temp [id]);
		}

		public static void delete (Int32 id) {
			DL temp=new DL ();
			DL.delete (temp[id]);
		}

		public static change view_changing (Int32 id) {
			Decimal profit=0;
			DL temp = new DL ();
			string name_company = temp [id].name; //here we have a name of needed company

			//searching
			Decimal old_cost=0;
			Entity i = Base.first_e;
			while (i!=null) {
				//for each record in entity's list we should calculate profit
				if (i.name==name_company) {
					//ok, this's needed company
					//let's calculate profit
					changing j=Base.first_c;
					Decimal q=i.count*i.cost;
					while (j!=null) {
						if (j.name==name_company && j.date.CompareTo (i.date)>0) {
							q=q*(1+(Decimal)j.change/100);
						}
						j=j.next;
					}
					old_cost+=i.cost*i.count;
					profit+=q;

				}
				i=i.next;
			}
			change ret=new change ();
			ret.new_cost=profit;
			ret.profit=profit-old_cost;
			ret.percent=((float)(profit/old_cost)-1)*100;
			return ret;
		}
	};

	//for changing
	public class changing {
		public changing next;
		public DateTime date { get; set; }
		public string name { get; set; }
		public Int32 change {get; set; }
		public changing (DateTime date, string name, Int32 change) {
			this.date=date;
			this.name=name;
			this.change=change;
		}

		public changing (changing copy) {
			this.change=copy.change;
			this.date=copy.date;
			this.name=copy.name;
		}
	};
	//for changing


	//Entity
	public class Entity {
		public Entity next;
			
		public string name {get; set;}
		public DateTime date { get; set; }
		public Int32 count { get; set; }
		public Decimal cost {get; set;}
		public Int32 id { get; set; }
		public Entity (string name, DateTime date, Int32 count, Decimal cost, Int32 id) {
			this.name=name;
			this.date=date;
			this.count=count;
			this.cost=cost;
			this.id=id;
		}
		public Entity (string name, DateTime date, Int32 count, Decimal cost) {
			this.name=name;
			this.date=date;
			this.count=count;
			this.cost=cost;
			if (Base.last_e!=null) this.id=Base.last_e.id+1;
			else this.id=1;
		}
		public Entity (Entity copy) {
			this.cost=copy.cost;
			this.count=copy.count;
			this.date=copy.date;
			this.name=copy.name;
			this.id=copy.id;
		}
	};
	//Entity

	public class Base {
		public static Entity first_e=null;
		public static Entity last_e=null;
		public static changing first_c=null;
		public static changing last_c=null;
	};

	public class DL {
		public Entity this[int index]{
			get {
				Entity i=Base.first_e;
				int j=1;
				while (i!=null) {
					if (index==j) break;
					j++;
					i=i.next;
				}
				if (i==null) return null;
				if (i.id==index) return i;
				else return null;
			}
			set {
				Entity i=Base.first_e;
				int j=1;
				while (i!=null) {
					if (index==j) break;
					j++;
					i=i.next;
				}
				i.cost=value.cost;
				i.count=value.count;
				i.date=value.date;
				i.name=value.name;
			}
		}

		private static void reindex () {
			int j=1;
			for (Entity i=Base.first_e; i!=null; i=i.next, j++) {
				i.id=j;
			}
		}

		public static void delete (Entity current) {
			if (Base.first_e == current) {
				Base.first_e = current.next;
				reindex ();
				return;
			}
			Entity i = Base.first_e;

			while (i.next!=current) {
				i=i.next;
			}
			//here i is previous object
			if (Base.last_e == current) {
				Base.last_e=i;
			}
			i.next=current.next;
		}

		public static void add_to_list (Entity entity) {
			if (Base.first_e == null) {
				Base.first_e=Base.last_e= new Entity (entity);
				Base.first_e.next = null;
				return;
			}
			Entity new_stock=new Entity (entity);
			new_stock.next=null;
			Base.last_e.next=new_stock;
			Base.last_e=new_stock;
		}

		public static void add_to_list_changing (changing entity) {
			if (Base.first_c == null) {
				Base.first_c=Base.last_c= new changing (entity);
				Base.first_c.next = null;
				return;
			}
			changing new_change=new changing (entity);
			new_change.next=null;
			Base.last_c.next=new_change;
			Base.last_c=new_change;
		}

		public static string export_to_string_all (string separator1, string separator2, bool id=false) {
			Entity i = Base.first_e;
			StringBuilder sb = new StringBuilder();
			int j=1;
			while (i!=null) {
				if (id) sb.Append (export_to_string_one(i, separator1, j));
				else sb.Append (export_to_string_one(i, separator1));
				sb.Append (separator2);
				i=i.next;
				j++;
			}
			return sb.ToString();
		}

		public static StringBuilder export_to_string_one (Entity entity, string separator, int id=0) {
			StringBuilder sb = new System.Text.StringBuilder ();
			if (id != 0) {
				sb.Append (entity.id.ToString ());
				sb.Append (separator);
			}
			sb.Append (entity.name.ToString());
			sb.Append (separator);
			sb.Append (entity.date.ToString("d"));
			sb.Append (separator);
			sb.Append (entity.count.ToString());
			sb.Append (separator);
			sb.Append (entity.cost.ToString());
			return sb;
		}

		public static bool serialization () {
			if (!File.Exists (constants.filename)) return false;
			using (StreamReader sr = File.OpenText(constants.filename)) {
				string s = "";
				int i = 1;
				while ((s = sr.ReadLine()) != null) {
					//Обработка очередной строки файла с базой
					string [] temp = s.Split (new string [] {","}, StringSplitOptions.RemoveEmptyEntries);
					string [] temp2 = temp [1].Split (new string [] {"."}, StringSplitOptions.RemoveEmptyEntries);
					DateTime date = new DateTime (int.Parse (temp2 [2]), int.Parse (temp2 [1]), int.Parse (temp2 [0]));
					Entity entity = new Entity (temp [0].ToString (), 
					                        date, 
					                        int.Parse (temp [2]), 
					                        Decimal.Parse (temp [3]),
					                        i);

					add_to_list (entity);
					i++;
				}
			}
			return true;
		}

		//
		public static void read_changing () {
			using (StreamReader sr = File.OpenText(constants.changing)) {
            	string s = "";
            	while ((s = sr.ReadLine()) != null) {
					string [] temp = s.Split (new string [] {","}, StringSplitOptions.RemoveEmptyEntries);
					string [] temp2 = temp[0].Split (new string [] {"."}, StringSplitOptions.RemoveEmptyEntries);
					DateTime date = new DateTime (int.Parse (temp2 [2]), int.Parse (temp2 [1]), int.Parse (temp2 [0]));
					changing entity=new changing (date, 
					                        temp[1], 
					                        int.Parse (temp[2]));
					add_to_list_changing (entity);
            	}
        	}
		}
		//

		public static void deserialization () {
			using (StreamWriter outfile = new StreamWriter(constants.filename)) {
            	outfile.Write(export_to_string_all(", ", "\n"));
        	}
		}
	};

	class MainClass {
		public static void Main (string[] args) {
			if (!DL.serialization ()) {
				Console.WriteLine ("Входной файл не найден!");
				return;
			}
			DL.read_changing ();
			GUI.show_menu ();
			DL.deserialization();
		}
	}
}

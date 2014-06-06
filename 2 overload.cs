using System;

namespace hw2 {
	class my {
		Int32 number;
		String str;
		Boolean f;

		static public my operator+(my obj1, my obj2) {
			my q=new my();

			q.number=obj1.number+obj2.number;
			q.str=obj1.str+obj2.str;
			q.f=obj1.f || obj2.f;

			return q;
		}

		public override string ToString() {
			return String.Format("{0} {1} {2}", number, str, f);
		}
	}
}


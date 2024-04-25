package study.j0424;

public class Test01 {
	public static void main(String[] args) {
		int i=0, tot=0;
		
		while(i<100) {
			i++;
			tot += i;
		}
		System.out.println("1~100까지의 합은? "+tot);
	}
}

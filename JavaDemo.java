public class TruncateNumber {
    public static void main(String[] args) {
        float f=123.456f;
        Float f1=new Float(f);
        System.out.println(f1);
        int i= (int) f;
        System.out.println("my number="+i);

        System.out.println("Float= "+f1.intValue());
    }
}

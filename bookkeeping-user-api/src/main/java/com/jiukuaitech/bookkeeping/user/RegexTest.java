package com.jiukuaitech.bookkeeping.user;

public class RegexTest implements Runnable {


    private static int i;

    public synchronized static void change() {
        for (int j = 0; j < 5000000; j++) {
            i++;
        }
    }

    @Override
    public void run() {
        synchronized ("123".intern()) {
            for (int j = 0; j < 5000000; j++) {
                i++;
            }
        }
    }

    public static void main(String[] args) throws Exception {
        new Thread(new RegexTest()).start();
        new Thread(new RegexTest()).start();
        Thread.sleep(3000);
        System.out.println(i);
    }
}

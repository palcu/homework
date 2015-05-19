package prodconsum;

import java.util.Random;

class Prod extends Thread {
    Depozit d;
    String name;
    Prod(Depozit d, String name) { this.d = d; this.name = name; }
    
    Random random = new Random();
    
    @Override
    public void run() {
        while(true) {
            for(int i=0; i<random.nextInt(5); i++) {
                this.d.adauga(this.name);
            }
        }
    }
}

class Consum extends Thread {
    Depozit d;
    String name;
    Consum(Depozit d, String name) { this.d = d; this.name = name; }
    
    Random random = new Random();
    
    @Override
    public void run() {
        while(true) {
            for(int i=2; i<random.nextInt(7); i++) {
                this.d.scoate(this.name);
            }
        }
    }
}

class Depozit {
    int capacitate, stoc;
    Depozit() {
        this.capacitate = 5;
        this.stoc = 0;
    }
    
    synchronized void adauga(String name) {
        if (this.stoc == this.capacitate) {
            System.out.println("Stocul e egal cu capacitatea");
            try { wait(); }
            catch(Exception e) {}
        }
        this.stoc++;
        System.out.println(name + " a adaugat");
        System.out.println(this.stoc);
        notify();
        try { Thread.sleep(1000); }
        catch(Exception e) { }
    }
    
    synchronized void scoate(String name) {
        if (this.stoc == 0) {
            System.out.println("Stocul e zero");
            try { wait(); }
            catch(Exception e) {}
        }
        this.stoc--;
        System.out.println(name + " a scos");
        System.out.println(this.stoc);
        notify();
        try { Thread.sleep(1000); }
        catch(Exception e) { }
    }
}

public class ProdConsum {
    public static void main(String[] args) {
        Depozit depozit = new Depozit();
        for (int i=0; i<10; i++) {
            String prod_name = "prod" + Integer.toString(i);
            String consum_name = "consum" + Integer.toString(i);
            Prod prod = new Prod(depozit, prod_name);
            Consum consum = new Consum(depozit, consum_name);
            prod.start(); consum.start();
        }
    }   
}


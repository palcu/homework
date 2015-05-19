package primenumbers;

import java.io.IOException;
import static java.lang.Math.sqrt;
import java.nio.ByteBuffer;
import java.nio.channels.Pipe;
import java.util.logging.Level;
import java.util.logging.Logger;

class Calculator extends Thread {
    Pipe.SinkChannel sink;
    int start, end;
    Calculator(Pipe pipe, int start, int end) { 
        this.sink = pipe.sink(); 
        this.start = start; 
        this.end = end;
    }
    
    @Override
    public void run() {    
        for(int i=this.start; i<=this.end; i++) {
            if(isPrime(i)) {
                System.out.println(i);
                this.writeSomething("1");
            }
        }
        this.writeSomething("2");
    }

    boolean isPrime(int x) {
        if (x == 0) return false;
        if (x == 1) return false;
        if (x == 2) return true;
        if (x%2 == 0) return false;
        int rad = (int) sqrt(x);
        for (int i=3; i<=rad; i+=2) {
            if (x%i == 0) {
                return false;
            }
        }
        return true;
    }
    
    void writeSomething(String s) {
        ByteBuffer buf = ByteBuffer.allocate(48);
        buf.clear();
        buf.put(s.getBytes());

        buf.flip();

        while(buf.hasRemaining()) {
            try {
                this.sink.write(buf);
            } catch (IOException ex) {
                Logger.getLogger(Calculator.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}

public class PrimeNumbers {
    public static void main(String[] args) throws IOException {
        Pipe pipe = Pipe.open();
        
        int k = 10;
        int no_threads = 10;
        int steps = k/no_threads;
        
        for (int i=0; i<no_threads; i++) {
            Calculator c = new Calculator(pipe, i*steps, (i+1)*steps - 1);
            c.start();
        }
        
        int count_threads = 0;
        int count_primes = 0;
        while (count_threads != no_threads) {
            Pipe.SourceChannel sourceChannel = pipe.source();
            
            ByteBuffer buf = ByteBuffer.allocate(48);
            int bytesRead = sourceChannel.read(buf);
            String output = new String(buf.array(), "ASCII");
            
            for (int i=0; i<output.length(); i++) {
                if (output.charAt(i) == '2') {
                    count_threads++;
                    //System.out.println(count_threads);
                } else if (output.charAt(i) == '1') {
                    count_primes++;
                }
            }
        }
        System.out.println(count_primes);
    }
}


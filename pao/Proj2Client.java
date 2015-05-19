package proj2client;

import java.util.*;
import java.io.*;
import java.net.*;

public class Proj2Client {
  public static void main(String[] args) {
    int port = 8000;
    Scanner in = new Scanner(System.in);
    
    while (true) {
        System.out.print("Mesaj: ");
        String message;
        message = in.nextLine();
        
        try {
          Socket web = new Socket("localhost", 8000);
          OutputStream os = web.getOutputStream();
          DataOutputStream dos = new DataOutputStream(os);
          dos.writeUTF(message);
          web.close();
        }
        catch(IOException e) { }
        System.out.println("Message sent.");
    }
  }
}


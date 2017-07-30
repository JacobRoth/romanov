//package components;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.lang.Math;
void setup()
{
  size(195, 363); 
}
protected JButton b1;

 public class al extends JPanel implements ActionListener
 {
   JButton b1 = new JButton("476 Rubles");

   b1.addActionListener(this);
   
   add(b1);
 
   public void actionPerformed(ActionEvent e)
    {
     risk();
    }

 void risk()
 {
  int x = (int)(Math.random() * 10);
 if (x == 10)
 {
  text("Your driver drops you off safe and sound at your destination ", 100, 100);
  text("the \"you are gonna lose\" event is triggered ", 200, 200);
 }
 else
 {
   text("Your driver drops you off safe and sound at your destination ", 100, 100);
 }
 }
 }
 
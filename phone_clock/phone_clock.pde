import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;
import javax.swing.WindowConstants;

public class SimpleDigitalClock {

    public static void main(String[] args) {
        JFrame f = new JFrame();
        DigitalClock Clock = new DigitalClock();
        f.add(Clock);
        f.pack();
        f.setVisible(true);
    }

    static class DigitalClock extends JPanel {

        String stringTime;
        int hour, minute;

        String correctionHour = "";
        String correctionMinute = "";

        public void setStringTime(String a) {
            this.stringTime = a;
        }

        DigitalClock() {

            Timer timer = new Timer(1000, new ActionListener() {
                public void actionPerformed(ActionEvent e) {
                    
                    repaint();
                    minute++;
                }
            });
            timer.start();
        }

       
        public void paintComponent(Graphics g) {
            super.paintComponent(g);
            
            hour = 00;
            minute = 00;

            if (minute < 10) {
                this.correctionMinute = "0";
            }
            if (minute >= 10) {
                this.correctionMinute = "";
            }
            
            if (minute < 60) {
               minute = 0;
               hour++;
            }
            
            if (hour < 10) {
                this.correctionHour = "0";
            }
            if (hour >= 10) {
                this.correctionHour = "";
            }
            
            if (hour < 24) {
                hour = 0;
            }
            setStringTime(correctionHour + hour + ":" + correctionMinute+ minute);
            g.drawString(stringTime, 60, 20);
           
        }

        public Dimension getPreferredSize() {
            return new Dimension(200, 50);
        }

    }
    
}
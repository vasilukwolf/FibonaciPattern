//////////////////////////////////////////////////////////////////////////
//                       //                                             //
//   -~=Manoylov AC=~-   //           Fibonacci In Fibonacci            //
//                       //                                             //
//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Controls                                                             //
//    mouse                                                             //
//       leftClick: redraw with another image                           //
//       rightClick: on/off some of randomization                       //
//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Contacts:                                                            //
//    http://manoylov.tumblr.com/                                       //
//    https://codepen.io/Manoylov/                                      //
//    https://www.openprocessing.org/user/23616/                        //
//    https://www.facebook.com/epistolariy                              //
//////////////////////////////////////////////////////////////////////////
import processing.pdf.*;
import java.io.File;
import java.io.IOException;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

/* @pjs preload="img0.jpg, img1.jpg, img2.jpg, img3.jpg"; */

float px, py, r, degree;
float minWeight = 2;
float maxWeight = 8;
float currWeight;
float spacing = maxWeight+2;
float goldenRatio = ((sqrt(5) + 1 ) / 2);
int iter = 0, imgNum = (int)random(4);
boolean smallChaos = false;
PImage img;

void setup() {
  img = loadImage("img" + imgNum + ".jpg");
  size(500, 500);
  beginRecord(PDF, "filename.pdf");
  background(#F2F7F4);
  px = width/2; py = height/2;
}

void draw() {
  for(int i = 34; i > 0; --i){ // for more speed
    degree = (iter * goldenRatio) * 360;
    r = sqrt(iter++) * spacing;
    calcPointPos(width/2, height/2, r, (degree % 360));

    color pix = img.get((int)px, (int)py);
    currWeight = map(brightness(pix), 255, 0, minWeight, maxWeight);
    strokeWeight(currWeight);
    stroke(#523939); // stroke(pix);
    point(px, py);

    if (px-10 <= 0 || px+10 >= width || py-10 <= 0 || py+10 >= height ) { noLoop(); }
  }
}

void calcPointPos(float x, float y, float r, float graden) {
  px = x + cos(radians(graden))*(r/2);
  py = y + sin(radians(graden))*(r/2);
    if(smallChaos){
    px = x + random(maxWeight)+ cos(radians(graden))*(r/2);
    py = y + random(maxWeight)+ sin(radians(graden))*(r/2);
  }
}

void mousePressed(){
   if (mouseButton == RIGHT){
    smallChaos = !smallChaos;
    }
    else if (mouseButton == LEFT){
      ++imgNum;
      imgNum %= 4;
      img = loadImage("img" + imgNum + ".jpg");
      BufferedImage image = null;
      File f = null;
    try{
        f = new File("/home/eva/Develop/Java/FibonachiPattern/result/jony.jpg");
        ImageIO.write(image, "jpg", f);
        System.out.println("Writing complete.");
      }catch(IOException e){
        System.out.println("Error: "+e);
    }
    }
  frameCount = iter = 0;
  background(#F2F7F4);
  loop();  redraw();
}
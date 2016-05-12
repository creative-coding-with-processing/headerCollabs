// draw by stripes
// http://generateme.tumblr.com

PImage img;

// decay length each iteration
final static float decay_ratio = 0.98;
// initial length of stripe, used also a time
final static float initial_len = 40;
// final length
final static float final_len = 10;
// stripe alpha
final static float stripe_alpha = 190;

void setup() {
  img = loadImage("natalie.jpg");
  size(img.width, img.height);

  smooth(8);

  image(img,0,0);
}

float len = initial_len;
void draw() {
    float thr = map(len, initial_len, final_len,255,5);
  
    for (int iter=0; iter<400-4*len; iter++) {

      // initial stripe position
      float x1 = random(width);
      float x2 = x1 + (random(1)<0.5?-1:1) * random(5, 5+len);
      float y1 = random(height);
      float y2 = y1 + (random(1)<0.5?-1:1) * random(5, 5+len);

      // stripe color
      color initcolor = img.get((int)x1, (int)y1); 
      fill(initcolor, stripe_alpha);
      stroke(255-brightness(initcolor),20);

      // direction of the stripe (left/right)
      float dir = random(1)<0.5?-1:1;

      int i=0;
      color currentcolor = initcolor;
      beginShape(TRIANGLE_STRIP);
      
      // finish stripe when brightness is changed or length reached
      while(i<len+20 && colordist(initcolor,currentcolor)<thr) {
        
        vertex(x1, y1);
        vertex(x2, y2);
        
        // take current color info randomly modified
        float b1 = 2*TWO_PI*(0.005*randomGaussian()+brightness( img.get((int)x1, (int)y1) )/255.0);
        float b2 = 2*TWO_PI*(0.005*randomGaussian()+brightness( img.get((int)x2, (int)y2) )/255.0);

        // always move horizontally and turn slightly
        x1 += dir*random(5,5+len)+(b1*5)*cos(b1);
        x2 += dir*random(5,5+len)+(b2*5)*cos(b2);

        // turn
        y1 += (b1*2)*sin(b1);
        y2 += (b2*2)*sin(b2);
        
        i++;
        currentcolor = img.get((int)x1, (int)y1); 
      }
      endShape();
    }

    if(len>final_len) len *= decay_ratio;

    println(len);
  
}

float colordist(color c1, color c2) {
  return abs(brightness(c1)-brightness(c2));
}

void mouseClicked() {
  save("result"+hex((int)random(0xffff+1))+".jpg");
}


float a = 0.0;

color black = #F6CC4B;
color white = #333436;
color red = #272C63;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  background(black); 
  size(1280, 720, P3D); 

  fill(red);

  stroke(black);
  frameRate(60);

}


void draw() {
  background(black);

  strokeWeight(6);

  float x = sin(radians(a*1.11))*cos(radians(a*2.6))*width/4;
  float y = cos(radians(a)*2.2)*width/3;  
  float z = sin(radians(a)*4)*width/3; 
  float simplesin = map(sin(radians(a)), -1, 1, 0.8, 1); 
pushMatrix();
  translate(width/2, height/2);
  scale(simplesin);
  rotateY(radians(a));
  rotate(radians(a));

  points.add(new PVector(x, y, z));
  
  beginShape(QUAD_STRIP);
  for (PVector v : points) {
    vertex(v.x, v.y, v.z);
        vertex(v.x+20, v.y, v.z+20);


  }
  endShape();
 
   
  popMatrix();
  
  if (points.size() >800){
  points.remove(0);
  }
  

  a = a + 0.8;  

}

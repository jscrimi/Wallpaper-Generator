int[][] result;
float t, c;
float x, y;
int N = 360; //degrees to rotate about
float rotation = random(360);
float th, qq; //determines positioning of each segment along lines
float bottom = random(16, 64), top = random(16, 64);//height of lines in both directions, determines spacing between them too
int waviness = int(random(1, 180));//Waviness of lines
float diameter = random(4, 32);//Size of dots
int dotCount = int(random(16, 160 - diameter));//Number of dots in each wave
float topsin = random(0.6, 5);//Speed of top sin wave
float botsin = random(0.6, 5);//Speed of bottom sin wave
int offset = int(random(100, 102)); //helps determine how the colors of the dots and waves match up
color color1 = color(random(255), random(255), random(255), 255);
color color2 = color(random(255), random(255), random(255), 255);
color color3 = color(random(255), random(255), random(255), 255);
color[] cs = { color1, color2, color3 }; //array of colors to be iterated upon when drawing
color backgroundColor = color(random(255), random(255), random(255), 255);
color fillColor = color(random(255), random(255), random(255), 255);
float strokeSize = random(2, 5);
int numWaves = int(random(3, 15)); //number of waves generated, usually won't display all of them
int minWave = floor((numWaves / 2)) - numWaves;
int maxWave = floor(numWaves - (numWaves / 2));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {
  draw_();
}

void setup() {
  size(800, 720, P3D);
  smooth(8);
  result = new int[width*height][3];
  rectMode(LEFT);
  strokeWeight(strokeSize);
  fill(fillColor);
}

void waves(int q) {
  stroke(cs[(q+100)%3]); //rotate through the colors selected
  beginShape(); //This shape uses the lerp function to generate two sine-variant waves, one on top of the other.
  for (int i=0; i<N; i++) { //form the top line
    qq = i/float(N-1);
    th = TWO_PI*qq*waviness + TWO_PI;
    x = lerp(-width*topsin, width*topsin, qq);
    y = -top + bottom*sin(th) + bottom*.05*sin(3*th);
    vertex(x, y); //Put a vertex at the calculated point
  }
  for (int i=0; i<N; i++) { //form the bottom line
    qq = 1-i/float(N-1);
    th = TWO_PI*qq*waviness + TWO_PI;
    x = lerp(-width*botsin, width*botsin, qq);
    y = top + bottom*sin(th) + bottom*.05*sin(3*th);
    vertex(x, y);
  }
  endShape();
  
  stroke(cs[(q+offset)%3]); //rotate through the colors selected, but offset randomly
  for (int i=0; i<dotCount; i++) { //form the wave of dots
    th = TWO_PI*i*1.5/dotCount + QUARTER_PI*q;
    push();
    translate(map(i, 0, dotCount-1, -width*.7, width*.7), (top+bottom+diameter/2 + 16)*sin(TWO_PI*t + th), 5*cos(TWO_PI*t + th));
    ellipse(0, 0, diameter, diameter);
    pop();
  }
}

void draw_() {
  background(backgroundColor);
  push();
  translate(width/2, height/2);
  rotate(rotation);
  for (int i=minWave; i<maxWave; i++) {
    push();
    translate(0, 5.2*i*top);
    waves(i);
    pop();
  }
  pop();
}

int FPS = 30;
float time = 0;
float timeStep;

Sinusoid[] sineWaves;
SinusoidsAverage sineAvg;
SinusoidsProduct sineProd;

float x = 0;

void setup() {
  size(800, 400);
  frameRate(30);

  timeStep = 1.0/FPS;

  float freq = 4; // in seconds
  float amp = 200; // half the sketch height, in this case
  float phase = HALF_PI; // offset of the sinewave angle
  
  sineWaves = new Sinusoid[3];

  sineWaves[0] = new Sinusoid(freq, amp, phase);
  sineWaves[1] = new Sinusoid(freq*2, amp, phase);
  sineWaves[2] = new Sinusoid(freq*3, amp, phase);
  
  sineAvg = new SinusoidsAverage(sineWaves);
  sineProd = new SinusoidsProduct(sineWaves);
  
  ellipseMode(CENTER);
  
  background(0);
}

void draw() {

  //time += timeStep; // for rendering out frames to disk
  time = millis()/1000.0; // for real time rendering


  //background(0, 16);
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height);


  drawHUD();

  translate(0, height*.5);
  noStroke();
  fill(255);
  
  x += 1;
  if(x > width) x = 0;
  
  float y = sineAvg.calc(time);
  ellipse(x, y, 10, 10);
  
  y = sineProd.calc(time);
  ellipse(x, y, 10, 10);
}

void drawHUD() {
  push();
  float secs = millis()/1000;
  fill(255);
  noStroke();
  textSize(16);
  
  float x = 32;
  float y = 32;
  text(secs, x, y );
  pop();
}

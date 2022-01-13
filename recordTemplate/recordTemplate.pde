Boolean RECORD = false;

String SKETCH_NAME = "20220111";

int OUTPUT_WIDTH = 1920;
int OUTPUT_HEIGHT = 1080;

int TOTAL_FRAMES = 3600;

int FPS = 60;

PGraphics gfx;

float time = 0;
float timeStep;

float preview_width, preview_height;


void settings() {
  if(RECORD) size(400, 400, P3D);
  else fullScreen(P3D);
    
  smooth(8);
}

void setup() {
  gfx = createGraphics(OUTPUT_WIDTH, OUTPUT_HEIGHT, P3D);
  
  // setup preview scaling
  float s;
  if(OUTPUT_WIDTH >= OUTPUT_HEIGHT) {
    preview_width = width;
    
    s = float(width)/OUTPUT_WIDTH;
    preview_height = OUTPUT_HEIGHT*s;
    
  } else { 
    
    preview_height = height;
    
    s = float(height)/OUTPUT_HEIGHT;
    preview_width = OUTPUT_WIDTH*s;

  }
  
  timeStep = 1.0/FPS;

  
  background(0);
}

void draw() {
  background(0);
  
  // render gfx
  render();
  
  
  // display content
  push();
  
  imageMode(CENTER);
  translate(width*.5, height*.5);
  
  image(gfx, 0, 0, preview_width, preview_height);
  
  pop();
  
  
  //increment time
  time += timeStep;
  
  
  // record frames
  if(RECORD) {
    
    gfx.save(SKETCH_NAME+"_"+nfs(frameCount, 4)+".png");
    if(frameCount == TOTAL_FRAMES ) exit(); 
  }

}


void render() {
  gfx.beginDraw();
  
  gfx.background(255, 0, 255);
  
  gfx.endDraw();
}

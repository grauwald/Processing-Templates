Boolean RECORD = false;

String SKETCH_NAME = "recordTemplate_multiscreen";

int DISPLAY_WIDTH = 480;
int DISPLAY_HEIGHT = 1600;

int TOTAL_DISPLAYS = 3;

int DISPLAY_GAP = 576;


//int OUTPUT_WIDTH = 480;
//int OUTPUT_HEIGHT = 1600;

int TOTAL_FRAMES = 3600;

int totalWidth, totalHeight;

int FPS = 60;

PGraphics gfx;

float time = 0;
float timeStep;

float previewScalar;
float preview_width, preview_height;


void settings() {
  if (RECORD) size(400, 400, P3D);
  else fullScreen(P3D);

  smooth(8);
}

void setup() {

  totalWidth = (DISPLAY_WIDTH*TOTAL_DISPLAYS) + ( DISPLAY_GAP * (TOTAL_DISPLAYS-1) );
  totalHeight = DISPLAY_HEIGHT;

  gfx = createGraphics(totalWidth, totalHeight, P3D);

  // setup preview scaling
  
  if (totalWidth >= totalHeight) {
    preview_width = width;

    previewScalar = float(width)/totalWidth;
    preview_height = totalHeight*previewScalar;
  } else {

    preview_height = height;

    previewScalar = float(height)/totalHeight;
    preview_width = totalWidth*previewScalar;
  }

  timeStep = 1.0/FPS;

  background(0);
}

void draw() {
  background(0);

  // render gfx
  render();

  // display content
  displayGFX();
  
  renderGaps(); 


  //increment time
  time += timeStep;

  // record frames
  if (RECORD) {

    gfx.save(SKETCH_NAME+"_"+nfs(frameCount, 4)+".png");
    if (frameCount == TOTAL_FRAMES ) exit();
  }
}

void displayGFX() {
  push();

  imageMode(CENTER);
  translate(width*.5, height*.5);

  image(gfx, 0, 0, preview_width, preview_height);
  
  pop();
}

void renderGaps() {
  push();
  for(int i=1; i<TOTAL_DISPLAYS; i++) {
    float x = ((DISPLAY_WIDTH*i)+(DISPLAY_GAP*(i-1)))*previewScalar;
    float y = (height-preview_height)*.5;
    
    float w = DISPLAY_GAP*previewScalar;
    float h = DISPLAY_HEIGHT*previewScalar;
    
    fill(0);
    noStroke();
    
    rect(x, y, w, h);
  }
  
  pop();
}


void render() {
  gfx.beginDraw();

  gfx.background(255, 0, 255);

  gfx.endDraw();
}

Boolean RECORD = false;
Boolean RECORD_PREVIEW = false;

String OUTPUT_PATH = "output/";
String SKETCH_NAME = "recordTemplate_multiscreen";

int[] DISPLAY_WIDTHS = {480, 480, 480, 480, 480, 3040, 480, 480, 480, 480, 480};
int DISPLAY_HEIGHT = 1600;

int TOTAL_DISPLAYS = 11;


//   | | | | |  [   ]  | | | | |

int[] DISPLAY_GAPS = {0, 576, 576, 576, 576, 896, 896, 576, 576, 576, 576};


int TOTAL_FRAMES = 20;

int totalWidth, totalHeight;

int FPS = 60;

Display[] displays;

PGraphics gfx;

float time = 0;
float timeStep;

float previewScalar;
float preview_width, preview_height;

Content content;

HUD hud;

void settings() {
  if (RECORD && !RECORD_PREVIEW) size(400, 400, P3D);
  else fullScreen(P3D);

  smooth(8);
}

void setup() {
  
    // display properties
  displays = new Display[TOTAL_DISPLAYS];
  
  int x = 0;
  int y = 0;
  
  for(int d=0; d < TOTAL_DISPLAYS; d++) {
    
    x += DISPLAY_GAPS[d];
    if(d >= 1) x += DISPLAY_WIDTHS[d-1];
    
    displays[d] = new Display(x, y, DISPLAY_WIDTHS[d], DISPLAY_HEIGHT);
    
    
    totalWidth += (DISPLAY_GAPS[d]+DISPLAY_WIDTHS[d]);
    //x = totalWidth;
    
    println("x: "+x);

  }


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

  // time increment
  timeStep = 1.0/FPS;

  // content manager, separate from main app so it can be modified
  content = new Content();
  
  hud = new HUD();

  background(0);
}

void draw() {
  background(0);

  // render gfx
  content.render();

  // display content
  displayGFX();
  
  // render black in between displays for preview
  renderGaps(); 

  // record frames
  if (RECORD && !RECORD_PREVIEW) recordFrames();
  if(RECORD_PREVIEW) recordPreview();
  
  hud.render();
  
  //increment time
  time += timeStep;
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
  
  float x = 0;
  float y = (height-preview_height)*.5;
  float h = DISPLAY_HEIGHT*previewScalar;
  
  for(int d=0; d<TOTAL_DISPLAYS; d++) {
    float w = DISPLAY_GAPS[d]*previewScalar;
    
    fill(0);
    noStroke();
    
    rect(x, y, w, h);
    
    x += (DISPLAY_GAPS[d]+DISPLAY_WIDTHS[d])*previewScalar;
  }
  
  pop();
}

void recordFrames() {
  
    String frameString = nfs(frameCount, 4);
    String fileName = SKETCH_NAME+"_"+frameString+".png";
  
    for(int d=0; d<TOTAL_DISPLAYS; d++) {
      
      String displayString = "/display"+(d+1);
      
      String path = OUTPUT_PATH+displayString+"/"; 
      
      int x = displays[d].x;
      int y = displays[d].y;
      int w = displays[d].w;
      int h = displays[d].h;
      
      PImage displayFrame = createImage(DISPLAY_WIDTHS[d], DISPLAY_HEIGHT, RGB);
      
      displayFrame.copy(gfx, x, y, w, h, 0, 0, DISPLAY_WIDTHS[d], DISPLAY_HEIGHT);
      
      displayFrame.save(path+displayString+fileName);
      
    }
    
    if (frameCount == TOTAL_FRAMES ) exit();
}

void recordPreview() {
  
  String frameString = nfs(frameCount, 4);
  String fileName = SKETCH_NAME+"_"+frameString+".png";
  
  String path = OUTPUT_PATH+"preview/"; 
  
  save(path+fileName);
  
  if (frameCount == TOTAL_FRAMES ) exit();
  
}

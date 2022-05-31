// Keystone lib https://github.com/davidbouchard/keystone
// http://deadpixel.ca/keystone/reference/index.html
import deadpixel.keystone.*;


Keystone ks;
CornerPinSurface[] surfaces;

PGraphics gfx;

Content content;

HUD hud;

void settings() {
  loadSettings();
  parseSettings();

  fullScreen(P3D);

  smooth(8);
}

void setup() {

  background(0);
  frameRate(FPS);
  noCursor();

  gfx = createGraphics(GFX_WIDTH, GFX_HEIGHT, P3D);

  // init keystone surfaces
  ks = new Keystone(this);
  surfaces = new CornerPinSurface[SURFACE_DATA.length];

  for(int i=0; i < SURFACE_DATA.length; i++) {
    int w = SURFACE_DATA[i].w;
    int h = SURFACE_DATA[i].h;
    int res = SURFACE_DATA[i].res;

    surfaces[i] = ks.createCornerPinSurface(w, h, res);
  }

  ks.load(KEYSTONE_DATA_PATH);

  // content manager, separate from main app so it can be modified
  content = new Content();
  content.render();

  hud = new HUD();
}

void draw() {

  if(ks.isCalibrating()) cursor();
  else noCursor();

  background(0);

  // render gfx
  content.render();

  // display keystone surfaces


  for(int i=0; i < SURFACE_DATA.length; i++) {
    int tx = SURFACE_DATA[i].tx;
    int ty = SURFACE_DATA[i].ty;
    int tw = SURFACE_DATA[i].tw;
    int th = SURFACE_DATA[i].th;

    surfaces[i].render(gfx, tx, ty, tw, th);
  }

  // record frames
  if (RECORD) recordFrames(frameCount);

  hud.render();

}


void recordFrames(int frameNumber) {

  String frameString = nfs(frameNumber, 4);

  String fileName = SKETCH_NAME+"_"+frameString+".png";
  String path = OUTPUT_PATH;

  save(path+fileName);

  if (frameCount == TOTAL_FRAMES ) exit();
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load(KEYSTONE_DATA_PATH);
    break;

  case 's':
    // saves the layout
    ks.save(KEYSTONE_DATA_PATH);
    break;
  }
}

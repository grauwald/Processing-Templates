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

  gfx = createGraphics(GFX_WIDTH, GFX_HEIGHT, P3D);

  // TODO init keystone surfaces

  // content manager, separate from main app so it can be modified
  content = new Content();
  content.render();

  hud = new HUD();
}

void draw() {

  background(0);

  // render gfx
  content.render();

  // display content
  //  TODO render keystone surfaces

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



Display[] displays;

PGraphics gfx;

Content content;

HUD hud;

void settings() {
  loadSettings();
  parseSettings();

  if (RECORD && !RECORD_PREVIEW) size(400, 300, P3D);
  else fullScreen(P3D);

  smooth(8);
}

void setup() {

  gfx = createGraphics(totalWidth, totalHeight, P3D);

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
  if (RECORD && !RECORD_PREVIEW) recordFrames(frameCount);
  if (RECORD_PREVIEW) recordPreview();

  if(RECORD_PROOF) {
    int frame = round(time/timeStep); //round(random(TOTAL_FRAMES));
    recordFrames(frame);

    time = round(random(TOTAL_FRAMES))*timeStep;

    proofsRecorded++;
    if(proofsRecorded == TOTAL_PROOFS) exit();

  }

  hud.render();

  //increment time
  if(!RECORD_PROOF) time += timeStep;
}

void displayGFX() {
  push();

  imageMode(CENTER);
  translate(width*.5, height*.5);

  image(gfx, 0, 0, previewWidth, previewHeight);

  pop();
}

void renderGaps() {
  push();

  float x = 0;
  float y = (height-previewHeight)*.5;
  float h = DISPLAY_HEIGHT*previewScalar;

  for (int d=0; d<TOTAL_DISPLAYS; d++) {
    float w = DISPLAY_GAPS[d]*previewScalar;

    fill(0);
    noStroke();

    rect(x, y, w, h);

    x += (DISPLAY_GAPS[d]+DISPLAY_WIDTHS[d])*previewScalar;
  }

  pop();
}

void recordFrames(int frameNumber) {

  String frameString = nfs(frameNumber, 4);

  for (int d=0; d<TOTAL_DISPLAYS; d++) {

    String displayString = "display"+(d+1);
    String fileName = SKETCH_NAME+"_"+displayString+"_"+frameString+".png";
    String path = OUTPUT_PATH+displayString+"/";

    if(RECORD_PROOF) path += "/proofs/";


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

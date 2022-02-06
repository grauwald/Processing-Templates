

PGraphics gfx;

Content content;

HUD hud;

String[] ffmpeg_commands = new String[0];

void settings() {
  loadSettings();

  size(totalWidth, totalHeight, P3D);

  smooth(8);
}

void setup() {

  background(0);

  if(RECORD) frameRate(120);
  else frameRate(FPS);

  gfx = createGraphics(totalWidth, totalHeight, P3D);

  initContent();

  hud = new HUD();

}

void initContent() {
  // content manager, separate from main app so it can be modified
  content = new Content();
  content.render();

  currentPiece++;
  currentFrame = 0;
}

void draw() {

  background(0);

  // render gfx
  content.render();

  // display content
  image(gfx, 0, 0, totalWidth, totalHeight);

  // record frames
  if (RECORD) recordFrames();

  hud.render();

  time += timeStep;
}

void recordFrames() {

  String frameString = nf(currentFrame, 5);
  currentFrame++;

  String fileName = SKETCH_NAME+"_"+frameString+".png";

  String pieceFolder = nf(currentPiece, 3);
  String localPath = OUTPUT_PATH+pieceFolder+"/";

  gfx.save(localPath+fileName);

  if (currentFrame == TOTAL_FRAMES ){

    // construct terminal command to assemble APNG file
    // requires FFMPEG installed on system https://www.ffmpeg.org/
    String ffmpeg = "ffmpeg -i "+sketchPath()+"/"+localPath+SKETCH_NAME+"_%05d.png";
    ffmpeg += " -framerate "+FPS+" -vframes "+TOTAL_FRAMES+" -plays 0 -f apng -vf \"split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse\" ";
    ffmpeg += sketchPath()+"/"+OUTPUT_PATH+SKETCH_NAME+"_"+pieceFolder+".png";

    String[] ffmpegSegments = splitTokens(ffmpeg);

    println(ffmpeg);

    ffmpeg_commands = append(ffmpeg_commands, ffmpeg);

    // delay(1000);
    // exec(ffmpegSegments);

    // if we're at the last one close the program
    println("currentPiece/TOTAL_PIECES: ", currentPiece+"/"+TOTAL_PIECES);
    if(currentPiece >= TOTAL_PIECES){
      saveStrings("output/ffmpeg_commands.txt", ffmpeg_commands);
      exit();

    }
    // otherwise generate the next piece
    else initContent();
  }
}

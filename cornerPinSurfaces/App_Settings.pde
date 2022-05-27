
String settingsPath = "settings.json";

Boolean RECORD;

String OUTPUT_PATH;
String SKETCH_NAME;

int GFX_WIDTH;
int GFX_HEIGHT;

int FPS;

int START_TIME;

int TOTAL_FRAMES;

float totalWidth, totalHeight;

float time, timeStep;


void loadSettings() {
  JSONObject settings = loadJSONObject(settingsPath);

  RECORD = settings.getBoolean("record");

  OUTPUT_PATH = settings.getString("output_path");
  SKETCH_NAME = settings.getString("sketch_name");

  GFX_WIDTH = settings.getInt("gfx_width");
  GFX_HEIGHT = settings.getInt("gfx_height");

  TOTAL_FRAMES = settings.getInt("total_frames");

  FPS = settings.getInt("fps");
  START_TIME = settings.getInt("start_time");

}

void parseSettings() {

  // float version for easier calculations
  totalWidth = GFX_WIDTH;
  totalHeight = GFX_HEIGHT;

  // start time
  time = START_TIME;

  // time increment
  timeStep = 1.0/FPS;

}

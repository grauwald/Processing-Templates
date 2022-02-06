
String settingsPath = "settings.json";

Boolean RECORD;

int TOTAL_PIECES;
int currentPiece = 0;

String OUTPUT_PATH;
String SKETCH_NAME;

int TOTAL_FRAMES;// = 20;
int currentFrame = 0;

int FPS;// = 60;

int totalWidth, totalHeight;

float time, timeStep;

void loadSettings() {
  JSONObject settings = loadJSONObject(settingsPath);

  RECORD = settings.getBoolean("record");

  TOTAL_PIECES = settings.getInt("total_pieces");

  OUTPUT_PATH = settings.getString("output_path");
  SKETCH_NAME = settings.getString("sketch_name");

  totalWidth = settings.getInt("display_width");
  totalHeight = settings.getInt("display_height");

  TOTAL_FRAMES = settings.getInt("total_frames");

  FPS = settings.getInt("fps");
  time = settings.getInt("start_time");
  timeStep = 1.0/FPS;

}

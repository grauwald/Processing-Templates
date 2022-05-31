
String settingsPath = "settings.json";

Boolean RECORD;

String OUTPUT_PATH;
String SKETCH_NAME;

int GFX_WIDTH;
int GFX_HEIGHT;

int FPS;

int START_TIME;

int TOTAL_FRAMES;

SurfaceData[] SURFACE_DATA;

String KEYSTONE_DATA_PATH;

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

  // get abstractions of surfaces
  JSONArray surfaceArray = settings.getJSONArray("surfaces");
  SURFACE_DATA = new SurfaceData[ surfaceArray.size() ];

  for(int i=0; i < SURFACE_DATA.length; i++) {
    JSONObject surface = surfaceArray.getJSONObject(i);
    int w = surface.getInt("w");
    int h = surface.getInt("h");
    int res = surface.getInt("res");

    int tx = surface.getInt("tx");
    int ty = surface.getInt("ty");
    int tw = surface.getInt("tw");
    int th = surface.getInt("th");

    SURFACE_DATA[i] = new SurfaceData(w, h, res, tx, ty, tw, th);
  }

  // path to keystone lib's settings file
  KEYSTONE_DATA_PATH = settings.getString("keystoneDataPath");

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

// a simple data abstraction of surface
class SurfaceData {
  int w, h, res;
  int tx, ty, tw, th;

  SurfaceData(int _w, int _h, int _res, int _tx, int _ty, int _tw, int _th) {
    w = _w;
    h = _h;
    res = _res;

    // source texture coordinates to grab only part of PGraphics
    tx = _tx;
    ty = _ty;
    tw = _tw;
    th = _th;

  }
}

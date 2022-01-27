
String settingsPath = "settings_spheres.json";

Boolean RECORD;
Boolean RECORD_PREVIEW;
Boolean RECORD_PROOF;

int TOTAL_PROOFS;

String OUTPUT_PATH;
String SKETCH_NAME;

int[] DISPLAY_WIDTHS; // = {480, 480, 480, 480, 480, 3040, 480, 480, 480, 480, 480};
int DISPLAY_HEIGHT;// = 1600;

int TOTAL_DISPLAYS;// = 11;

int[] DISPLAY_GAPS;// = {0, 576, 576, 576, 576, 896, 896, 576, 576, 576, 576};

int TOTAL_FRAMES;// = 20;

int FPS;// = 60;

int START_TIME;// = 0;

int totalWidth, totalHeight;

float time, timeStep;

float previewScalar;
float previewWidth, previewHeight;

int proofsRecorded = 0;

void loadSettings() {
  JSONObject settings = loadJSONObject(settingsPath);

  RECORD = settings.getBoolean("record");
  RECORD_PREVIEW = settings.getBoolean("record_preview");

  RECORD_PROOF = settings.getBoolean("record_proof");
  TOTAL_PROOFS = settings.getInt("total_proofs");

  OUTPUT_PATH = settings.getString("output_path");
  SKETCH_NAME = settings.getString("sketch_name");

  JSONArray display_widths_json = settings.getJSONArray("display_widths");
  DISPLAY_WIDTHS = new int[ display_widths_json.size() ];
  for(int i=0; i<DISPLAY_WIDTHS.length; i++) DISPLAY_WIDTHS[i] = display_widths_json.getInt(i);



  DISPLAY_HEIGHT = settings.getInt("display_height");

  // ⚠️ this could be got by combing display width array with gap array as array of display objects
  // would require pre-calculating screen positions, but useful if heights and y pos vary between displays
  TOTAL_DISPLAYS = settings.getInt("total_displays");

  JSONArray display_gaps_json = settings.getJSONArray("display_gaps");
  DISPLAY_GAPS = new int[ display_gaps_json.size() ];
  for(int i=0; i<DISPLAY_GAPS.length; i++) DISPLAY_GAPS[i] = display_gaps_json.getInt(i);

  TOTAL_FRAMES = settings.getInt("total_frames");

  FPS = settings.getInt("fps");
  START_TIME = settings.getInt("start_time");

}

void parseSettings() {
  // get sizes
  for (int d=0; d < TOTAL_DISPLAYS; d++) totalWidth += (DISPLAY_GAPS[d]+DISPLAY_WIDTHS[d]);
  totalHeight = DISPLAY_HEIGHT;

  // setup preview scaling
  if (totalWidth >= totalHeight) {
    previewWidth = displayWidth;
    previewScalar = float(displayWidth)/totalWidth;
    previewHeight = totalHeight*previewScalar;
  } else {
    previewHeight = displayHeight;
    previewScalar = float(displayHeight)/totalHeight;
    previewWidth = totalWidth*previewScalar;
  }

  println("previewWidth: "+previewWidth);
  println("previewHeight: "+previewHeight);

  // display properties
  displays = new Display[TOTAL_DISPLAYS];

  int x = 0;
  int y = 0;

  for (int d=0; d < TOTAL_DISPLAYS; d++) {
    x += DISPLAY_GAPS[d];
    if (d >= 1) x += DISPLAY_WIDTHS[d-1];

    if (RECORD || RECORD_PROOF) displays[d] = new Display(x, y, DISPLAY_WIDTHS[d], DISPLAY_HEIGHT);
    else displays[d] = new Display(
      round(x*previewScalar),
      round(y*previewScalar),
      round(DISPLAY_WIDTHS[d]*previewScalar),
      round(DISPLAY_HEIGHT*previewScalar)
    );
  }


  // set render buffer
  if (!RECORD && !RECORD_PROOF) {
    totalWidth = round(previewWidth);
    totalHeight = round(previewHeight);
  }


  // start time
  time = START_TIME;

  // time increment
  timeStep = 1.0/FPS;

}

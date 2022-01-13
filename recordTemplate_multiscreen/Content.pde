class Content {

  Content() {
    
  }
  
  void render() {
    gfx.beginDraw();

    gfx.background(255, 0, 255);
    
    gfx.strokeWeight(10);
    gfx.stroke(0, 255, 255);
    gfx.noFill();
    
    for(int d=0; d<displays.length; d++) {
      
      int x = displays[d].x;
      int y = displays[d].y;
      int w = displays[d].w;
      int h = displays[d].h;
      
      gfx.rect(x, y, w, h);
    
    }
  
    gfx.endDraw();
  }

}

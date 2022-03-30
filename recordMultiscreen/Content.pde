class Content {

  Content() {

  }

  void render() {
    gfx.beginDraw();

    // gfx.perspective(PI/3.0,(float)totalWidth/totalHeight,1, totalWidth*10);
    gfx.ortho();

    gfx.background(255, 0, 255);

    gfx.strokeWeight(10);
    gfx.stroke(0, 255, 255);
    // gfx.fill(255, 255, 0, 128 );
    //
    // for(int d=0; d<displays.length; d++) {
    //
    //   int x = displays[d].x;
    //   int y = displays[d].y;
    //   int w = displays[d].w;
    //   int h = displays[d].h;
    //
    //   gfx.rect(x, y, w, h);
    //
    // }

    gfx.lights();

    gfx.translate(totalWidth*.5, totalHeight*.5, (sin(time*.2)-1)*.5*totalWidth*2);
    gfx.rotateX(time*.12);
    gfx.rotateY(time*.17);
    gfx.fill(255, 255, 0);
    gfx.box(totalWidth*.5);

    gfx.endDraw();
  }

}

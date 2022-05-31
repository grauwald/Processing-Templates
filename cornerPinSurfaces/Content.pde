class Content {

  Content() {

  }

  void render() {
    gfx.beginDraw();

    gfx.ortho();

    gfx.background(0);

    gfx.lights();

    gfx.strokeWeight(10);
    gfx.stroke(0);

    gfx.translate(totalWidth*.95, totalHeight*.5, (sin(time*.2)-1)*.5*totalWidth*2);

    float max = 7.0;
    for(int d=0; d<max; d++) {
      float p = d/max;

      gfx.rotateX(time*.012*p);
      gfx.rotateY(time*.017*p);
      gfx.fill(255*p, 128);
      gfx.box(totalWidth*(p+.01)*1.25);
    }

    gfx.endDraw();
  }

}

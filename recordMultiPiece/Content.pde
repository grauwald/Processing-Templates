class Content {

  color c1, c2, c3;

  Content() {
    colorMode(HSB);
    c1 = color(random(255), 255, 255);
    c2 = color(random(255), 255, 255);
    c3 = color(random(255), 255, 255);
  }

  void render() {
    gfx.beginDraw();

    // gfx.perspective(PI/3.0,(float)totalWidth/totalHeight,1, totalWidth*10);
    gfx.colorMode(HSB);
    gfx.ortho();

    gfx.background(c1);

    gfx.strokeWeight(10);
    gfx.stroke(c2);

    gfx.fill(c3);


    gfx.lights();

    gfx.translate(totalWidth*.5, totalHeight*.5, (sin(time*.2)-1)*.5*totalWidth*2);
    gfx.rotateX(time*.12);
    gfx.rotateY(time*.17);

    gfx.box(totalWidth*.5);

    gfx.endDraw();
  }

}

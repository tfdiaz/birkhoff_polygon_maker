int col;
int row;
int newx = 2000;
int newy = 200;

class Timeline extends PApplet {
  Timeline() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(2000, 240);
  }

  void setup() {
    background(150);
    row = 1;
    col = 10;
  }

  void draw() {
    background(150);
    float xoff = width / col;
    float yoff = 1.0;
    for (int i = gp.ct - 1, o = 0; i >= 0; i--, o++) {
      Shape sh = gp.grp[i];
      stroke(255);
      line(xoff * o, 0, xoff * o, height);
      fill(#BFFDFF);
      noStroke();
      beginShape();
      for (int j = 0; j < sh.num; j++) {
        vertex(sh.best[j][0] + (xoff * o), sh.best[j][1] + yoff);
       }
      endShape();
      textAlign(CENTER);
      fill(0);
      String title = "Score: " + String.format("%.3f", sh.score);
      String t_time = "Time: " + String.format("%d", sh.time);
      text(title, (xoff * o + xoff / 2), newy + 5);
      text(t_time, (xoff *o + xoff / 2), newy + 20);
    }
  }

  void mousePressed() {
    println("mousePressed in secondary window");
    println(width, height);
  }
}

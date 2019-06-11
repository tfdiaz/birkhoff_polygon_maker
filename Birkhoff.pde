Shape sh;
Group gp;
PWindow win;
Button v_sym;
Button h_sym;
Button bal;

public void settings() {
  size(300, 300);
}

void setup() {
  sh = new Shape(10);
  gp = new Group(10);
  win = new PWindow();
  v_sym = new Button(10, height - 20, 10);
  h_sym = new Button(25, height - 20, 10);
  bal = new Button(40, height - 20, 10);
  generate(sh, gp);
}

void draw_buttons() {
  v_sym.display();
  h_sym.display();
  bal.display();
}

void draw() {
  background(10);
  pusher(sh);
  sh.display(false);
  draw_buttons();
  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2); 
  //float[][] verts = new float[4][2];
  //verts[0][0] = width/2 - 40;
  //verts[1][0] = width/2 + 40;
  //verts[2][0] = width/2 - 40;
  //verts[3][0] = width/2 + 40;
  //verts[0][1] = 50;
  //verts[1][1] = 50;
  //verts[2][1] = 150;
  //verts[3][1] = 150;
  //sorter(verts, 4);
  //beginShape();
  //for (int i = 0; i < 4; i++)
  //  vertex(verts[i][0], verts[i][1]);
  //endShape();
  //println(vert_scorer(verts, 4));
}

void mousePressed() {
  v_sym.setButton();
  h_sym.setButton();
  bal.setButton();
  sh = new Shape(10);
  generate(sh, gp);
  gp.insert(sh);
  gp.ct = 0;
  redraw();
}

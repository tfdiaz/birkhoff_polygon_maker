Shape sh;
Group gp;
Timeline win;
Button v_sym;
Button h_sym;
Button bal;
Button unsat_b;
Change_Value b_increase;
Change_Value b_decrease;
int poly_size = 4;

public void settings() {
  size(400, 400);
}

void setup() {
  sh = new Shape(poly_size);
  gp = new Group(10);
  win = new Timeline();
  v_sym = new Button(10, height - 20, 10);
  h_sym = new Button(25, height - 20, 10);
  bal = new Button(40, height - 20, 10);
  unsat_b = new Button(55, height - 20, 10);
  b_increase = new Change_Value(width - 20, 10, 10, true);
  b_decrease = new Change_Value(width - 20, 30, 10, false);
  generate(sh, gp);
}

void draw_buttons() {
  v_sym.display();
  h_sym.display();
  bal.display();
  unsat_b.display();
  b_increase.display();
  b_decrease.display();
}

void draw() {
  background(10);
  //pusher(sh);
  generate(sh, gp);
  sh.display(true);
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
  //noLoop();
}

void mousePressed() {
  v_sym.setButton();
  h_sym.setButton();
  bal.setButton();
  unsat_b.setButton();
  b_increase.setButton();
  b_decrease.setButton();
  sh = new Shape(poly_size);
  generate(sh, gp);
  gp.insert(sh);
  gp.ct = 0;
  redraw();
}

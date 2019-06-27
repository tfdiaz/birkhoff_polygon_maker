void cpyOver(Shape dest, Shape src) {
  for (int i = 0; i < dest.num; i++) {
    copypts(dest.verts, src.verts, i, i);
    copypts(dest.best, src.best, i, i);
  }
  dest.score = src.score;
  dest.time = src.time;
}

float xmin, ymin, xmax, ymax;

void centerPts(float[][] verts, int num) {
  float x_center = 0;
  float y_center = 0;
  xmin = width;
  ymin = height;
  xmax = 0.0;
  ymax = 0.0;
  for (int i = 0; i < num; i++) {
    float curx = verts[i][0];
    float cury = verts[i][1];
    if (curx > xmax)
      xmax = curx;
    if (curx < xmin)
      xmin = curx;
    if (cury > ymax)
      ymax = cury;
    if (cury < ymin)
      ymin = cury;
  }
  x_center = ((width - xmax) - xmin) / 2;
  y_center = ((height - ymax) - ymin) / 2;
  
  for (int i = 0; i < num; i++) {
    verts[i][0] += x_center;
    verts[i][1] += y_center;
  }
}

int prev_time = millis();

void generate(Shape poly, Group grp) {
  
    int num = poly.num;
    float[][] verts = poly.verts;
    float[][] bst = poly.best;
    float prev = poly.score;
    float score = 0.0;
    
    for (int t = 0; t < 50000; t++) {
      for (int i = 0; i < num; i++) {
        verts[i][0] = random(width);
        verts[i][1] = random(height);
      }
      centerPts(verts, num);
      score = scoreit(verts, num);
       if (score > poly.score) {
         poly.time = millis() - prev_time;
         prev_time = millis();
         poly.score = score;
         for (int i = 0; i < num; i++) {
           bst[i][0] = verts[i][0];
           bst[i][1] = verts[i][1];
         }
         println("score:", score);
         if (v_sym.isOn)
           println("vert:", vert_scorer(bst, num));
         if (h_sym.isOn)
           println("hort:", hort_scorer(bst, num));
         if (bal.isOn)
           println("bal:", bal_scorer(bst, num));
         if (unsat_b.isOn)
           println("unsat:", unsat_scorer(bst, num));
         break;
       }
    }
    if (prev != poly.score) {
      for (int i = 0; i < num; i++) {
        verts[i][0] = bst[i][0];
        verts[i][1] = bst[i][1];
      }
      sorter(bst, num);
      grp.insert(poly);
    }
    sorter(verts, num);
}

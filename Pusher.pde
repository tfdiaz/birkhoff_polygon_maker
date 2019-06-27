float amt = 1.0;

float scoreit(float[][] verts, int num) {
  float score = 0.0;
  int b_num = 0;
     if (v_sym.isOn) {
        score += vert_scorer(verts, num);
        b_num++;
      }
      if (h_sym.isOn) {
        score += hort_scorer(verts, num);
        b_num++;
      }
      if (bal.isOn) {
        score += bal_scorer(verts, num);
        b_num++;
      }
      if (unsat_b.isOn) {
        score += unsat_scorer(verts, num);
        b_num++;
      }
      if (b_num == 0)
        b_num++;
      score /= b_num;
      return score;
}

void  pusher(Shape poly) {
  float score = poly.score;
  int num = poly.num;
  for (int i = 0; i < num; i++) {
    float newScr;
    int dir = (int) random(4);
      for(int c = 0; c < num; c++) {
        if (dir == 0 && poly.verts[i][1] - amt > 0.0)
          poly.verts[i][1] -= amt;
        else if (dir == 1 && poly.verts[i][0] + amt < width)
          poly.verts[i][0] += amt;
        else if (dir == 2 && poly.verts[i][1] + amt < height)
          poly.verts[i][1] += amt;
        else if (dir == 3 && poly.verts[i][0] - amt > 0.0)
          poly.verts[i][0] -= amt;
        newScr = scoreit(poly.verts, num);
        if (newScr > score) {
          println("Shifting:", newScr);
          score = newScr;
          poly.score = score;
          //amt *= 0.9;
          break;
        } else {
          if (dir == 0)
            poly.verts[i][1] += amt;
          else if (dir == 1)
            poly.verts[i][0] -= amt;
          else if (dir == 2)
            poly.verts[i][1] -= amt;
          else if (dir == 3)
            poly.verts[i][0] += amt;
            amt = random(10);
        }
        dir = (int) random(4);
      }
    //  ct++;
    //}
  }
}

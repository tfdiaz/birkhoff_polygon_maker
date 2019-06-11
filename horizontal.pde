//Lets make sure to split the points and then do the subtraction!

float hort_scorer(float[][] verts, int num) {
    int t = 0;
    int b = 0;
    float[] ty = new float[num];
    float[] tx = new float[num];
    float[] by = new float[num];
    float[] bx = new float[num];
    for (int i = 0; i < num; i++) {
      if (verts[i][1] < height/2) {
        ty[t] = verts[i][1];
        tx[t] = verts[i][0];
        t++;
      }
      else {
        by[b] = verts[i][1];
        bx[t] = verts[i][0];
        b++;
      }
    }
    for (int i = 0; i < num - t; i++) {
      ty = shorten(ty);
      tx = shorten(tx);
    }
    for (int i = 0; i < num - b; i++) {
      by = shorten(by);
      bx = shorten(bx);
    }
    ty = sort(ty);
    tx = sort(tx);
    by = sort(by);
    bx = sort(bx);
    float yerr = 0;
    float xerr = 0;
    for (int i = 0; i < t || i < b; i++) {
      if (i >= t) {
        yerr += abs((by[i] - height/2));
        xerr += bx[i];
      }
      else if (i >= b) {
        yerr += abs((height/2 - ty[i]));
        xerr += tx[i];
      }
      else {
        yerr += abs((height/2 - ty[i]) - (by[i] - height/2));
        xerr += abs(tx[i] - bx[i]);
      }
    }
    yerr /= (ymax - ymin);
    xerr /= (xmax - xmin);
    float err = (yerr + xerr) /2;
    return 1.0 - err;
}

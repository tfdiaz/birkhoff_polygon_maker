float vert_scorer(float[][] verts, int num) {
    int left = 0;
    int right = 0;
    float[] rx = new float[num];
    float[] ry = new float[num];
    float[] lx = new float[num];
    float[] ly = new float[num];
    for (int i = 0; i < num; i++) {
      if (verts[i][0] < width/2) {
        lx[left] = verts[i][0];
        ly[left] = verts[i][1];
        left++;
      }
      else {
        rx[right] = verts[i][0];
        ry[right] = verts[i][1];
        right++;
      }
    }
    for (int i = 0; i < num - left; i++) {
      lx = shorten(lx);
      ly = shorten(ly);
    }
    for (int i = 0; i < num - right; i++) {
      rx = shorten(rx);
      ry = shorten(ry);
    }
    rx = sort(rx);
    ry = sort(ry);
    lx = sort(lx);
    ly = sort(ly);
    float xerr = 0;
    float yerr = 0;
    for (int i = 0; i < left || i < right; i++) {
      if (i >= left) {
        xerr += abs((rx[i] - width/2));
        yerr += ry[i];
      }
      else if (i >= right) {
        xerr += abs((width/2 - lx[i]));
        yerr += ly[i];
      }
      else {
        xerr += abs((width/2 - lx[i]) - (rx[i] - width/2));
        yerr += abs(ly[i] - ry[i]);
      }
    }
    xerr /= (xmax - xmin);
    yerr /= (ymax - ymin);
    float err = (xerr + yerr) / 2;
    return 1.0 - err;
}

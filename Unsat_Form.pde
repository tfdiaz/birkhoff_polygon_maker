double distance(float[] p1, float[] p2) {
  double dist = Math.sqrt(Math.pow(p1[0] - p2[0], 2) + Math.pow(p1[1] - p2[1], 2));
  return dist;
}

double find_angle(float[] p1, float [] p2, float [] p3) {
  double p12 = distance(p1, p2);
  double p23 = distance(p2, p3);
  double p13 = distance(p1, p3);
  
  double angle = Math.toDegrees(Math.acos((p12 * p12 + p23 * p23 - p13 * p13) / ( 2 * p12 * p23)));
  return angle;
}

float unsat_scorer(float[][] verts, int num) {
  float average = 360.0 / num;
  double a1;
  double tot = 0.0;
  for (int i = 0; i < num; i++) {
    if (i == 0)
      a1 = find_angle(verts[num - 1], verts[i], verts[i + 1]);
    else if (i == num - 1)
      a1 = find_angle(verts[i - 1], verts[i], verts[0]);
    else
      a1 = find_angle(verts[i - 1], verts[i], verts[i + 1]);
    tot += (double) abs((float) a1 - average);
  }
  //tot /= (float) num;
  //println(tot);
  return -1.0 * (float) tot / 360.0;
}

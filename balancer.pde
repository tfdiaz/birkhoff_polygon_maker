//Scan the points and when the point crosses the line put the new point in and continue on

float calcArea(float[][] verts, int num) {
  float area = 0;
  
  sorter(verts, num);
  int j = num - 1;
  
  for (int i = 0; i < num; i++) {
    area += (verts[j][0] + verts[i][0]) * (verts[j][1] - verts[i][1]);
    j = i;
  }
  return area/2.0;
}

void  copypts(float[][] dest, float[][] src, int d, int s) {
  dest[d][0] = src[s][0];
  dest[d][1] = src[s][1];
}

void  copypts(float[][] dest, float[] src, int d) {
  dest[d][0] = src[0];
  dest[d][1] = src[1];
}

void  copypts(float[] dest, float[][] src, int s) {
  dest[0] = src[s][0];
  dest[1] = src[s][1];
}

float[] calcMid(float[][] verts, int i, boolean flag) {
  float[] ret = new float[2];
  float[] p1 = new float[2];
  float[] p2 = new float[2];
  
  copypts(p1, verts, i);
  if (flag)
    copypts(p2, verts, i - 1);
  else
    copypts(p2, verts, 0);
  float slope = p1[1] - p2[1];
  float tmp = p2[0] - p1[0];
  float offset = slope* p2[0] + tmp*p2[1];
  
  slope *= -1;
  slope /= tmp;
  offset /= tmp;
  
  ret[0] = width/2;
  ret[1] = ret[0] * slope + offset;
  return ret;
}

void shift(float[][] verts, int num) {
  for (int t = 0; t < num; t++) {
    if (verts[0][0] > width/2)
      break;
    float xtmp = 0.0;
    float ytmp = 0.0;
    int i = 0;
    for (i = 0; i < num - 1; i++) {
      if (i == 0) {
        xtmp = verts[i][0];
        ytmp = verts[i][1];
      }
      copypts(verts, verts, i, i + 1);
    }
    verts[i][0] = xtmp;
    verts[i][1] = ytmp;
  }
}

float splitter(float[][] verts, float[][] right, float[][] left, int num) {
  sorter(verts, num);
  //for (int i = 0; i < num; i++) {
  //  println("x:", verts[i][0], "y:" , verts[i][1]);
  //}
  int i = 0;
  int top = 0;
  boolean bottom = false;
  int l = 0;
  int r = 0;
  if (verts[0][0] < width/2)
    shift(verts, num);
  for (; i < num; i++) {
    if (verts[i][0] > width/2) {
      if (top == 0)
        top = 1;
      else if (top == 2) {
        //println("In strange loop");
        bottom = true;
        float[] insert = calcMid(verts, i, true);
        copypts(right, insert, r);
        r++;
        copypts(left, insert, l);
        l++;
        top = 3;
      }
      copypts(right, verts, r, i);
      r++;
    }
    else {
      if (top == 1) {
        float[] insert = calcMid(verts, i, true);
        copypts(right, insert, r);
        r++;
        copypts(left, insert, l);
        l++;
        top = 2;
      }
      copypts(left, verts, l, i);
      l++;
    }
  }
 
  if (top == 2 && !bottom) {
    //println("Exiting normally");
    float[] insert = calcMid(verts, i - 1, false);
    copypts(right, insert, r);
    r++;
    copypts(left, insert, l);
    l++;
  }
// DEBUGGING
  //for (int t = 0; t < num; t++)
  //  println("X:", verts[t][0], "Y:", verts[t][1]);
  //println("Right", r);
  //for (int q = 0; q < r; q++)
  //  println("x:", right[q][0], "y:", right[q][1]);
  //println("Left", l);
  //for (int a = 0; a < l; a++)
  //  println("z:", left[a][0], "y:", left[a][1]);
  float ra = calcArea(right, r);
  float la = calcArea(left, l);
  //test(right, r, true);
  //test(left, l, false);
  double score = 0.0;
  if (ra > la)
    score = la / ra;
  score = ra / la;
  if (score > 1.0)
    score = Math.pow((double) 2.0, -1.0 * (score - 1.0));
  else
    score = Math.pow((double) 2.0, (score - 1.0));
  
  return (float) score;
}

void test(float[][]verts, int num, boolean flag) {
  
  sorter(verts, num);
  if (flag)  
    fill(#E50E0E, 80);
  else
    fill(#6EE50E, 80);
  noStroke();
  beginShape();
  for (int i = 0; i < num; i++) {
    vertex(verts[i][0], verts[i][1]);
  }
  endShape();
}

float bal_scorer(float[][] verts, int num) {
  float[][] right = new float[num + 2][2];
  float[][] left = new float[num + 2][2];
  
  float score = splitter(verts, right, left, num);
  return score;
}

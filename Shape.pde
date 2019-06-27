class Shape {
  float[][] verts;
  float[][] best;
  float score;
  int num;
  int w;
  int h;
  int time;
  
  Shape(int ct) {
    verts = new float[ct][2];
    w = width;
    h = height;
    best = new float[ct][2];
    score = -199999.0;
    num = ct;
  }
  
  void display() {
    fill(#BFFDFF);
    noStroke();
    beginShape();
    for (int i = 0; i < num; i++) {
      vertex(best[i][0], best[i][1]);
    }
    endShape();
  }

  void display(boolean val) {
    if (val) {
      display();
      fill(#BFFDFF, 40);
      noStroke();
      beginShape();
      for (int i = 0; i < num; i++) {
        vertex(verts[i][0], verts[i][1]);
      }
      endShape();
    }
    else {
      sorter(verts, num);
      fill(#BFFDFF);
      noStroke();
      beginShape();
      for (int i = 0; i < num; i++) {
        vertex(verts[i][0], verts[i][1]);
      }
      endShape();
    } 
  }
}

class Group {
  Shape[] grp;
  int ct;
  int len;
  
  Group(int l) {
    ct = 0;
    grp = new Shape[l];
    len = l;
  }
  
  void insert(Shape add) {
    Shape cpy = new Shape(add.num);
    cpyOver(cpy, add);
    this.normalize(cpy, row, col, newx, newy);
    if (ct < len) {
      grp[ct] = cpy;
      ct++;
    }
    else {
      for (int i = 0; i < ct - 1; i++) {
        grp[i] = grp[i + 1];
      }
      grp[ct - 1] = cpy;
    }
  }
  
 void normalize(Shape sp, int r, int c, int wid, int ht) {
   if (ct > 0) {
      float w = sp.w;
      float h = sp.h;
      if (w > 0 && c > 0 && r > 0 && h > 0) {
        float xscal = (wid / c) / w;
        float yscal = (ht / r) / h;
        for (int j = 0; j < sp.num; j++) {
            sp.best[j][0] *= xscal;
            sp.best[j][1] *= yscal;
        }
      }
    }
  }
}

class Button {
  int x, y;
  boolean isOn;
  int size;
  
  Button(int posx, int posy, int s) {
    x = posx;
    y = posy;
    size = s;
    isOn = true;
  }
  
  void setButton() {
    if (mouseX > x - size && mouseX < x + size && mouseY > y - size && mouseY < y + size) {
      isOn ^= true;
    }
  }
  
  void display() {
    if (isOn)
      fill(255);
    else
      fill(#B9B8B8);
    rect((float) x, (float) y, 10, 10);
  }
}

class Change_Value extends Button {
  boolean type;
  
  Change_Value(int posx, int posy, int s, boolean t) {
    super(posx, posy, s);
    type = t;
  }
  
  void setButton() {
    if (mouseX > x - size && mouseX < x + size && mouseY > y - size && mouseY < y + size) {
      if (type)
        poly_size++;
      else if (poly_size > 3)
        poly_size--;
    }
  }
}

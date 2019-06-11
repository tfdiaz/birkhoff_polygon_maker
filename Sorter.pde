void sorter(float[][] verts, int num) {
  float x_center = 0;
  float y_center = 0;
  int[] scores = new int[num];
  for (int i = 0; i < num; i++) {
    x_center += verts[i][0];
    y_center += verts[i][1];
  }
  x_center /= num;
  y_center /= num;
  for (int i = 0; i < num; i++) {
    double a1 = (Math.toDegrees(Math.atan2(verts[i][0] - x_center, verts[i][1] - y_center)) + 360) % 360;
    scores[i] = (int) (a1);
  }
  sort(scores, 0, num - 1, verts);
}

int partition(int arr[], int low, int high, float[][] verts) {
  int pivot = arr[high];
  int i = (low - 1);
  for (int j = low; j < high; j++) {
    if (arr[j] <= pivot)
    {
      i++;
      
      int tmp = arr[i];
      arr[i] = arr[j];
      arr[j] = tmp;
      
      float[] temp = new float[2];
      temp[0] = verts[i][0];
      temp[1] = verts[i][1];
      verts[i][0] = verts[j][0];
      verts[i][1] = verts[j][1];
      verts[j][0] = temp[0];
      verts[j][1] = temp[1];
    }
  }
  int tmp = arr[i + 1];
  arr[i + 1] = arr[high];
  arr[high] = tmp;
  
  float[] temp = new float[2];
  temp[0] = verts[i + 1][0];
  temp[1] = verts[i + 1][1];
  verts[i + 1][0] = verts[high][0];
  verts[i + 1][1] = verts[high][1];
  verts[high][0] = temp[0];
  verts[high][1] = temp[1];
  
  return i + 1;
}

void sort(int arr[], int low, int high, float[][] verts) {
  if (low < high) {
    int pi = partition(arr, low, high, verts);
    sort(arr, low, pi - 1, verts);
    sort(arr, pi + 1, high, verts);
  }
}

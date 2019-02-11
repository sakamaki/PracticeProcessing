class Initializer{
  
  public String geometry;
  public float[] interval = new float[100];

 //PrintWriter output;
  
  private int ran[] = {5, 3, 0, 1, 4, 5, 1, 2, 2, 3, 0, 4};
  
  private String geomType[] = {"line",
                               "polyline",
                               "curve",
                               "triangle",
                               "quadrangle",
                               "polygon",
                               "circle",
                               "ellipse"};
                               
  private String elements[];
  
  
  Initializer(int month, int day) {
    elements = loadStrings("data/intervals.txt");
    
    int itv = ran[month - 1];
    
    switch (itv) {
      case 0: equalItv();
              break;
      case 1: accelateItv();
              break;
      case 2: waveItv();
              break;
      case 3: sawWaveItv();
              break;
      case 4: pulsItv();
              break;
      case 5: noiseItv();
    }
    
    geometry = geomType[(int)map(day, 1, 31, 0., 7.99)];
    
  }
    
  private void equalItv() {
    for (int i = 0; i < 100; i++) {
      interval[i] = 1.0;
    }
  }
  
  private void accelateItv() {
    float sum = 0.0;  
    interval[0] = 1.0;
    for (int i = 1; i < 100; i++) {
      interval[i] = interval[i - 1] + 1./sqrt((float)i);
      sum += interval[i];
    }
    for (int i = 0; i < 100; i++) {
      interval[i] = interval[i] * 100. / sum;
    }
  }
  
  private void waveItv() {
    for (int i = 0; i < 10000; i+=100) {
      float w = map(i, 0, 9999, -0.5 * PI, PI * 9.5);
      interval[i/100] = sin(w) + 1.0;
    }
  }
  
  private void sawWaveItv() {
    float sum = 0.0;  
    for (int i = 0; i < 5; i++) {
      int k = i * 20;
      interval[k] = 0;
      for (int j = 1; j < 20; j++) {
        interval[k + j] = interval[k + j - 1] + 1./sqrt((float)j);
        sum += interval[k + j];
      }
    }
    for (int i = 0; i < 100; i++) {
      interval[i] = interval[i] * 100. / sum;
    }
  }
  
  private void pulsItv() {
    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        for (int j = 0; j < 10; j++) {
          interval[i * 10 + j] = 0.5;
        }
      }
      else {
        for (int j = 0; j < 10; j++) {
          interval[i * 10 + j] = 1.5;
        }
      }
    }
  }
  
  private void noiseItv() {
    /*noise generator
    output = createWriter("data/intervals.txt"); 
 
    float sum = 0.;
    float xoff = 0.;
    for (int i = 0; i < 100; i++) {
      xoff += 0.133;
      interval[i] = noise(xoff) * 2.;
      sum+=interval[i];
    }
    for (int i = 0; i < 100; i++) {
      interval[i] = interval[i] * 100. / sum;
      output.println("" + initial.interval[i]);
    }
    output.flush(); 
    output.close(); 
    */
    
    for (int i = 0; i < 100; i++) {
      interval[i] = parseFloat(elements[i]);
    }
    
  }
  
}
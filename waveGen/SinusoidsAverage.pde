class SinusoidsAverage {
  
  Sinusoid[] sinusoids;
  int total = 0;
  
  SinusoidsAverage(Sinusoid[] _sinusoids) {
    total = _sinusoids.length;
    
    sinusoids = new Sinusoid[total];
    
    for(int i = 0; i < total; i++) {
      sinusoids[i] = _sinusoids[i].clone();
    }
  }
  
  float calc(float time) {    
    float resultAdditive = 0;
    
    for(int i = 0; i < total; i++) {
      resultAdditive += sinusoids[i].calc(time);
    }
    
    float resultAverage = resultAdditive/total;
    
    return resultAverage;
  }
  
}

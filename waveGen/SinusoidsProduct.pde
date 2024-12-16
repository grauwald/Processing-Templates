class SinusoidsProduct {
  
  Sinusoid[] sinusoids;
  int total = 0;
  
  float amplitudeAverage = 0;
  
  SinusoidsProduct(Sinusoid[] _sinusoids) {
    total = _sinusoids.length;
    
    sinusoids = new Sinusoid[total];
    //arrayCopy(_sinusoids, sinusoids);
    
    for(int i = 0; i < total; i++) {
      sinusoids[i] = _sinusoids[i].clone();
      amplitudeAverage += sinusoids[i].amplitude;
      
      sinusoids[i].amplitude = 1;
    }
    
    amplitudeAverage = amplitudeAverage/total;
  }
  
  float calc(float time) {    
    float resultProduct = 1;
    
    for(int i = 0; i < total; i++) {
      resultProduct *= sinusoids[i].calc(time);
      //println
    }
    
    //float amplitudeAverage = amplitudeAdditive/total;
    resultProduct = resultProduct * amplitudeAverage;
    
    return resultProduct;
  }
}

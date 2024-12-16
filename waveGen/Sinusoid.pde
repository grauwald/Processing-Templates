


class Sinusoid {

  float frequency; // in seconds
  float amplitude = 1; // any number
  float phase = 0; // in radians

  float angleStep;

  Sinusoid(float _frequency, float _amplitude, float _phase ) {
    frequency = _frequency;
    amplitude = _amplitude;
    phase = _phase;

    calcAngleStep();
  }

  Sinusoid(float _frequency) {
    frequency = _frequency;
    
    calcAngleStep();
  }

  void calcAngleStep() {
    angleStep = TWO_PI/frequency; 
  }

  float calc(float time) {
    // time is in "time slices" or "frames"
    float angle = time*angleStep + phase;
    return sin(angle)*amplitude;
  }
  
  Sinusoid clone() {
    return new Sinusoid(frequency, amplitude, phase);
  }
}

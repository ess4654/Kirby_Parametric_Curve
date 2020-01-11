import ddf.minim.*;

Minim minim;
AudioPlayer player;

float DefaultScale = 4;
float FR = 26;
float SampleRate = 8;

boolean running = true;
boolean DEBUGGING = false;
boolean SoundOn = true;

float t = 0;
float scale = DefaultScale;
color transparent = color(0, 0, 0, 0);
color pink = color(253, 156, 194);
color darkpink = color(198, 34, 64);
color blue = color(28, 75, 213);
color red = color(232, 61, 53);
color blush = color(254, 97, 171);
color white = color(255, 255, 255);
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Integer> lineColor = new ArrayList<Integer>();
ArrayList<Integer> strokes = new ArrayList<Integer>();

void setup()
{
  fullScreen(P2D);
  //size(800, 800, P2D);
  background(0);
  noFill();
  smooth();
  frameRate(FR);
  
  minim = new Minim(this);
  player = minim.loadFile("Kirby Theme.mp3");
  if(SoundOn)
    player.loop();
}

void keyPressed() {
  if(key == ' ')
    running = !running;
  if(key == 'r')
    reset();
}

void reset()
{
  frameCount = -1;
  t = 0;
  lineColor.clear();
  strokes.clear();
  points.clear();
  minim.stop();
  minim = new Minim(this);
  if(SoundOn)
    player.loop();
  scale = DefaultScale;
}

float updateT(float T)
{
  T += 0.004;
  
  if(T >= 178.705) { //END
    strokes.add(1);
    lineColor.add(color(0, 0, 0));
    return 60 * PI;
  }
  if(T >= 176.480 && T < 178.705) { //TOUNGE
    strokes.add(2);
    lineColor.add(red);
    return T;
  }
  if(T >= 166.432 && T < 176.480) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 176.480;
  }
  if(T >= 163.798 && T < 166.432) { //RIGHT EYE INNER
    strokes.add(3);
    lineColor.add(blue);
    return T + 0.002;
  }
  if(T >= 153.539 && T < 163.798) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 163.798;
  }
  if(T >= 150.877 && T < 153.539) { //LEFT EYE INNER
    strokes.add(3);
    lineColor.add(blue);
    return T + 0.002;
  }
  if(T >= 141.256 && T < 150.877) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 150.877;
  }
  if(T >= 138.378 && T < 141.256) { //RIGHT FOOT
    strokes.add(6);
    lineColor.add(darkpink);
    return T;
  }
  if(T >= 128.646 && T < 138.378) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 138.378;
  }
  if(T >= 125.753 && T < 128.646) { //LEFT FOOT
    strokes.add(6);
    lineColor.add(darkpink);
    return T;
  }
  if(T >= 116.076 && T < 125.753) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 125.753;
  }
  if(T >= 113.238 && T < 116.076) { //RIGHT ARM
    strokes.add(6);
    lineColor.add(pink);
    return T - 0.001;
  }
  if(T >= 103.609 && T < 113.238) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 113.238;
  }
  if(T >= 100.573 && T < 103.609) { //LEFT ARM
    strokes.add(6);
    lineColor.add(pink);
    return T - 0.001;
  }
  if(T >= 94.180 && T < 100.573) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 100.573;
  }
  if(T >= 87.974 && T < 94.180) { //RIGHT CHEEK
    strokes.add(2);
    lineColor.add(blush);
    return T + 0.003;
  }
  if(T >= 81.647 && T < 87.974) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 87.974;
  }
  if(T >= 75.431 && T < 81.647) { //LEFT CHEEK
    strokes.add(2);
    lineColor.add(blush);
    return T + 0.003;
  }
  if(T >= 69.106 && T < 75.431) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 75.431;
  }
  if(T >= 62.905 && T < 69.106) { //MOUTH
    strokes.add(4);
    lineColor.add(pink);
    return T + 0.002;
  }
  if(T >= 56.534 && T < 62.905) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 62.905;
  }
  if(T >= 50.308 && T < 56.534) { //RIGHT OUTTER EYE
    strokes.add(4);
    lineColor.add(pink);
    return T;
  }
  if(T >= 43.977 && T < 50.308) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 50.308;
  }
  if(T >= 37.735 && T < 43.977) { //LEFT OUTTER EYE
    strokes.add(4);
    lineColor.add(pink);
    return T;
  }
  if(T >= 31.405 && T < 37.735) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 37.735;
  }
  if(T >= 25.198 && T < 31.405) { //RIGHT INNER EYE
    strokes.add(3);
    lineColor.add(white);
    return T + 0.004;
  }
  if(T >= 18.844 && T < 25.198) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 25.198;
  }
  if(T >= 12.679 && T < 18.844) { //LEFT INNER EYE
    strokes.add(3);
    lineColor.add(white);
    return T + 0.004;
  }
  if(T >= 6.276 && T < 12.679) { //SKIP
    strokes.add(1);
    lineColor.add(white);
    return 12.679;
  }
  else { //BODY
    strokes.add(6);
    lineColor.add(pink);
  }
  
  return T;
}

void draw()
{ 
  if(frameCount < FR) return;
  if(t <= 60 * PI && running)
  {
    for(int z = 0; z<SampleRate; z++) {
      t = updateT(t);
      points.add(new PVector(x(t), -y(t)));
      if(DEBUGGING)
        print(t + "\n");
    }
  } else {
    if(!DEBUGGING)
      scale += 0.00533;
  }
  
  translate(width/2, height/2);
  background(0);
  
  beginShape();
  for(int i = 0; i < points.size(); i++)
  {
    if(points.get(i).x == 0 && points.get(i).y == 0) continue;
    strokeWeight(strokes.get(i));
    stroke(lineColor.get(i));
    point(points.get(i).x * scale, points.get(i).y * scale);
  }
  endShape();
}

float sgn(float x)
{
  if(x == 0) return 0;
  else if(x > 0) return 1;
  else return -1;
}

float theta(float x)
{
  if(x == 0) return 0.5;
  else if(x > 0) return 1;
  else return 0;
}

float SIN(float x)
{
  return sin(x);
}

float x(float t)
{
  return ((-1.0/78*sin(23.0/15 - 16*t) - 1.0/43*sin(11.0/7 - 15*t) - 1.0/46*sin(14.0/9 - 14*t) - 1.0/24*sin(11.0/7 - 11*t) - 1.0/12*sin(11.0/7 - 9*t) - 1.0/44*sin(11.0/7 - 8*t) - 2.0/11*sin(11.0/7 - 7*t) - 1.0/4*sin(11.0/7 - 4*t) - 1.0/9*sin(17.0/11 - 3*t) - 5.0/11*sin(11.0/7 - 2*t) + 91.0/11*sin(t + 11.0/7) + 3.0/10*sin(5*t + 33.0/7) + 1.0/9*sin(6*t + 47.0/10) + 1.0/30*sin(13*t + 33.0/7) + 1.0/6)*theta(59*PI -t)*theta(t - 55*PI) + (27.0/4*sin(t + 11.0/7) + 1.0/5*sin(2*t + 8.0/5) + 1.0/4*sin(3*t + 19.0/12) + 1.0/9*sin(5*t + 11.0/7) + 1.0/30*sin(7*t + 14.0/9) + 1.0/30*sin(9*t + 19.0/12) + 27.0/2)*theta(55*PI -t)*theta(t - 51*PI) + (58.0/9*sin(t + 11.0/7) + 13.0/25*sin(2*t + 11.0/7) + 1.0/12*sin(3*t + 19.0/12) + 1.0/11*sin(4*t + 11.0/7) + 1.0/47*sin(5*t + 13.0/8) + 1.0/9*sin(6*t + 19.0/12) + 1.0/31*sin(7*t + 33.0/7) + 1.0/13*sin(8*t + 8.0/5) + 1.0/72*sin(10*t + 19.0/12) - 211.0/14)*theta(51*PI -t)*theta(t - 47*PI) + (-3.0/11*sin(11.0/7 - 12*t) - 3.0/8*sin(11.0/7 - 10*t) - 1.0/92*sin(11.0/8 - 9*t) - 4.0/5*sin(14.0/9 - 6*t) + 304.0/13*sin(t + 11.0/7) + 73.0/5*sin(2*t + 33.0/7) + 25.0/8*sin(3*t + 61.0/13) + 22.0/9*sin(4*t + 47.0/10) + 6.0/13*sin(5*t + 11.0/7) + 1.0/5*sin(7*t + 55.0/12) + 2.0/3*sin(8*t + 61.0/13) + 1.0/24*sin(11*t + 17.0/8) + 1.0/50*sin(13*t + 8.0/5) + 1.0/9*sin(14*t + 51.0/11) + 531.0/11)*theta(47*PI -t)*theta(t - 43*PI) + (-1.0/13*sin(23.0/15 - 13*t) - 1.0/9*sin(20.0/13 - 11*t) - 1.0/5*sin(11.0/7 - 7*t) - 50.0/17*sin(14.0/9 - 3*t) + 313.0/13*sin(t + 11.0/7) + 117.0/8*sin(2*t + 11.0/7) + 13.0/5*sin(4*t + 11.0/7) + 5.0/12*sin(5*t + 8.0/5) + 7.0/6*sin(6*t + 11.0/7) + 7.0/10*sin(8*t + 8.0/5) + 1.0/22*sin(9*t + 12.0/7) + 2.0/7*sin(10*t + 14.0/9) + 4.0/13*sin(12*t + 8.0/5) + 1.0/6*sin(14*t + 19.0/12) + 1.0/96*sin(15*t + 14.0/3) - 341.0/7)*theta(43*PI -t)*theta(t - 39*PI) + (-1.0/10*sin(14.0/9 - 14*t) - 1.0/43*sin(10.0/7 - 13*t) - 2.0/11*sin(17.0/11 - 12*t) - 1.0/5*sin(17.0/11 - 10*t) - 5.0/12*sin(20.0/13 - 8*t) - 1.0/33*sin(5.0/6 - 7*t) - 12.0/13*sin(17.0/11 - 6*t) - 18.0/11*sin(14.0/9 - 4*t) - 3.0/5*sin(20.0/13 - 3*t) - 97.0/10*sin(11.0/7 - 2*t) - 24.0/13*sin(11.0/7 -t) + 1.0/9*sin(5*t + 9.0/7) + 1.0/17*sin(11*t + 23.0/15) + 342.0/5)*theta(39*PI -t)*theta(t - 35*PI) + (-1.0/12*sin(20.0/13 - 21*t) - 1.0/10*sin(14.0/9 - 19*t) - 1.0/33*sin(3.0/2 - 17*t) - 1.0/6*sin(14.0/9 - 7*t) - 2.0/13*sin(17.0/11 - 5*t) + 137.0/12*sin(t + 11.0/7) + 102.0/13*sin(2*t + 11.0/7) + 5.0/12*sin(3*t + 14.0/9) + 9.0/17*sin(4*t + 14.0/9) + 5.0/11*sin(6*t + 19.0/12) + 3.0/10*sin(8*t + 19.0/12) + 1.0/16*sin(9*t + 5.0/3) + 1.0/4*sin(10*t + 8.0/5) + 1.0/47*sin(11*t + 47.0/10) + 1.0/12*sin(12*t + 17.0/11) + 1.0/41*sin(13*t + 27.0/16) + 1.0/19*sin(14*t + 8.0/5) + 1.0/20*sin(16*t + 17.0/11) + 1.0/14*sin(18*t + 8.0/5) + 1.0/10*sin(20*t + 13.0/8) + 1.0/25*sin(22*t + 14.0/9) - 701.0/12)*theta(35*PI -t)*theta(t - 31*PI) + (123.0/16*sin(t + 10.0/7) + 596.0/17)*theta(31*PI -t)*theta(t - 27*PI) + (31.0/4*sin(t + 11.0/7) - 461.0/13)*theta(27*PI -t)*theta(t - 23*PI) + (125.0/14*sin(t + 2) + 9.0/17*sin(2*t + 41.0/10) - 2.0/11)*theta(23*PI -t)*theta(t - 19*PI) + (142.0/19*sin(t + 1.0/9) + 148.0/11)*theta(19*PI -t)*theta(t - 15*PI) + (135.0/17*sin(t + 1.0/8) - 102.0/7)*theta(15*PI -t)*theta(t - 11*PI) + (21.0/4*sin(t + 1.0/6) + 51.0/4)*theta(11*PI -t)*theta(t - 7*PI) + (67.0/13*sin(t + 2.0/7) - 83.0/6)*theta(7*PI -t)*theta(t - 3*PI) + (-1.0/4*sin(1.0/11 - 2*t) - 931.0/15*sin(1.0/11 -t) - 5.0/8)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}

float y(float t)
{
  return ((-1.0/22*sin(11.0/7 - 16*t) - 3.0/10*sin(11.0/7 - 6*t) - 8.0/9*sin(11.0/7 - 4*t) - 19.0/8*sin(11.0/7 - 2*t) - 11.0/17*sin(11.0/7 -t) + 1.0/10*sin(3*t + 47.0/10) + 1.0/25*sin(5*t + 19.0/12) + 1.0/7*sin(8*t + 33.0/7) + 1.0/16*sin(9*t + 11.0/7) + 1.0/13*sin(10*t + 33.0/7) + 1.0/41*sin(11*t + 11.0/7) + 1.0/19*sin(12*t + 33.0/7) + 1.0/20*sin(14*t + 33.0/7) + 19.0/8)*theta(59*PI -t)*theta(t - 55*PI) + (5.0/8*sin(t + 33.0/7) + 27.0/11*sin(2*t + 11.0/7) + 1.0/57*sin(3*t + 67.0/15) + 5.0/11*sin(4*t + 19.0/12) + 1.0/27*sin(5*t + 5.0/3) + 2.0/9*sin(6*t + 11.0/7) + 1.0/7*sin(8*t + 11.0/7) + 1.0/17*sin(10*t + 19.0/12) + 385.0/16)*theta(55*PI -t)*theta(t - 51*PI) + (-21.0/16*sin(11.0/7 -t) + 52.0/21*sin(2*t + 11.0/7) + 1.0/77*sin(3*t + 59.0/13) + 5.0/9*sin(4*t + 11.0/7) + 1.0/15*sin(5*t + 21.0/13) + 1.0/5*sin(6*t + 11.0/7) + 1.0/10*sin(7*t + 47.0/10) + 1.0/7*sin(8*t + 11.0/7) + 1.0/34*sin(9*t + 5.0/3) + 1.0/13*sin(10*t + 19.0/12) + 271.0/11)*theta(51*PI -t)*theta(t - 47*PI) + (-1.0/10*sin(3.0/2 - 9*t) - 5.0/9*sin(11.0/7 - 5*t) - 1.0/4*sin(3.0/2 - 3*t) + 225.0/16*sin(t + 11.0/7) + 67.0/5*sin(2*t + 11.0/7) + 5.0/7*sin(4*t + 8.0/5) + 13.0/12*sin(6*t + 11.0/7) + 1.0/70*sin(7*t + 1.0/7) + 10.0/21*sin(8*t + 11.0/7) + 1.0/5*sin(10*t + 14.0/9) + 1.0/10*sin(11*t + 19.0/13) + 2.0/9*sin(12*t + 14.0/9) + 1.0/18*sin(13*t + 16.0/11) + 3.0/14*sin(14*t + 14.0/9) - 612.0/11)*theta(47*PI -t)*theta(t - 43*PI) + (-2.0/9*sin(17.0/11 - 7*t) - 74.0/5*sin(11.0/7 -t) + 209.0/15*sin(2*t + 11.0/7) + 2.0/7*sin(3*t + 8.0/5) + 7.0/12*sin(4*t + 17.0/11) + 4.0/9*sin(5*t + 8.0/5) + 5.0/7*sin(6*t + 11.0/7) + 4.0/11*sin(8*t + 11.0/7) + 1.0/5*sin(9*t + 21.0/13) + 1.0/3*sin(10*t + 19.0/12) + 1.0/13*sin(11*t + 11.0/7) + 1.0/4*sin(12*t + 19.0/12) + 1.0/8*sin(13*t + 8.0/5) + 1.0/7*sin(14*t + 8.0/5) + 1.0/18*sin(15*t + 17.0/11) - 390.0/7)*theta(43*PI -t)*theta(t - 39*PI) + (-227.0/10*sin(11.0/7 -t) + 13.0/7*sin(2*t + 11.0/7) + 1.0/11*sin(3*t + 3.0/2) + 7.0/9*sin(4*t + 11.0/7) + 1.0/6*sin(5*t + 8.0/5) + 2.0/5*sin(6*t + 19.0/12) + 1.0/5*sin(7*t + 8.0/5) + 2.0/7*sin(8*t + 8.0/5) + 1.0/35*sin(9*t + 39.0/20) + 1.0/7*sin(10*t + 23.0/14) + 1.0/8*sin(12*t + 13.0/8) + 1.0/8*sin(14*t + 8.0/5) - 47.0/11)*theta(39*PI -t)*theta(t - 35*PI) + (-1.0/25*sin(3.0/2 - 23*t) - 1.0/13*sin(14.0/9 - 22*t) - 1.0/21*sin(26.0/17 - 21*t) - 1.0/16*sin(14.0/9 - 18*t) - 1.0/36*sin(19.0/13 - 17*t) - 1.0/8*sin(14.0/9 - 16*t) - 1.0/25*sin(17.0/11 - 15*t) - 1.0/6*sin(11.0/7 - 14*t) - 1.0/6*sin(14.0/9 - 12*t) - 3.0/11*sin(14.0/9 - 10*t) - 1.0/52*sin(19.0/13 - 9*t) - 5.0/16*sin(14.0/9 - 8*t) - 5.0/7*sin(11.0/7 - 6*t) - 22.0/9*sin(11.0/7 - 4*t) - 8.0/5*sin(11.0/7 - 3*t) - 67.0/8*sin(11.0/7 - 2*t) + 254.0/13*sin(t + 11.0/7) + 1.0/4*sin(5*t + 14.0/3) + 1.0/9*sin(7*t + 14.0/9) + 1.0/57*sin(11*t + 11.0/9) + 1.0/42*sin(19*t + 47.0/10) + 1.0/20*sin(20*t + 61.0/13) + 466.0/9)*theta(35*PI -t)*theta(t - 31*PI) + (5*sin(t + 11.0/4) + 129.0/10)*theta(31*PI -t)*theta(t - 27*PI) + (58.0/11*sin(t + 19.0/6) + 133.0/10)*theta(27*PI -t)*theta(t - 23*PI) + (95.0/12*sin(t + 25.0/7) + 5.0/9*sin(2*t + 29.0/14) + 17.0/9)*theta(23*PI -t)*theta(t - 19*PI) + (332.0/11 - 178.0/11*sin(13.0/9 -t))*theta(19*PI -t)*theta(t - 15*PI) + (272.0/9 - 122.0/7*sin(23.0/17 -t))*theta(15*PI -t)*theta(t - 11*PI) + (513.0/13 - 39.0/5*sin(13.0/10 -t))*theta(11*PI -t)*theta(t - 7*PI) + (317.0/8 - 68.0/9*sin(11.0/8 -t))*theta(7*PI -t)*theta(t - 3*PI) + (799.0/13*sin(t + 37.0/8) + 3.0/4*sin(2*t + 59.0/29) + 29.0/4)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}

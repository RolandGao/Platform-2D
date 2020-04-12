class FBomb extends FBox{
  float r;
  int frame = 100;
  int mode;
  
  FBomb(float x, float y){
    super(gridSize*2, gridSize*2);
    setPosition(x,y);
    setFillColor(pink);
    setName("bomb");
    mode = 0;
    r = 10;
  }
  int getMode(){return mode;}
  
  void mainn(){
    if (mode == 0)
      coutdown();
    else if (mode == 1)
      kaboom();
    else if (mode == 2)
      afterMath();
  }
  void coutdown(){
    frame--;
    if (frame == 0)
      mode = 1;
  }
  
  void kaboom(){
    setStatic(true);
    for (FBody b : boxes){
      if (dist(b.getX(), b.getY(),getX(),getY()) < 50)
        world.remove(b);
    }
    mode = 2;
    setDrawable(false);
  }
  void afterMath(){
    ellipse(getX(),getY(),r,r);
    r += 5;
    if (r >= 100){
      r = 10;
      mode = 3;
    }
  }
}

void removeBomb(){
  Iterator<FBomb> itr = bombs.iterator();
  while(itr.hasNext()){
    if (itr.next().getMode() == 3)
      itr.remove();
  }
}

class FLava extends FBox {
  int lavaCN;
  int delay;

  FLava(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setFillColor(pink);
    setName("lava");
    setStatic(true);
    lavaCN = 0;
    delay = (int) random(50);
    attachImage(lava[lavaCN]);
  }

  void animateLava() {
    delay--;
    if (delay <= 0) {
      attachImage(lava[lavaCN]);
      if (frameCount % 3 == 0)
        lavaCN++;
      if (lavaCN == 6) {
        lavaCN = 0;
        attachImage(lava[0]);
        delay = (int) random(500);
      }
    }
  }
}
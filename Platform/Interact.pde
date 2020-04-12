void move() {
  int v;
  float vx = 0, vy = player.getVelocityY();

  if (touch("waterBody") || touch("waterSurface")) 
    v = 200;
  else
    v = 400;
  if (a)
    vx -= v;
  if (d)
    vx += v;
  if (touch("waterBody") || touch("waterSurface")) {
    vy = 0;
    if (w)
      vy -= v;
    if (s)
      vy += v;
  } else if (touch("ground")|| touch("bomb") || touch("crate") || touch("wall") || player.isTouchingBody(world.bottom)) {
    if (w)
      vy = -300;
  }
  player.setVelocity(vx, vy);
}

boolean touch(String s) {
  ArrayList<FContact> contacts = player.getContacts();
  boolean bool = false;
  for (FContact c : contacts) {
    if (c.contains(s))
      bool = true;
  }
  return bool;
}

void attacked() {
  if (immune <=0) {
    health--;
    immune = 30;
  }
}
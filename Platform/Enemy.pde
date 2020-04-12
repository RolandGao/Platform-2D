class Goomba extends FBox {
  int velocity;
  int mode;

  Goomba(float x, float y) {
    super(gridSize*2, gridSize*2);
    setPosition(x, y);
    setFillColor(green);
    setName("goomba");
    velocity = (int) random(50, 200);
    setFriction(0);
    setDamping(0);
    setVelocity(velocity, 0);
    setRestitution(1);
    mode = 0;
    world.add(this);
  }

  void move() {
    setVelocity(velocity, 0);
    if (touch("wall") || touch("player")) {
      velocity *= -1;
      setVelocity(velocity, 0);
    }
  }

  void contact() {
    if (touch("player")) {
      if (player.getVelocityY() > 20)
        mode = 1;
      else 
      attacked();
    }
  }
  void die() {
    world.remove(this);
  }
  int getMode() {
    return mode;
  }

  boolean touch(String s) {
    ArrayList<FContact> contacts = getContacts();
    boolean bool = false;
    for (FContact c : contacts) {
      if (c.contains(s))
        bool = true;
    }
    return bool;
  }
}

class HammerBro extends Goomba {
  int delay;
  HammerBro(float x, float y) {
    super(x, y);
    setFillColor(darkGreen);
    setName("hammer");
    delay = 20;
  }
  void attack() {
    if (abs(getX() - player.getX()) < 300 && player.getY() > getY()) {
      delay--;
      if (delay <= 0) {
        delay = 20;
        FCircle c = new FCircle(20);
        float dx = player.getX() - getX();
        float dy = getY()-player.getY();
        float t = sqrt(abs(2*dy/500));
        float vx = dx/t;
        c.setPosition(getX(), getY());
        c.setVelocity(vx, 0);
        c.setSensor(true);
        c.setName("bullet");
        c.setDamping(0);
        world.add(c);
        bullets.add(c);
      }
    }
  }
}

class Thwomp extends FBox {
  float x, y;
  int mode = 0;
  Thwomp(float xx, float yy) {
    super(5*gridSize, 5*gridSize);
    x = xx;
    y = yy;
    setPosition(x, y);
    setFillColor(orange);
    setName("thwomp");
    setFriction(0);
    setDamping(0);
    setRestitution(0);
    setStatic(true);
    world.add(this);
  }
  void attack() {
    int range = 60;
    if (mode == 0) {
      setStatic(true);
      if (abs(getX()-player.getX()) < range && player.getY() > getY()) {
        setStatic(false);
        setVelocity(0, 400);
        mode = 1;
      }
    } else if (mode == 1) {
      ArrayList<FContact> contacts = getContacts();
      if (contacts.size() >= 1) {
        mode = 2;
      }
    } else if (mode == 2) {
      setVelocity(0, -100);
      if (getY() <= y)
        mode = 0;
    }
  }
  void contact() {
    if (isTouchingBody(player)) {
      attacked();
    }
  }
}
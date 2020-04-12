void updateEnemies() {
  for (FBody b : enemies) {
    if (b.getName() == "goomba") {
      Goomba g = (Goomba) b;
      if (g.getMode() == 0) {
        g.move();
        g.contact();
      } else if (g.getMode() == 1) {
         world.remove(b);
      }
    } else if (b.getName() == "hammer") {
      HammerBro h = (HammerBro) b;
      if (h.getMode() == 0) {
        h.attack();
        h.move();
        h.contact();
      }
      else if (h.getMode() == 1) {
         world.remove(h);
      }
    }
    else if (b.getName() == "thwomp"){
      Thwomp t = (Thwomp) b;
      t.attack();
      t.contact();
    }
  }
  for (int i = 0; i < bullets.size(); i++){
    FBody b = bullets.get(i);
    if (b.isTouchingBody(player)){
      attacked();
      world.remove(b);
      bullets.remove(b);
    }
    else if (b.getVelocityY() > 1000){
      world.remove(b);
      bullets.remove(b);
    }
  }
  
}
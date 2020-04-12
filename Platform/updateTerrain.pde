void updateTerrain(){
  for (FBody b: boxes){
    if (b.getName() == "frail"){
      if (b.isTouchingBody(player)){
        b.setName("crate");
        b.setStatic(false);
      }
    }
    else if (b.getName() == "jump"){
      if (b.isTouchingBody(player)){
        player.setVelocity(player.getVelocityX(), -600);
      }
    }
    else if (b.getName() == "lava"){
      ((FLava)b).animateLava();
      if (b.isTouchingBody(player)){
        attacked();
      }
    }
    else if (b.getName() == "waterSurface"){
      if (waterCN >= 4)
        waterCN = 0;
      b.attachImage(water[waterCN]);
    }
    else if (b.getName() == "teleport1"){
      if (b.isTouchingBody(player)){
        player.setPosition(140,950);
      }
    }
    else if (b.getName() == "teleport2"){
      if (b.isTouchingBody(player)){
        player.setPosition(2880,350);
      }
    }
    else if (b.getName() == "waterBody"){
      
    }
  }
}

void getCurrentAction(){
  if (player.getVelocityY() < -20)
    currentAction = jumpUp;
  else if (player.getVelocityY() > 20)
    currentAction = jumpDown;
  else if (a)
    currentAction = run;
  else if (d)
    currentAction = run;
  else
    currentAction = idle;
}//0 idle, 1 runleft, 2 runright, 3 jump up, 4 jump down

void animatePlayer(){
  if (playerCN >= currentAction.length)
    playerCN = 0;
  player.attachImage(currentAction[playerCN]);
  if (frameCount % 5 == 0)
    playerCN++;
}
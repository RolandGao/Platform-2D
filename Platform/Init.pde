void initialize(){
  final int x = 300;
  final int y = 200;
  color [][] c = new color[x][y];
  for (int i = 0; i < x; i++){
    for (int j = 0; j < y; j++){
      c[i][j] = map.get(i,j);
      if (c[i][j] != white){
        if (c[i][j] == black)
          boxes.add(makeBox("ground",c[i][j],i,j));
        else if (c[i][j] == red){
          FLava l = new FLava(i*gridSize, j*gridSize);
          world.add(l);
          boxes.add(l);
        }
        else if (c[i][j] == pink)
          boxes.add(makeBox("jump",c[i][j],i,j));
        else if (c[i][j] == lightBlue){
          FBox b = makeBox("waterSurface",c[i][j],i,j);
          b.setSensor(true);
          boxes.add(b);
        }
        else if (c[i][j] == teleport1){
          FBox b = makeBox("teleport1",c[i][j],i,j);
          b.setSensor(true);
          boxes.add(b);
        }
        else if (c[i][j] == teleport2){
          FBox b = makeBox("teleport2",c[i][j],i,j);
          b.setSensor(true);
          boxes.add(b);
        }
        else if (c[i][j] == darkBlue){
          FBox b = makeBox("waterBody",c[i][j],i,j);
          b.setSensor(true);
        }
        else if (c[i][j] == brown)
          boxes.add(makeBox("frail",c[i][j],i,j));
        else if (c[i][j] == green){
          Goomba g  = new Goomba(i*gridSize, j*gridSize);
          enemies.add(g);
        }
        else if (c[i][j] == grey){
          makeBox("wall",c[i][j],i,j);
        }
        else if (c[i][j] == orange){
          Thwomp t = new Thwomp(i*gridSize, j*gridSize);
          enemies.add(t);
        }
        else if (c[i][j] == darkGreen){
          HammerBro h = new HammerBro(i*gridSize, j*gridSize);
         enemies.add(h);
        }
      }
    }
  }
}

FBox makeBox(String s, color c, int x, int y){
  FBox b = new FBox(gridSize,gridSize);
  b.setPosition(x*gridSize,y*gridSize);
  b.setStatic(true);
  b.setFillColor(c);
  b.setNoStroke();
  b.setName(s);
  b.setFriction(0);
  world.add(b);
  return b;
}

void initPlayer(){
  player = new FBox(gridSize*2, gridSize*2);
  player.setPosition(100,20);
  player.setFillColor(lightBlue);
  player.attachImage(idle[0]);
  player.setRotatable(false);
  player.setName("player");
  world.add(player);
}

void initImage(){
  idle[0] = loadImage("megaman0.png");
  idle[1] = loadImage("megaman1.png");
  run[0] = loadImage("megaman2.png");
  run[1] = loadImage("megaman3.png");
  run[2] = loadImage("megaman4.png");
  run[3] = loadImage("megaman5.png");
  jumpUp[0] = loadImage("megaman6.png");
  jumpDown[0] = loadImage("megaman7.png");
  water[0] = loadImage("water1.png");
  water[1] = loadImage("water2.png");
  water[2] = loadImage("water3.png");
  water[3] = loadImage("water4.png");
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");
  for (PImage p : water){
    p.resize(gridSize,gridSize);
  }
  for (PImage p : lava){
    p.resize(gridSize,gridSize);
  }
}
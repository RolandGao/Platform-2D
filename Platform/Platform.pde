import fisica.*;
import java.util.Iterator;
FWorld world;

PImage map;
ArrayList<FBody> boxes = new ArrayList<FBody>();
ArrayList<FBomb> bombs = new ArrayList<FBomb>();
ArrayList<FBody> enemies = new ArrayList<FBody>();
ArrayList<FBody> bullets = new ArrayList<FBody>();
FBox player;
color lightBlue = #99D9EA;
color darkBlue = #00A2E8;
color red = #ED1C24;
color black = #000000;
color white = #FFFFFF;
color pink = #FFAEC9;
color brown = color(185,122,87);
color teleport1 = color(200,191,231);
color teleport2 = color(163,73,164);
color green = color(181,230,29);
color darkGreen = color(34,177,76);
color grey = color(30,30,30);//wall
color orange = color(255,127,39);
int health = 3;
int immune = 30;
boolean a, w, s, d;
final int gridSize = 10;

PImage [] run = new PImage[4];
PImage [] idle = new PImage[2];
PImage [] jumpUp = new PImage[1];
PImage [] jumpDown = new PImage[1];
PImage [] currentAction;
PImage [] water = new PImage[4];
PImage [] lava = new PImage[6];
int playerCN = 0, waterCN = 0;


void setup() {
  size(600, 400);
  Fisica.init(this);
  world = new FWorld(-10000,-10000,10000,10000);
  world.setGravity(0, 500);
  world.setEdges(0,0,3000,2000);
  world.setGrabbable(true);
  map = loadImage("map.png");
  initialize();
  initPlayer();
  stroke(0);
  strokeWeight(3);
  noFill();
  
  initImage();
}

void draw() {
 // println(health);
 //println(bullets.size());
  //println(player.getVelocityY());
  println(player.getX() + "   " + player.getY());
  background(230);
  immune--;
  move();
  updateTerrain();
  updateEnemies();
  if (frameCount % 20 == 0)
    waterCN++;
  pushMatrix();
  translate(-player.getX() + width/2, -player.getY() + height/2);
  world.step();
  world.draw();

  for (FBomb b : bombs) {
    b.mainn();
    if (b.getMode() == 3)
      world.remove(b);
  }
  removeBomb();
  popMatrix();
  getCurrentAction();
  animatePlayer();
}  

void keyPressed() {
  if (key == 'W' || key == 'w')
    w = true;
  if (key == 'A' || key == 'a')
    a = true;
  if (key == 'S' || key == 's')
    s = true;
  if (key == 'D' || key == 'd')
    d = true;
  if (key == 'B' || key == 'b') {
    FBomb b = new FBomb(player.getX(), player.getY());
    world.add(b);
    bombs.add(b);
  }
}

void keyReleased() {
  if (key == 'W' || key == 'w')
    w = false;
  if (key == 'A' || key == 'a')
    a = false;
  if (key == 'S' || key == 's')
    s = false;
  if (key == 'D' || key == 'd')
    d = false;
}
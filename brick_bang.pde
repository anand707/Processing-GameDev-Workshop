PImage img;
int playerXCor = 600;
int playerYCor = 590;
int playerWidth = 55;
int playerHeight = 55;
int difficulty = 10;
int limit = 10;
float score = 0;
Baddie[] baddies;
boolean isCollided = false;


void initBaddies(int xMin, int xMax, int yMin, int yMax, int num){
  baddies = new Baddie[num];
 
  for(int i = 0; i < baddies.length; i++){
     int x = (int)random(xMin, xMax);
     int y = (int)random(yMin, yMax);
     baddies[i] = new Baddie(x, y, 30, 15);
  }
}
// In a program that has the setup() function, the size()/fullscreen() function must be the first line of code inside setup(), and the setup() function must appear in the code tab with the same name as your sketch folder.
void setup(){
  //fullScreen();
  size(1280,720);
  //rameRate(60);
  img = loadImage("bg.png");
  initBaddies(-100, width + 20, -250, -80, difficulty);

  
}

void draw(){
  
  image(img,0,0); // Using instead of background();
  drawPlayer();
  
  if(!isCollided){
    moveBaddies();
    if(score > limit && score < limit + 2){
      initBaddies(-100, width + 20, -260, -80, difficulty); difficulty += 10; limit += 20;
    }
  }
 else{
   text("Score: "+(int)score,100, 100);
 }

  
}

void moveBaddies(){
      for(int i = 0; i < baddies.length; i++){
        if(baddies[i].yCor > height){
           baddies[i].yCor = -10;
        }
        baddies[i].display();
        baddies[i].drop(random(1, 15));
      
        boolean conditionXLeft = baddies[i].xCor + baddies[i].w >= playerXCor;
        boolean conditionXRight = baddies[i].xCor + baddies[i].w <= playerXCor + playerWidth + 4;
        boolean conditionUp =  baddies[i].yCor >= playerYCor;
        boolean conditionDown = baddies[i].yCor + baddies[i].h <= playerYCor + playerHeight;
      
        if(conditionXLeft && conditionXRight && conditionUp && conditionDown){
             isCollided = true;
        }
  
      }
     
 
    score += 0.1;

    fill(0, 102, 153);
    text("Score: "+(int)score, 10, 40);
    textSize(25);
}



void drawPlayer(){
  stroke(204, 132, 0);
  strokeWeight(4);
  fill(204, 102, 0);
  rect(playerXCor, playerYCor, playerWidth, playerHeight, 7);
}




void mouseDragged(){
  if(mouseX >= 0 && mouseX <= width - playerWidth + 1){
    playerXCor = mouseX;
  }
  if(mouseY >= 590 && mouseY <= height - playerHeight){
    playerYCor = mouseY;
  }
 
}

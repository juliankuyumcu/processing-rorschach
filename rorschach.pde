//Concept:
//A morphing symmetrical Rorschach test (100 ink blots)

//Instructions:
//Run the program to see morphing, abstract ink blots and exercise your mind's eye!

//Sources:
//Rorschach generator: https://www.openprocessing.org/sketch/4675/
//Transparent ink blot (original created image): https://i.imgur.com/FZwt0fs.png

float[][] blots = new float[50][4]; //2D array that stores 50 ink blots (pre-reflection), along with their x, y coordinates and velocities
PImage inkBlot = loadImage("https://i.imgur.com/FZwt0fs.png", "png"); //Retrieves the ink blot image from the web
int radius = inkBlot.width / 2; //Calculates and stores the radius of the ink blot
float threshold = 0.0; //Variable for the black/white filter threshold
float theta = 0.0; //Variable for the input radians of the threshold function

void setup() {
  size(800, 800, JAVA2D); //Sets the size of the output screen as 800x800 pixels, JAVA2D render method to save memory
  //Iterates through each ink blot
  for (float[] blot : blots) {
    blot[0] = random(radius, width / 2); //Sets a random visible x-coordinate
    blot[1] = random(radius, height - radius); //Sets a random visible y-coordinate
    blot[2] = random(-1, 1); //Sets a random x velocity
    blot[3] = random(-1, 1); //Sets a random y velocity
  }
}

void draw() {
  background(255); //Sets the background to be white
  
  //Iterates through each ink blot
  for (float[] blot : blots) {
    blot[0] += blot[2]; //Adds x velocity to x-coordinate
    blot[1] += blot[3]; //Adds y velocity to y-coordinate
    
    //Checks if the blot hits the left or right side of the screen
    if (blot[0] < radius || blot[0] > width / 2)
      //Checks if the x velocity is negative or positive
      if (blot[2] < 0)
        blot[2] = cos(random(0, PI / 2)); //Horizontally ricochets blot at random positive velocity
      else
        blot[2] = -cos(random(0, PI / 2)); //Horizontally ricochets blot at random negative velocity

    //Checks if the blot hits the top or bottom of the screen
    if (blot[1] < radius || blot[1] > height - radius)
      //Checks if the y velocity is negative or positive
      if (blot[3] < 0) 
        blot[3] = sin(random(0, PI / 2)); //Vertically ricochets blot at random positive velocity
      else
        blot[3] = -sin(random(0, PI / 2)); //Vertically richochets blot at random negative velocity

    image(inkBlot, blot[0] - radius, blot[1] - radius); //Draws blot centred at x, y coordinates
    image(inkBlot, width - blot[0] - radius, blot[1] - radius); //Draws blot centred on opposite x-coordinate for symmetrical reflection
  }
  
  //Applies a black/white filter to the screen with a sine function as the threshold
  //The sine function varies from 0 to 0.64 to allow blots to oscillate in and out
  threshold = (0.32 * sin(theta) + 0.32);
  filter(THRESHOLD, threshold);
  
  theta += 0.035; //Increases radian input by 0.035
  //Checks if radian input exceeds 2 * PI (period of sine function)
  if (theta > 2 * PI)
    theta = 0; //Resets radians to 0
}

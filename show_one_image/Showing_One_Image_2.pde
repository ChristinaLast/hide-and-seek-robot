//For Story
// basic setup
final int COLOR_MAX = 255;
final char DELIMITER = '\n'; // delimiter for words
 
// text setup
final int WORDS_PER_LINE = 5;
final int MAX_TEXT_SIZE = 40;
final int MIN_TEXT_SIZE = 0;

// where to draw the top of the text block
float textYOffset = 500+MAX_TEXT_SIZE; // 500 must match setup canvas size 
// start PAST the bottom of the screen so that the
// text comes in instead of just appearing
 
final float TEXT_SPEED = 0.2; // try changing this to experiment
 
// story to tell!
final String STORY_TEXT = 
"A long time ago, in a galaxy far, far "+DELIMITER+
"away... aliens from Earth have lashed"+DELIMITER+
"out against robo-cop. Alien spies,"+DELIMITER+
"striking from an unknown location, attempt to"+DELIMITER+
"steal secret plans to the Robo-Cop\'s " +DELIMITER+
"ultimate weapon, the DEATH STAR, an "+DELIMITER+
"armored space station with enough" +DELIMITER+
" power to destroy planet Earth. " +DELIMITER+
"Pursued by Robo-cop, the alien spies" +DELIMITER+
" from Earth attempt to sneak past" +DELIMITER+
"Robo-Cop and steal the plans," +DELIMITER+
" and destroy planet Earth. "+DELIMITER+
" "+DELIMITER+
" "+DELIMITER+
"Can Robo-Cop successfully catch these "+DELIMITER+
"aliens and restore freedom to the planet Earth..." +DELIMITER+
" "+DELIMITER+
" "+DELIMITER+
"You are an alien spy from earth, "+DELIMITER+
"attempting to steal the plans "+DELIMITER+
"of the DEATH STAR. You have to "+DELIMITER+
"successfully reach Robo-Cop\'s base "+DELIMITER+
"before Robo-Cop catches you. You can"+DELIMITER+
"take one step each time, and must "+DELIMITER+
"wait for Robo-Cop\'s move until you"+DELIMITER+
"make your next move. Robo-Cop will "+DELIMITER+
"win if it catches you before you have"+DELIMITER+
"successfully stolen the plans.";

String[] storyLines;

//title setup
final int MAX_TITLE_SIZE = 80;
final int MIN_TITLE_SIZE = 0;
 
final String TITLE_TEXT = 
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
""+DELIMITER+
"ROBO-COP Plays Hide-and-Seek";

//For Stars
Star[] stars = new Star[1000];
float starSpeed;

//Loading image for pan
PImage loaded_image;
String path_image;
String image_path;

int image_amount;
boolean image_added = false;
int image_index = 0;

float timer_image = 0; //give a little bit time for image to be fully sent
float startTime_image; 

//Loading face for pan
PImage loaded_face;
String path_face;
String face_path;

int face_amount;
boolean face_added = false;
int face_index = 0;

float timer_face = 0; //give a little bit time for image to be fully sent
float startTime_face; 

//Button to view images
boolean showButton1 = false;
boolean showButton2 = false;

void setup() {
  //size(1280, 720, P3D);
  size(1920, 1080, P3D);
  //fullScreen(P3D);
  //Story Setuo
  textYOffset = height;
  //storyLines = splitToLines(STORY_TEXT, WORDS_PER_LINE, DELIMITER);
  textAlign(CENTER,CENTER);
 
  //Stars Setup
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(); 
  }
  
  //Image Pan setup
  //image_path = "E:/UCSB Spring 2018/ART 185GL/Design/Showing_One_Image/Showing_One_Image/data";
  //image_path = "Desktop/Showing_One_Image_2/data/images";
  image_path = "/Volumes/pi/final_project/images";
  image_amount = listFileNames(image_path).length;
  
  //face_path = "Desktop/Showing_One_Image_2/data/face";
  face_path = "/Volumes/pi/final_project/faceimages";
  face_amount = listFileNames(face_path).length;
}

void drawImages() {
String[] image_filenames = listFileNames(image_path);
  if(image_filenames.length > image_amount && !image_added){
    image_amount = image_filenames.length;
    startTime_image = millis();
    image_added = true;
  }
  //print(image_index);
  
  timer_image = millis() - startTime_image;
  
  //timer is essential here, otherwise the image cannot be loaded correctly 
  if(image_added && timer_image > 500){
      String[] filenames = listFileNames(image_path);
      //println(filenames);
      loaded_image = loadImage(image_path + "/" + image_index + ".jpg");
      image_added = false;
      image_index += 1;
  }
  
  timer_image = 0;
  
  if(loaded_image != null) image(loaded_image, 0, 0);
}

void drawStars() { 
  starSpeed = map(mouseX, 0, width, 0, 20);
  background(0);
  translate(width/2, height/2);

  for (int i = 0; i < stars.length; i++) {
    stars[i].update(); 
    stars[i].show();
  }
}

void drawInstructions(){
  rotateX(PI/3);
  fill(250,204,0);
  textSize(MAX_TEXT_SIZE+MIN_TEXT_SIZE);
  text(STORY_TEXT,0,textYOffset);
  //drawTextBlock(storyLines, textYOffset, MIN_TEXT_SIZE, MAX_TEXT_SIZE);
  // make the text slowly crawl up the screen
  // it has to slow down as it goes so that the big text looks
  // relatively to be the same speed
  textYOffset -= TEXT_SPEED;
}

void drawTitle() {
  fill(250,204,0);
  textSize(MAX_TITLE_SIZE+MIN_TITLE_SIZE);
  text(TITLE_TEXT,0,textYOffset);
  //drawTextBlock(storyLines, textYOffset, MIN_TEXT_SIZE, MAX_TEXT_SIZE);
  // make the text slowly crawl up the screen
  // it has to slow down as it goes so that the big text looks
  // relatively to be the same speed
  textYOffset -= TEXT_SPEED;
}

void drawFaces() {
String[] face_filenames = listFileNames(face_path);
  if(face_filenames.length > face_amount && !face_added){
    face_amount = face_filenames.length;
    startTime_face = millis();
    face_added = true;
  }
  
  timer_face = millis() - startTime_face;
  
  //timer is essential here, otherwise the image cannot be loaded correctly 
  if(face_added && timer_face > 500){
      String[] filenames = listFileNames(face_path);
      //println(filenames);
      loaded_face = loadImage(face_path + "/" + face_index + ".jpg");
      face_added = false;
      face_index += 1;
  }
  
  timer_face = 0;
  
  if(loaded_face != null) image(loaded_face, 0, 0);
}

void keyPressed() {
  if (key == '0') {
    //button 1 was just clicked, show button 2 instead
    showButton1 = false;
    showButton2 = false;
  }if ( key == '1') {
    //button 2 was just clicked, show button 1 instead
    showButton1 = true; 
    image_index = 0;
  } if (key == '2') {
    showButton2 = true;
    //print("hi");
    face_index =0;
  }
  if(key == 'r'){
    setup();
    showButton1 = false;
    showButton2 = false;
  }
}


void draw(){
  if (showButton1 == false){
    drawStars();
    drawInstructions();
    drawTitle();
  }
  if (showButton1 == true){
    drawImages();
  }
  if (showButton2 == true){
    drawFaces();
    //print("hi2");
  }
}
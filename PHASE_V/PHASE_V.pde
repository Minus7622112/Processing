import ddf.minim.*;

Minim minim;
AudioPlayer player;
float airspeed = 0;      //Declaramos todas las variables que vamos a utilizar
float avion;
float avionhb;
float subspeed = 0;
float sub;
float subhb; 
PImage imgav;
PImage imgsub;
PImage imgexpl;
PImage misil;
PImage bomba;
float xb;
float yb;
float x1;
float bspeed;
float pspeed;
float bomb;
float proy;
float x, y;
float vx, vy;
float gravity;
float time;
int control = 0;
int subhits;
int avionhits;


void setup(){
  //size(1600, 738);  //tamaño de pantalla
  size(1300, 600);
  avion=0;  //valores iniciales 
  //avion=738;
  sub=width;
  //sub=738;
  imgav = loadImage("avionD.png");    //cargamos las imagenes antes de usarlas
  imgsub = loadImage("submarinoD.png");
  imgexpl = loadImage("explosion.png");
  misil = loadImage("misilsub2.jpg.png");
  bomba = loadImage("bombavion2.jpg.png");
  bomb = height/3;
  control = 0;                        //esto se utiliza para cuando se reinicie el juego
  airspeed = 10;
  subspeed = -10;
  bspeed = 0;
  pspeed = 0;
  minim = new Minim(this);
  player = minim.loadFile("audio1.wav");
  player.play();
  
  //vx = -5;   //estos son los que se usan para la parabola (aun en prueba)
  //vy = -10;
  //gravity = 0.5;
  //time = 0;
  
}



void draw() {
  
 PImage img;
 img = loadImage("backgroundDv2.jpg.png");
 background(img);
 image(imgav, avion, height/3, 200, 100);        //avion
 image(imgsub, sub, (height*2/3), 200, 100);    //submarino
  
 airspeed = 10;   //velocidades de ambos
 subspeed = -10;
 
 avion = avion + airspeed;  //aqui se lo sumamos a la imagen
 avionhb = avion + 300;    //hitbox del avion
 //println("" + avion, height/3);
 sub = sub + subspeed;   //igual para el submarino, añadimos velocidad a la imagen
 subhb = sub + 300;      //hitbox del submarino, que se usa para el mouse click y para checar si la bomba le da
 //println("x = " + mouseX +", y = "+ mouseY);
 
 if(avion > width){  //esto es para regresar las imagenes a su origen si pasan el limite
   avion = 0;
 }
 if(sub < 0){
  sub=width; 
 }
  
  
 if(control==1){  //cuando se da click en el avion
  xb = avion;
  bspeed = bspeed + 1;  //parametros para la bomba
  bomb = bomb + bspeed;
  //ellipse(xb, bomb, 32, 32);
  image(bomba, xb, bomb);     //la bomba en cuestion que caera
  //println(bomb);
  if(xb > sub && xb < subhb && bomb > 500 && bomb < 599){     //checamos si choca con el submarino
    //println("hit!!");
    image(imgexpl, sub, 300);     //abrimos la imagen de explosion
    textSize(60);
    text("Gano avion!!! Mantener enter para reiniciar :)", 30, 50); //un pequeño feedback
    player.pause();
    noLoop();    //detenemos el juego
    
  }else if(bomb>2000){    //si no choca, simplemente lo reiniciamos para que pueda intentarlo otra vez
     frameCount = -1;     
     control = 0;
     player.pause();
   }
 }
 
 if(control==2){            //bomba del submarino
  xb = sub;                  //parametros para la bomba
  pspeed = pspeed - 10;
  proy = 400;
  proy = proy + pspeed;
  //ellipse(xb, proy, 32, 32);
  image(misil, xb, proy);       //la bomba en cuestion
  /*x = sub;      //estos son los parametros que usaria para la parabola
  y = 500;
  x = x + vx;
  y = y + vy;
  time = time + 1;
  ellipse(x, y, 32, 32);*/  //aqui termina lo de la parabola
  if(xb > avion && xb < avionhb && proy > 230 && proy < 348){     //checamos si le da al avion
    //println("hit!!");
    image(imgexpl, avion, 60);          //cargamos la imagen de explosion
    noLoop();                          //detenemos el juego
    player.pause();
    textSize(60);
    text("Gano submarino!!! Mantener enter para reiniciar :)", 30, 550);      //pequeño feedback
    
  }else if(proy < -310){                //se reinicia para que lo vuelva a intentar
    frameCount = -1;
    control = 0;
    player.pause();
  }
 }  
}

void mouseClicked(){                  //esto solo se activara si se da click a uno de los jugadores
  if(mouseX > avion && mouseX < avionhb  && mouseY > 230 && mouseY < 348 /*&& mousePressed*/){
   
    control = 1;
    //println("avion");
 }else if(mouseX > sub && mouseX < subhb && mouseY > 400 && mouseY < 500 /*&& control == 0*/){
    //println("sub"); 
    //println("x: " + mouseX, " y: " + mouseY);
    //println("sub : " + sub, "subhb: " + subhb);
    control = 2;
 }
}

void keyPressed(){                  //requerido para volver a empezar una vez que algun jugador gane
  if(keyCode == ENTER){
  restart();                       //se llama a la funcion
  }
  
}

void restart(){
  loop();                      //lo que hace noloop() arriba es detener el loop de draw(), y este loop permite reiniciar ese loop en draw()
  
}

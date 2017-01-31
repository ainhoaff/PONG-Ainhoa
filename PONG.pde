//Se declaran las variables
int posx=width/2; //posición en x de la pelota
int posy=height/2; //posición y de la pelota
int vx=3; //velocidad x de la pelota
int vy=3; //velocidad y de la pelota
int altopala=15; //alto de la pala
int pospala=360; //posición de la pala
int anchopala=130; //ancho de la pala
int xpala=0; //posición en x de la pala por la izquierda
int palax=0; //posición en x de la pala por la derecha
boolean gameOver=true;
int score=0; //
int radiobola=20; //radio de la bola

PImage webImg;

Bloque[] miBloque1 = new Bloque[5];
Bloque[] miBloque2 = new Bloque[5];

void setup() {
  frameRate(80);

  //tamaño de la pantalla
  size(500, 400);

  //fondo
  String url = "http://www.solofondosdepantalla.net/fondos-de-pantalla/Espacio/Fondo-de-pantalla-Boreal-sunrise.jpg";
  // Load image from a web server
  webImg = loadImage(url, "png");

  //Bloques
  displayBloque();
}

//Al presionar cualquier tecla.
void keyPressed() {
  if (gameOver==true) {
    gameOver=false;
  }
}

void draw() {
  //Pantalla
  image(webImg, 0, 0);

  //Al comenzar
  if (gameOver==true) {
    posx=width/2;
    posy=200;
    background (0);
    textSize(15);
    text("Pulsa cualquier tecla para comenzar", 122, 180);
  } else {
    //Dibujar pelota y pala
    fill(255);
    rectMode(CORNER);
    rect(xpala, pospala, anchopala, altopala);
    ellipse(posx, posy, radiobola, radiobola);

    //Variables
    xpala=(mouseX-65);
    palax=(xpala+anchopala);
    posx=vx + posx;
    posy=vy + posy;
    textSize(15);
    text("Puntuación", 385, 28);
    textSize(25);
    text(score, 470, 30);

    //Bloques
    Bloques();

    //Detectar bordes y rebote de pelota
    if (posx>490) {
      vx=vx*-1;
    }
    if (posx<10) {
      vx=vx*-1;
    }
    if (posy<10) {
      vy=vy*-1;
    }
    if (posy==350 && posx>(xpala) && posx<(palax)) {
      vy=vy*-1;
    }

    //Si la pelota llega a abajo, se acaba el juego
    if (posy>390) {
      background(0, 0, 0);
      textSize(15);
      text("Game Over!", 200, 160);
      text("Más suerte a la próxima :P", 155, 185);
      textSize(22);
      text("Puntuación total:  "+score, 145, 230);
    }

    //Si llega a la puntuación máxima, gana
    if (score==10) {
      background(0, 0, 0);
      textAlign(CENTER);
      textSize(30);
      text("¡Victoria!", width/2, 160);
      text("Enhorabuena, has ganado", width/2, 205);
      text(":D", width/2, 250);
    }
  }
}

class Bloque {
  //Variables de los bloques
  int Posx, Posy, estado, anchoBloque, altoBloque;
  float r;
  float g;
  float b;
  Bloque (int xPosTemp, int yPosTemp, int estadoTemp) { //constructor
    Posx=xPosTemp;
    Posy=yPosTemp;
    estado=estadoTemp;
    anchoBloque=55;
    altoBloque=27;
    r=random(0, 255);
    g=random(0, 255);
    b=random(0, 255);
  }

  //DIBUJAR LOS BLOQUES
  void dibujar() {
    if (estado==1) {
      rectMode(CENTER);
      stroke(r, g, b);
      strokeWeight(2);
      rect(Posx, Posy, anchoBloque, altoBloque);
    }
  }

  //ELIMINAR BLOQUES
  void eliminarBloque() {
    if (posx > Posx-anchoBloque/2-radiobola && posx < Posx+anchoBloque/2+radiobola && posy > Posy-altoBloque/2-radiobola && posy < Posy +altoBloque/2+radiobola && estado==1) {
      estado=0;
      vy=vy*(-1);
      score=score+1;
    }
  }
}

void Bloques() {
  for (int i=0; i< 5; i ++) {
    miBloque1[i].dibujar();
    miBloque1[i].eliminarBloque();
  }
  for (int h=0; h< 5; h ++) {
    miBloque2[h].dibujar();
    miBloque2[h].eliminarBloque();
  }
}

void displayBloque() {
  for (int i=0; i< miBloque1.length; i++) {
    miBloque1[i]= new Bloque(i*width/5+width/(2*5), height/7, 1);
  }
  for (int h=0; h< miBloque2.length; h++) {
    miBloque2[h]= new Bloque(h*width/5+width/(2*5), 2*height/7, 1);
  }
}
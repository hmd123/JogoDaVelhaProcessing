Bloco[] blocos = new Bloco[9];

boolean defineMarcador = true; //true  = x
boolean turnoInicial = true; //define se o jogador1 comeca
boolean defineInimigoIa = true;
boolean mousePressionado = false;
boolean permiteContador = false;


Jogador j = new Jogador(defineMarcador); //jogador1 com x
Jogador j2 = new Jogador(!defineMarcador);
Inimigo i = new Inimigo(!defineMarcador);
Minimax ia = new Minimax(!defineMarcador);

boolean turno = turnoInicial; //jogador1 comeca

int numJogadas = 0;
int contador = 0;
int setor;

void setup() {
  size(600, 650);
  background(255);

  tiras();

  for (int i = 0; i < blocos.length; i++) {
    blocos[i] = new Bloco(205*(i%3), 205*(i/3));
  }
}

boolean kPlacar = false;

void draw() {
  calculaSetor();
  int ah = ia.operacao(blocos);

  if (permiteContador == true)
    contador++;
  eventoBotao();

  if (turno == true) {
    if (j.trocaTurno() == true) {
      turno = !turno;
      numJogadas++;
    }
  } else {
    if (defineInimigoIa == false) {
      if (j2.trocaTurno() == true) {
        turno = !turno;
        numJogadas++;
      }
    } else {
      i.jogaIA(blocos, ah);
      turno = !turno;
      numJogadas++;
    }
  }

  for (int i = 0; i < blocos.length; i++) {
    blocos[i].display();
  } 

  condicaoVitoria();
  placar();
}



void mousePressed() {
  if (defineInimigoIa == false && turno == false)
    j2.mouse(setor);
  else
    j.mouse(setor);

  mousePressionado = true;
  permiteContador = true;
}

void keyPressed() { 
  kPlacar = !kPlacar;
}

void mouseReleased() {
  mousePressionado = false;
  permiteContador = false;
  contador = 0;
}

void eventoBotao() {
  stroke(0);
  strokeWeight(1);
  if (defineInimigoIa == true) {
    fill(184,212,178);
    rect(20, 600, 110, 30);

    fill(0);
    text("Contra IA", 45, 620);
  } else {
    fill(195,206,217);
    rect(20, 600, 110, 30);
    fill(0);
    text("Contra Humano", 28, 620);
  }

  if (tocaBotao() == true && mousePressionado == true && contador == 1) {
    defineInimigoIa = !defineInimigoIa;
    limpa();
    limpaPlacar();
  }
}

boolean tocaBotao() {
  if (mouseX >= 20 && mouseX <= 130 && mouseY >= 600 && mouseY <= 630) 
    return true;  
  else
    return false;
}

void calculaSetor() {
  float x, y; 
  int x1, y1, i;
  x = mouseX;
  y = mouseY;
  x1 = mouseX/200;
  y1 = mouseY/200;

  setor = y1*3 + x1%3;
}

void tiras() {
  fill(0);
  rect(190, 5, 15, 590);
  fill(0);
  rect(395, 5, 15, 590);
  fill(0);
  rect(5, 190, 590, 15);
  fill(0);
  rect(5, 395, 590, 15);
}

void limpa() {
  for (int i = 0; i < blocos.length; i++) {
    blocos[i].setMarcador(0); 
    blocos[i].limpa();
    turno = turnoInicial;
    numJogadas = 0;
  }
}

int marcVitoria;

int condicaoVitoria() {
  if (numJogadas >= 3 && numJogadas <= 9) {
    //horizontal
    if ((blocos[0].getMarcador() != 0) && (blocos[0].getMarcador() == blocos[1].getMarcador()) && (blocos[1].getMarcador() == blocos[2].getMarcador())) { 
      marcVitoria = blocos[0].getMarcador();  
      //desenha linha
    } else if ((blocos[3].getMarcador() != 0) && (blocos[3].getMarcador() == blocos[4].getMarcador()) && (blocos[4].getMarcador() == blocos[5].getMarcador())) { 
      marcVitoria = blocos[3].getMarcador();
    } else if ((blocos[6].getMarcador() != 0) && (blocos[6].getMarcador() == blocos[7].getMarcador()) && (blocos[7].getMarcador() == blocos[8].getMarcador())) { 
      marcVitoria = blocos[6].getMarcador();
    }
    //vertical
    else if ((blocos[0].getMarcador() != 0) && (blocos[0].getMarcador() == blocos[3].getMarcador()) && (blocos[3].getMarcador() == blocos[6].getMarcador())) { 
      marcVitoria = blocos[0].getMarcador();
    } else if ((blocos[1].getMarcador() != 0) && (blocos[1].getMarcador() == blocos[4].getMarcador()) && (blocos[4].getMarcador() == blocos[7].getMarcador())) { 
      marcVitoria = blocos[1].getMarcador();
    } else if ((blocos[2].getMarcador() != 0) && (blocos[2].getMarcador() == blocos[5].getMarcador()) && (blocos[5].getMarcador() == blocos[8].getMarcador())) { 
      marcVitoria = blocos[2].getMarcador();
    }
    //diagonal
    else if ((blocos[0].getMarcador() != 0) && (blocos[0].getMarcador() == blocos[4].getMarcador()) && (blocos[4].getMarcador() == blocos[8].getMarcador())) { 
      marcVitoria = blocos[0].getMarcador();
    } else if ((blocos[2].getMarcador() != 0) && (blocos[2].getMarcador() == blocos[4].getMarcador()) && (blocos[4].getMarcador() == blocos[6].getMarcador())) { 
      marcVitoria = blocos[2].getMarcador();
    } else { 
      if (numJogadas == 9) {
        limpa();
      }
      return 1;
    }

    if (marcVitoria == 1) {   
      if (j.getMarcador() == true) {
        j.setVitoria();
      } else {
        if (defineInimigoIa == true)
          i.setVitoria();
        else
          j2.setVitoria();
      }
    } else {   
      if (j.getMarcador() == false) {
        j.setVitoria();
      } else {
        if (defineInimigoIa == true)
          i.setVitoria();
        else
          j2.setVitoria();
      }
    }

    limpa();
  }

  return 0;
}


void placar() {
  stroke(255);
  fill(255);
  rect(400, 620, 580, 640); //gambiarra

  if (kPlacar)
    fill(0);
  else
    fill(255);

  text("Jogador:", 420, 630);
  text(j.getVitoria(), 475, 630);
  if (defineInimigoIa == true) {
    text("Oponente: ", 500, 630);
    text(i.getVitoria(), 568, 630);
  } else {
    text("Oponente: ", 500, 630);
    text(j2.getVitoria(), 568, 630);
  }
}

void limpaPlacar() {
  j.limpaVitoria();
  i.limpaVitoria();
  j2.limpaVitoria();
}

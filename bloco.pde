class Bloco {
  float x;
  float y;
  float fimX;
  float fimY;
  int marcador = 0;

  Bloco(int cordX, int cordY) {
    x = cordX;
    y = cordY;  
    fimX = cordX + 190;
    fimY = cordY + 190;
  }

  void show() {
    print(" ", marcador);
  }

  void display() { 
    if (marcador == 1) {
      x();
    } else if (marcador == 2) {
      zero();
    }
  }  

  int getMarcador() {
    return marcador;
  }

  void setMarcador(boolean m) {
    if (m == true) {
      marcador = 1;
    } else {
      marcador = 2;
    }
  }

  void setMarcador(int m) {
    marcador = m;
  }

  boolean verificaMouse(float i, float j) {
    if (i >= x && i <= fimX && j >= y && j <= fimY)
      return true;  
    else
      return false;
  }

  void x() { //tamanho de cada linha eh de 106
    strokeWeight(15);
    stroke(230, 40, 40);
    line(x+45, y+50, x+151, y+156);

    strokeWeight(15);
    stroke(230, 40, 40);
    line( x+151, y+50, x+45, y+156);
  }

  void zero() {
    fill(255, 0);
    strokeWeight(15);
    stroke(80, 130, 230);
    circle((x+fimX)/2, (y+fimY)/2, 150);
  }

  void limpa() {  //gambiarra, eu sei, vai se ferrar
    stroke(255);
    strokeWeight(15);
    fill(255);
    circle((x+fimX)/2, (y+fimY)/2, 170);
  }
}

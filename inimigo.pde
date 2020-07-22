class Inimigo {
  boolean marcadorX;
  int vitorias;

  Inimigo(boolean m) {
    marcadorX = m;
    vitorias = 0;
  }

  boolean getMarcador() {
    return marcadorX;
  }

  void setVitoria() {
    vitorias++;
  }

  int getVitoria() {
    return vitorias;
  }
  
  void limpaVitoria() {
    vitorias = 0;  
  }

  void jogaAleat(Bloco[] b) {
    int alea = int(random(9));
    while (b[alea].getMarcador() != 0) {
      alea = int(random(9));
    }

    b[alea].setMarcador(marcadorX);
  }


  void jogaIA(Bloco[] b, int ah) {
    b[ah].setMarcador(marcadorX);
  }
}

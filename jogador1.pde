class Jogador {
  boolean marcadorX;
  int vitorias;
  boolean passaVez = false;

  Jogador(boolean m) {
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

  void mouse(int setor) { 
    if (setor <= 8 && blocos[setor].getMarcador() == 0) {
      blocos[setor].setMarcador(marcadorX);
      passaVez = true;
    } else {
      passaVez = false;
    }
  }

  boolean trocaTurno() {
    if (passaVez == true) {
      passaVez = false;
      return true;
    } else {
      return false;
    }
  }
}

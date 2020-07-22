class Movimento {
  int index;
  int pontuacao;

  Movimento(int i, int p) {
    index = i;
    pontuacao = p;
  }

  void setPontuacao(int p) {
    pontuacao = p;
  }

  int getPontuacao() {
    return pontuacao;
  }

  int getIndex() {
    return index;
  }
}

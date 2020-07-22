class Minimax {

  int contador = 0; //keeps count of function calls
  int humaJogador, iaJogador;
  int k = 1;

  Minimax(boolean x) {    
    // human
    if (x == false) {
      humaJogador = 1;
      // ai
      iaJogador = 2;
      //definir quem é quem
    } else {
      iaJogador = 1;

      humaJogador = 2;
    }
  }

  int operacao(Bloco[] b) {

    int[] quadroOrig = new int[9];
    for (int i = 0; i < b.length; i++) {
      quadroOrig[i] = b[i].getMarcador();
    }
    
    // finding the ultimate play on the game that favors the computer
    int melhorPosicao = minimax(quadroOrig, humaJogador);

    //loging the results
    contador = 0;

    return melhorPosicao;
  }

  // the main minimax function
  int minimax(int[] quadroNovo, int jogador) {
    //add one to function calls
    contador++;

    //available spots
    ArrayList<Integer> lugaresVazios = new ArrayList<Integer>(); //mexer
    lugaresVazios = indexiesVazios(quadroNovo);
    
    // checks for the terminal states such as win, lose, and tie and returning a value accordingly
    if (vitoria(quadroNovo, humaJogador)) {
      return -10;
    } else if (vitoria(quadroNovo, iaJogador)) {
      return 10;
    } else if (lugaresVazios.size() == 0) {      
      return 0;
    }

    // an array to collect all the objects
    ArrayList<Movimento> movimentos = new ArrayList<Movimento>();

    // loop through available spots
    for (int i = 0; i < lugaresVazios.size(); i++) {
      //create an object for each and store the index of that spot that was stored as a number in the object's index key
      Movimento move = new Movimento(lugaresVazios.get(i), 0);

      // set the empty spot to the current player
      quadroNovo[lugaresVazios.get(i)] = jogador;
      //if collect the score resulted from calling minimax on the opponent of the current player
      if (jogador == iaJogador) {
        int resultado = minimax(quadroNovo, humaJogador);
        move.setPontuacao(resultado);
      } else {
        int resultado = minimax(quadroNovo, iaJogador);
        move.setPontuacao(resultado);
      }

      //reset the spot to empty
      quadroNovo[lugaresVazios.get(i)] = move.getIndex();

      // push the object to the array
      movimentos.add(new Movimento(move.getIndex(), move.getPontuacao())); //mexer
    }

    // if it is the computer's turn loop over the moves and choose the move with the highest score
    int melhorJogada = 0;
    if (jogador == iaJogador) {
      int melhorPontuacao = -10000;
      for (int i = 0; i < movimentos.size(); i++) {
        if (movimentos.get(i).getPontuacao() == melhorPontuacao) {
          if (int(random(2)) == 0)
            melhorJogada = i;
        } else if (movimentos.get(i).getPontuacao() > melhorPontuacao) {
          melhorPontuacao = movimentos.get(i).getPontuacao();
          melhorJogada = i;
        }
      }
    } else {

      // else loop over the moves and choose the move with the lowest score
      int melhorPontuacao = 10000;
      for (int i = 0; i < movimentos.size(); i++) {
        if (movimentos.get(i).getPontuacao() == melhorPontuacao) {
          if (int(random(2)) == 0)
            melhorJogada = i;
        } else if (movimentos.get(i).getPontuacao() < melhorPontuacao) {
          melhorPontuacao = movimentos.get(i).getPontuacao();
          melhorJogada = i;
        }
      }
    }
   
    // return the chosen move (object) from the array to the higher depth
    return movimentos.get(melhorJogada).getIndex();
  }


  // returns the available spots on the quadro
  ArrayList<Integer> indexiesVazios(int[] quadro) { //mexer
    ArrayList<Integer> lv = new ArrayList<Integer>();
    for (int i = 0; i < quadro.length; i++) {
      if (quadro[i] == 0)
        lv.add(i);
    }
    return lv;
  }

  // winning combinations using the quadro indexies for instace the first win could be 3 xes in a row
  boolean vitoria(int[] quadro, int jogador) {
    if (
      (quadro[0] == jogador && quadro[1] == jogador && quadro[2] == jogador) ||
      (quadro[3] == jogador && quadro[4] == jogador && quadro[5] == jogador) ||
      (quadro[6] == jogador && quadro[7] == jogador && quadro[8] == jogador) ||
      (quadro[0] == jogador && quadro[3] == jogador && quadro[6] == jogador) ||
      (quadro[1] == jogador && quadro[4] == jogador && quadro[7] == jogador) ||
      (quadro[2] == jogador && quadro[5] == jogador && quadro[8] == jogador) ||
      (quadro[0] == jogador && quadro[4] == jogador && quadro[8] == jogador) ||
      (quadro[2] == jogador && quadro[4] == jogador && quadro[6] == jogador)
      ) { 
      return true;
    } else {
      return false;
    }
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Jokenpo is Ownable(msg.sender) {
    mapping (address => bool) public jogadores;
    address jogador;
    string jogada;
    string jogadaAnterior;
    string resultado;

    event JogadaFeita(address indexed para, string jogada);
    event JogadaValidada(address indexed para, string jogada, string resultado);

    // Faz jogadas
    function fazerJogada(string _jogada) external onlyOwner {
        _mint(address(this), _jogada);
        emit JogadaFeita(address(this), _jogada);
    }
    
    // Valida jogada
    function validarJogada(string memory _jogada, string memory _jogadaAnterior) external onlyJogador {
        
        if (_jogada = "pedra"){
            if (jogadaAnterior = "papel"){
                resultado = "Derrota.";
            }
            if (jogadaAnterior = jogada){
                resultado = "Empate...";
            }
            else {
                resultado = "Vitoria!";
            }
        }

        if (_jogada = "tesoura"){
            if (jogadaAnterior == "pedra") {
                resultado = "Derrota!";
            }
            if(jogadaAnterior == jogada){
                resultado = "Empate...";
            }
            else {
                resultado = "Vitoria";
            }
        }
        if (_jogada = "papel"){
            if (jogadaAnterior == "tesoura") {
                resultado = "Derrota!";
            }
            if(jogadaAnterior == jogada){
                resultado = "Empate...";
            }
            else {
                resultado = "Vitoria";
            }
        }
        emit JogadaValidada(address(this), _jogada, resultado);    
    }

    // Adiciona um novo jogador autorizado
    function adicionarJogador(address _jogador) external onlyOwner {
        jogadores[_jogador] = true;
    }

    // Remove um jogador da lista de autorizados
    function removerJogador(address _jogador) external onlyOwner {
        jogadores[_jogador] = false;
    }

    // Modifier para restringir funções apenas a jogadores
    modifier onlyJogador() {
        require(jogadores[msg.sender], "Jogador nao autorizado");
        _;
    }
}

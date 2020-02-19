package model;

import java.time.LocalDate;

public class TransazioneBean {
	private int ID_transazione;
	private int ID_gioco;
	private int ID_utente;
	private int ID_fatturazione;
	private LocalDate data;
	
	public TransazioneBean() {
		this.ID_transazione = -1;
		this.ID_gioco = -1;
		this.ID_utente = -1;
		this.ID_fatturazione = -1;
		data = LocalDate.now();
	}
	
	public int getID_transazione() {
		return ID_transazione;
	}
	public void setID_transazione(int id_transazione) {
		this.ID_transazione = id_transazione;
	}
	public int getID_gioco() {
		return ID_gioco;
	}
	public void setID_gioco(int id_gioco) {
		this.ID_gioco = id_gioco;
	}
	public int getID_utente() {
		return ID_utente;
	}
	public void setID_utente(int id_utente) {
		this.ID_utente = id_utente;
	}
	public int getID_fatturazione() {
		return ID_fatturazione;
	}
	public void setID_fatturazione(int id_fatturazione) {
		this.ID_fatturazione = id_fatturazione;
	}
	public LocalDate getData() {
		return data;
	}
	public void setData(LocalDate data) {
		this.data = data;
	}
}

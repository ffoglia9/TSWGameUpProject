package model;

import java.time.LocalDate;

public class SponsorizzazioneBean {
	private int ID_Sponsor;
	private LocalDate dataInizio;
	private LocalDate dataFine;
	
	public SponsorizzazioneBean(int iD_Sponsor, LocalDate dataInizio, LocalDate dataFine) {
		ID_Sponsor = iD_Sponsor;
		this.dataInizio = dataInizio;
		this.dataFine = dataFine;
	}
	
	public SponsorizzazioneBean(LocalDate dataInizio, LocalDate dataFine) {
		this.dataInizio = dataInizio;
		this.dataFine = dataFine;
	}
	
	public int getID_Sponsor() {
		return ID_Sponsor;
	}
	public void setID_Sponsor(int iD_Sponsor) {
		ID_Sponsor = iD_Sponsor;
	}
	public LocalDate getDataInizio() {
		return dataInizio;
	}
	public void setDataInizio(LocalDate dataInizio) {
		this.dataInizio = dataInizio;
	}
	public LocalDate getDataFine() {
		return dataFine;
	}
	public void setDataFine(LocalDate dataFine) {
		this.dataFine = dataFine;
	}
}

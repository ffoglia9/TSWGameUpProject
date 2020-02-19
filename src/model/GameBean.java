package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class GameBean implements Serializable {

	private static final long serialVersionUID = 1L;

	int code;
	String title;
	String description;
	double price;
	String img, icon;
	List <ReviewBean> reviews;
	int sponsorID;
	int userID;
	int sconto;
	boolean approvato;
	String genere; 
	enum Genere {
		Action,
		RTS,
		Adventure,
		Puzzle,
		Arcade
	}
	
	
	public GameBean() {
		code = -1;
		title = "";
		description = "";
		img = "";
		reviews = new ArrayList<ReviewBean>();
		sponsorID = -1;
		sconto = 0;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}
	
	public String getShortDescprition() {
		
		String shortDesc;
		shortDesc = this.description.substring(0, 101);
		if(this.description.length() > shortDesc.length())
			shortDesc = shortDesc.concat("...");
		return shortDesc;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	public int getSponsorID() {
		return sponsorID;
	}

	public void setSponsorID(int sponsorID) {
		this.sponsorID = sponsorID;
	}

	public int getSconto() {
		return sconto;
	}

	public void setSconto(int sconto) {
		this.sconto = sconto;
	}

	//metodo per ottenere solamente il campo recensione inerente ad un videgioco, scritto dall'utente
	public List<String> getReviewString() {
		
		List<String> rec = new ArrayList<String>();
		for (int i = 0; i < reviews.size(); i++) {
			ReviewBean x = reviews.get(i);
			rec.add(x.getReview());
		}
		return rec;
	}
	
	
	public String getGenere() {
		return genere;
	}

	public void setGenere(String genere) {
		if(checkGenere(genere))
			this.genere = genere;
	}
	
	public int getUserID() {
		return this.userID;
	}
	
	public void setUserID(int userID) {
		this.userID = userID;
	}
	
	public boolean isApproved() {
		return approvato;
	}

	public void setApproved(boolean approvato) {
		this.approvato = approvato;
	}

	//metodo helper per controllare se il genere inserito è corretto / presente / valido
	private boolean checkGenere(String str){
		  
		Genere[] generi = Genere.values();
		for(Genere g : generi){
			if(g.toString().equals(str))
				return true;
		}	  
		return false;
	}

	public List<ReviewBean> getReviews() {
		return reviews;
	}

	@Override
	public String toString() {
		return title + " (" + code + "), " + price + " " + img + ". " + description;
	}
	
	
}

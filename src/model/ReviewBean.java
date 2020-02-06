package model;

public class ReviewBean {
	
	private boolean liked;
	private String review;
	private int ID_gioco;
	private int ID_utente;
	
	
	public ReviewBean(boolean liked, String review, int ID_gioco, int ID_utente) {
		this.liked = liked;
		this.review = review;
		this.ID_gioco = ID_gioco;
		this.ID_utente = ID_utente;
	}
	
	public boolean getLike() {
		return this.liked;
	}
	
	public String getReview() {
		return this.review;
	}
	
	public void setReview(String review) {
		this.review = review;
	}
	
	public void setLiked(boolean liked) {
		this.liked = liked;
	}
	
	@Override
	public String toString() {
		return liked + " (" + review + ")";
	}
	
	
}

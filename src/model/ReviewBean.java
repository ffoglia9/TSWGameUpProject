package model;

public class ReviewBean {
	
	private int ID_review;
	private boolean liked;
	private String review;
	private int ID_gioco;
	private int ID_utente;
	
	
	public ReviewBean(int ID_review, boolean liked, String review, int ID_gioco, int ID_utente) {
		this.ID_review = ID_review;
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

	public int getID_gioco() {
		return ID_gioco;
	}

	public int getID_utente() {
		return ID_utente;
	}
	
	public void setReviewID(int code) {
		ID_review = code;
	}
	
	public int getReviewID() {
		return ID_review;
	}
	
}

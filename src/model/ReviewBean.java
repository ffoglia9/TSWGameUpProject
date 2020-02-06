package model;

public class ReviewBean {
	
	private boolean liked;
	private String review;
	private GameBean game;
	
	
	public ReviewBean(boolean liked, String review, GameBean game) {
		this.liked = liked;
		this.review = review;
		this.game = game;
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

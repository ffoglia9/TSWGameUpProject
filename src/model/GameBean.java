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
	String img;
	List <ReviewBean> reviews;

	public GameBean() {
		code = -1;
		title = "";
		description = "";
		img = "";
		reviews = new ArrayList<ReviewBean>();
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
	
	
	//metodo per ottenere solamente il campo recensione inerente ad un videgioco, scritto dall'utente
	public List<String> getReviewString() {
		
		List<String> rec = new ArrayList<String>();
		
		for (int i = 0; i < reviews.size(); i++) {
			ReviewBean x = reviews.get(i);
			rec.add(x.getReview());
		}
		
		return rec;
	}
	
	
	public List<ReviewBean> getReviews() {
		return reviews;
	}

	@Override
	public String toString() {
		return title + " (" + code + "), " + price + " " + img + ". " + description;
	}

}

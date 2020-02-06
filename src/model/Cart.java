package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {

	private List<GameBean> games;
	
	public Cart() {
		games = new ArrayList<GameBean>();
	}
	
	public void addProduct(GameBean product) {
		games.add(product);
	}
	
	public void deleteProduct(GameBean product) {
		for(GameBean prod : games) {
			if(prod.getCode() == product.getCode()) {
				games.remove(prod);
				break;
			}
		}
 	}
	
	
	//metodo per ottenere il prezzo totale dei prodotti inseriti nel carrello
	public double getTotal() {
		
		double tot = 0;
		
		for(GameBean x : games) {
			
			tot += x.getPrice();
		}
		
		return tot;
	}
	
	public List<GameBean> getgames() {
		return  games;
	}
}

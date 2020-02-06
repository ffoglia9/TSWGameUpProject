package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;


/*.
//DataSource del ReviewDS 
public class ReviewDS implements DataAccessModel<ReviewBean>{
	
	private DataSource ds;
	private static final String TABLE_NAME = "recensione";
	
	public ReviewDS(DataSource ds) {
		this.ds = ds;
		
		//debug
		System.out.println("DataSource ReviewDS creation....");
	}
	
	@Override
	public synchronized void doSave(ReviewBean review) throws SQLException {
		
		//String insertSQL = "INSERT INTO " + ReviewDS.TABLE_NAME + " (Titolo, Descrizione, Immagine, Prezzo) VALUES (?, ?, ?, ?)";
		
		
		
	}

	
	

}
*/
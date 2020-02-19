package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.LinkedList;
import model.GameDS;
import javax.sql.DataSource;



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
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int percValutazione = 0;
		
		String insertSQL = "INSERT INTO " + ReviewDS.TABLE_NAME + " (Consigliato, Opinione, ID_Gioco, ID_Utente) VALUES (?, ?, ?, ?)";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setBoolean(1, review.getLike());
			preparedStatement.setString(2, review.getReview());
			preparedStatement.setInt(3, review.getID_gioco());
			preparedStatement.setInt(4, review.getID_utente());
			
			preparedStatement.execute();
			
			ResultSet tableKeys = preparedStatement.getGeneratedKeys();
			tableKeys.next();
			int autoGeneratedID = tableKeys.getInt(1);
			
			review.setReviewID(autoGeneratedID);
			percValutazione = valutazione(review.getID_gioco());
			
			GameDS gameDS = new GameDS(this.ds);
			GameBean gb = gameDS.doRetrieveByKey(review.getID_gioco());
			gb.setValutazione(percValutazione);
			gameDS.doUpdate(gb);
			
			
		} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
					} finally{
						if (connection != null)
							connection.close();
						}
				}
		}
	
	
	@Override
	public synchronized ReviewBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		String selectSQL = "SELECT * FROM " + ReviewDS.TABLE_NAME + " WHERE ID_Recensione = ?";
		ReviewBean bean = null;
		
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
						bean = new ReviewBean(
						rs.getBoolean("Consigliato"),
						rs.getString("Opinione"),
						rs.getInt("ID_Gioco"),
						rs.getInt("ID_Utente"));	
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}
	

	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ReviewDS.TABLE_NAME + " WHERE ID_Recensione = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}
	
	@Override
	public synchronized Collection<ReviewBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ReviewBean> reviews = new LinkedList<ReviewBean>();

		String selectSQL = "SELECT * FROM " + ReviewDS.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
					ReviewBean bean = new ReviewBean(
					rs.getBoolean("Consigliato"),
					rs.getString("Opinione"),
					rs.getInt("ID_Gioco"),
					rs.getInt("ID_Utente"));
					
					reviews.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return reviews;
	}
	
	@Override
	public synchronized boolean doUpdate(ReviewBean review) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;

		String updateSQL = "UPDATE " + ReviewDS.TABLE_NAME + " (ID_Gioco, ID_Utente, Consigliato, Opinione) VALUES (?, ?, ?, ?) WHERE ID_Recensione = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setInt(1, review.getID_gioco());
			preparedStatement.setInt(2, review.getID_utente());
			preparedStatement.setBoolean(3, review.getLike());
			preparedStatement.setString(4, review.getReview());
			preparedStatement.setInt(5, review.getReviewID());
			
			
			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}
	
	//Metodo per recuperare le recensioni inerenti ad un determinato ID_gioco
	public Collection<ReviewBean> getGameReviews(int gameID) throws SQLException{
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String selectSQL = "SELECT * FROM " + ReviewDS.TABLE_NAME + " WHERE ID_Gioco = ?";
		Collection<ReviewBean> reviews = new LinkedList<ReviewBean>();
		
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, gameID);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
					ReviewBean bean = new ReviewBean(
					rs.getBoolean("Consigliato"),
					rs.getString("Opinione"),
					rs.getInt("ID_Gioco"),
					rs.getInt("ID_Utente"));
					bean.setReviewID(rs.getInt("ID_Recensione"));
					
					reviews.add(bean);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		return reviews;
	}
	
	
	public int valutazione(int gameID) throws SQLException{
		
		double media = 0;
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		
		String selectConsigliatoSQL = "SELECT AVG(Consigliato) FROM " + ReviewDS.TABLE_NAME + " WHERE ID_Gioco = ?";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectConsigliatoSQL);
			preparedStatement.setInt(1, gameID);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			media = rs.getDouble(1);
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		int res;
		res = (int) media * 100;
		return res;
	}

}
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import javax.sql.DataSource;

/* DataSource del bean GameBean. */
public class GameDS implements DataAccessModel<GameBean> {

	private DataSource ds;
	private static final String TABLE_NAME = "gioco";

	public GameDS(DataSource ds) {
		this.ds = ds;
		
		System.out.println("DataSource GameDS creation....");
	}

	@Override
	public synchronized void doSave(GameBean game) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL = "INSERT INTO " + GameDS.TABLE_NAME + " (Titolo, Descrizione, Immagine, Prezzo, Sconto, Genere, ID_Utente, Approvato, Icon) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, game.getTitle());
			preparedStatement.setString(2, game.getDescription());
			preparedStatement.setString(3, game.getImg());
			preparedStatement.setDouble(4, game.getPrice());
			preparedStatement.setInt(5, game.getSconto());
			preparedStatement.setString(6, game.getGenere());
			preparedStatement.setInt(7, game.getUserID());
			preparedStatement.setBoolean(8, game.isApproved());
			preparedStatement.setString(9, game.getIcon());
			
			
			preparedStatement.executeUpdate();
			
			//Aggiorna l'ID del gioco generato dall'SQL
			ResultSet tableKeys = preparedStatement.getGeneratedKeys();
			tableKeys.next();
			int gameID = tableKeys.getInt(1);
			game.setCode(gameID);

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}

	@Override
	public synchronized GameBean doRetrieveByKey(int code) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		GameBean bean = null;

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME + " WHERE ID_Gioco = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean = new GameBean();
				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setImg(rs.getString("Immagine"));
				bean.setPrice(rs.getDouble("Prezzo"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(rs.getInt("ID_Sponsor"));
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if (connection != null)
					try {
						connection.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
		}
		return bean;
	}

	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + GameDS.TABLE_NAME + " WHERE ID_Gioco = ?";

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
	public synchronized Collection<GameBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<GameBean> games = new ArrayList<GameBean>();

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY ?";
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			if (order != null && !order.equals("")) {
				preparedStatement.setString(1, order);
			}

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				GameBean bean = new GameBean();

				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getInt("Prezzo"));
				bean.setImg(rs.getString("Immagine"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(rs.getInt("ID_Sponsor"));
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
				games.add(bean);
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
		return games;
	}
	
	@Override
	public synchronized boolean doUpdate(GameBean game) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;

		String updateSQL = "UPDATE " + GameDS.TABLE_NAME + " SET Titolo = ?, Descrizione = ?, Immagine = ?, Prezzo = ?, ID_Sponsor = ?, Sconto = ?, Approvato = ?, Icon = ?, PendingSponsor = ? WHERE ID_Gioco = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, game.getTitle());
			preparedStatement.setString(2, game.getDescription());
			preparedStatement.setString(3, game.getImg());
			preparedStatement.setDouble(4, game.getPrice());
			preparedStatement.setInt(5, game.getSponsorID());
			preparedStatement.setInt(6, game.getSconto());
			preparedStatement.setBoolean(7, game.isApproved());
			preparedStatement.setString(8, game.getIcon());
			preparedStatement.setBoolean(9, game.isPendingSponsorReq());
			//WHERE ID_GIOCO = ?
			preparedStatement.setInt(10, game.getCode());
			

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
	
	public Collection<GameBean> doRetrieveByGenre(String genre) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<GameBean> games = new ArrayList<GameBean>();

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME + " WHERE Genere = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, genre);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				GameBean bean = new GameBean();
				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getInt("Prezzo"));
				bean.setImg(rs.getString("Immagine"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(rs.getInt("ID_Sponsor"));
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
				games.add(bean);
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
		return games;
	}
	
	public Collection<GameBean> doRetrieveByTitle(String title) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<GameBean> games = new ArrayList<GameBean>();

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME + " WHERE Titolo LIKE ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, "%" + title + "%");

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				GameBean bean = new GameBean();

				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getInt("Prezzo"));
				bean.setImg(rs.getString("Immagine"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(rs.getInt("ID_Sponsor"));
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
				games.add(bean);
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
		return games;
	}

	public Collection<GameBean> doRetrieveByDeveloper(int ID_Utente) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<GameBean> games = new ArrayList<GameBean>();

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME + " WHERE ID_Utente = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, ID_Utente);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				GameBean bean = new GameBean();

				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getInt("Prezzo"));
				bean.setImg(rs.getString("Immagine"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(rs.getInt("ID_Sponsor"));
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(ID_Utente);
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
				games.add(bean);
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
		return games;
	}
	
	public Collection<GameBean> doRetrieveAllPending() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<GameBean> games = new ArrayList<GameBean>();

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME + " WHERE Approvato = 0";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				GameBean bean = new GameBean();

				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getInt("Prezzo"));
				bean.setImg(rs.getString("Immagine"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(rs.getInt("ID_Sponsor"));
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
				games.add(bean);
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
		return games;
	}
	
	public Collection<GameBean> doRetrievePendingSponsors() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<GameBean> games = new ArrayList<GameBean>();

		String selectSQL = "SELECT * FROM " + GameDS.TABLE_NAME + " WHERE PendingSponsor = 1 AND ID_Sponsor != -1";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				GameBean bean = new GameBean();

				bean.setCode(rs.getInt("ID_Gioco"));
				bean.setTitle(rs.getString("Titolo"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getInt("Prezzo"));
				bean.setImg(rs.getString("Immagine"));
				bean.setSconto(rs.getInt("Sconto"));
				bean.setSponsorID(-1);
				bean.setGenere(rs.getString("Genere"));
				bean.setApproved(rs.getBoolean("Approvato"));
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setIcon(rs.getString("Icon"));
				bean.setValutazione(rs.getInt("Valutazione"));
				bean.setPendingSponsorReq(true);
				games.add(bean);
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
		return games;
	}
}
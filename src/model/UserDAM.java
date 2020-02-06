package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

/* Data Access Model del bean UserBean. */
public class UserDAM implements DataAccessModel<UserBean> {

	private DataSource ds;
	private static final String TABLE_NAME = "utente";

	public UserDAM(DataSource ds) {
		this.ds = ds;
		
		System.out.println("DataSource UserDS creation....");
	}

	public synchronized UserBean doRetrieveByEmailAndPassword(String email, String password) throws SQLException, NonExistentAccountException, WrongPasswordException {
		ResultSet rs = doRetrieveByEmail(email);
		String emailPw = rs.getString("Password");
		if(emailPw.equals(password)) {
			UserBean bean = new UserBean();
			bean.setUserID(rs.getInt("ID_Utente"));
			bean.setUsername(rs.getString("Username"));
			bean.setPassword(rs.getString("Password"));
			bean.setUserTypeID(rs.getString("Tipo_Utente"));
			bean.setEmail(rs.getString("Email"));
			return bean;
		} else {
			throw new WrongPasswordException();
		}
	}
	
	public synchronized ResultSet doRetrieveByEmail(String email) throws SQLException, NonExistentAccountException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String findByEmail = "SELECT * FROM " + UserDAM.TABLE_NAME + " WHERE Email = ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(findByEmail);
			preparedStatement.setString(1, email);
			
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next()) {
				return rs;
			} else {
				throw new NonExistentAccountException();
			}
		} finally  {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	
	//Ricerca per username
	public synchronized ResultSet doRetrieveByUsername(String username) throws SQLException, NonExistentAccountException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String findByEmail = "SELECT * FROM " + UserDAM.TABLE_NAME + " WHERE Username = ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(findByEmail);
			preparedStatement.setString(1, username);
			
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next()) {
				return rs;
			} else {
				throw new NonExistentAccountException();
			}
		} finally  {
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
	public synchronized void doSave(UserBean user) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + UserDAM.TABLE_NAME + " (Username, Password, Tipo_Utente, Email) VALUES (?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, user.getUsername());
			preparedStatement.setString(2, user.getPassword());
			preparedStatement.setString(3, user.getUserTypeID());
			preparedStatement.setString(4, user.getEmail());

			preparedStatement.executeUpdate();

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
	public synchronized UserBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		UserBean bean = new UserBean();

		String selectSQL = "SELECT * FROM " + UserDAM.TABLE_NAME + " WHERE ID_Utente = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setUsername(rs.getString("Username"));
				bean.setPassword(rs.getString("Password"));
				bean.setUserTypeID(rs.getString("Tipo_Utente"));
				bean.setEmail(rs.getString("Email"));
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

		String deleteSQL = "DELETE FROM " + UserDAM.TABLE_NAME + " WHERE ID_Utente = ?";

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
	public synchronized Collection<UserBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<UserBean> users = new LinkedList<UserBean>();

		String selectSQL = "SELECT * FROM " + UserDAM.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				UserBean bean = new UserBean();

				bean.setUserID(rs.getInt("ID_Utente"));
				bean.setUsername(rs.getString("Username"));
				bean.setPassword(rs.getString("Password"));
				bean.setUserTypeID(rs.getString("Tipo_Utente"));
				bean.setEmail(rs.getString("Email"));
				users.add(bean);
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
		return users;
	}
	
	@Override
	public synchronized boolean doUpdate(UserBean user) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;

		String updateSQL = "UPDATE " + UserDAM.TABLE_NAME + " (Username, Password, Tipo_Utente, Email) VALUES (?, ?, ?, ?) WHERE ID_Utente = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, user.getUsername());
			preparedStatement.setString(2, user.getPassword());
			preparedStatement.setString(3, user.getUserTypeID());
			preparedStatement.setString(4, user.getEmail());
			preparedStatement.setInt(5, user.getUserID());

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
	
	/// Exceptions used by this DataSource
	public class NonExistentAccountException extends Exception {

		private static final long serialVersionUID = 1L;
		public NonExistentAccountException() {
			super("Nessun account trovato nel database associato all'email fornita");
		}
	}
	public class WrongPasswordException extends Exception {
		private static final long serialVersionUID = 1L;
		public WrongPasswordException() {
			super("Password non corretta");
		}
	}

}
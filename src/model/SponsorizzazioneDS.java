package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.ArrayList;

import javax.sql.DataSource;

public class SponsorizzazioneDS implements DataAccessModel<SponsorizzazioneBean> {
	
	private DataSource ds;
	private static final String TABLE_NAME = "sponsorizzazione";
	
	public SponsorizzazioneDS(DataSource ds) {
		this.ds = ds;
	}
	
	@Override
	public synchronized void doSave(SponsorizzazioneBean sponsor) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL = "INSERT INTO " + SponsorizzazioneDS.TABLE_NAME + " (DataInizio, DataFine) VALUES (?, ?)";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setObject(1, sponsor.getDataInizio());
			preparedStatement.setObject(2, sponsor.getDataFine());
			
			
			preparedStatement.execute();
			
			ResultSet tableKeys = preparedStatement.getGeneratedKeys();
			tableKeys.next();
			int autoGeneratedID = tableKeys.getInt(1);
			
			sponsor.setID_Sponsor(autoGeneratedID);	
			
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
	public synchronized SponsorizzazioneBean doRetrieveByKey(int ID_Sponsor) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		String selectSQL = "SELECT * FROM " + SponsorizzazioneDS.TABLE_NAME + " WHERE ID_Sponsor = ?";
		SponsorizzazioneBean bean = null;
		
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, ID_Sponsor);

			ResultSet rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
						bean = new SponsorizzazioneBean(ID_Sponsor, rs.getDate("DataInizio").toLocalDate(), rs.getDate("DataFine").toLocalDate());
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

		String deleteSQL = "DELETE FROM " + SponsorizzazioneDS.TABLE_NAME + " WHERE ID_Sponsor = ?";

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
	public synchronized Collection<SponsorizzazioneBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<SponsorizzazioneBean> toSponsor = new ArrayList<SponsorizzazioneBean>();

		String selectSQL = "SELECT * FROM " + SponsorizzazioneDS.TABLE_NAME;

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
				SponsorizzazioneBean bean = new SponsorizzazioneBean(rs.getInt("ID_Sponsor"), rs.getDate("DataInizio").toLocalDate(), rs.getDate("DataFine").toLocalDate());
				toSponsor.add(bean);
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
		return toSponsor;
	}
	
	@Override
	public synchronized boolean doUpdate(SponsorizzazioneBean sponsorBean) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;

		String updateSQL = "UPDATE " + SponsorizzazioneDS.TABLE_NAME + " SET DataInizio = ?, DataFine = ? WHERE ID_Sponsor = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setObject(1, sponsorBean.getDataInizio());
			preparedStatement.setObject(2, sponsorBean.getDataFine());
			preparedStatement.setObject(3, sponsorBean.getID_Sponsor());
			
			
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


}

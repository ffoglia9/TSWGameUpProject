package control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.GameBean;
import model.GameDS;
import model.SponsorizzazioneBean;
import model.SponsorizzazioneDS;

@WebServlet("/requestSponsorship")
public class requestSponsorship extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/d/yyyy");
		String startDate = request.getParameter("startDate");
		LocalDate localStartDate = LocalDate.parse(startDate, formatter);
		
		String endDate = request.getParameter("endDate");
		LocalDate localEndDate = LocalDate.parse(endDate, formatter);
		
		//int requestedSponsorship = Integer.parseInt(request.getParameter("PendingSponsor"));
		int gameID = Integer.parseInt(request.getParameter("ID_Gioco"));
		
		SponsorizzazioneBean sponsorBean = new SponsorizzazioneBean(localStartDate, localEndDate);
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		SponsorizzazioneDS sponsorDS = new SponsorizzazioneDS(ds);
		
		try {
			GameBean gb = gameDS.doRetrieveByKey(gameID);
			gb.setPendingSponsorReq(true);
			
			sponsorDS.doSave(sponsorBean);
			gb.setSponsorID(sponsorBean.getID_Sponsor());
			
			gameDS.doUpdate(gb);
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
}

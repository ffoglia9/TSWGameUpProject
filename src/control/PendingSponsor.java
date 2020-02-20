package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.GameBean;
import model.GameDS;
import model.SponsorizzazioneDS;

/**
 * Servlet implementation class PendingSponsor
 */
@WebServlet("/PendingSponsor")
public class PendingSponsor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ID_Gioco = Integer.parseInt(request.getParameter("ID_Gioco"));
		int approvato = Integer.parseInt(request.getParameter("Approvato"));
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		try {
			GameBean gb = gameDS.doRetrieveByKey(ID_Gioco);
			gb.setPendingSponsorReq(false);
			int sponsorID = gb.getSponsorID(); // ID della entry sponsor da cancellare manualmente
			if(approvato == 0) {
				gb.setSponsorID(-1);
				SponsorizzazioneDS sds = new SponsorizzazioneDS(ds);
				sds.doDelete(sponsorID);
			}
			gameDS.doUpdate(gb);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}

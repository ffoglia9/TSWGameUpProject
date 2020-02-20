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

/**
 * Servlet implementation class PendingGames
 */
@WebServlet("/PendingGames")
public class PendingGames extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ID_Gioco = Integer.parseInt(request.getParameter("ID_Gioco"));
		int approvato = Integer.parseInt(request.getParameter("Approvato"));
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		GameBean gb = gameDS.doRetrieveByKey(ID_Gioco);
		gb.setApproved(approvato == 1);
		try {
			gameDS.doUpdate(gb);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}

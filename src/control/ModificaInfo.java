package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.BillBean;
import model.BillDS;
import model.UserBean;
import model.UserDS;
import model.Validator;

/**
 * Servlet implementation class ModificaInfo
 */
@WebServlet("/ModificaInfo")
public class ModificaInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HashMap<String, String> userData = new HashMap<String, String>();
		// Parametri
		userData.put("nome", request.getParameter("nome"));
		userData.put("cognome", request.getParameter("cognome"));
		userData.put("username", request.getParameter("username"));
		userData.put("password", request.getParameter("password"));
		userData.put("email", request.getParameter("email"));
		userData.put("indirizzo", request.getParameter("indirizzo"));
		userData.put("citta", request.getParameter("citta"));
		userData.put("cap", request.getParameter("cap"));
		userData.put("developer", request.getParameter("developer"));
		boolean valid = Validator.validate(userData); // ogni elemento di userData dovrebbe avere una regex associata.
		if(!valid) { // la validazione ha fallito
			response.sendError(421, "Dati non validi");
			return;
		}
		System.out.println(userData.toString());
		UserBean user = new UserBean(userData);
		UserBean currentUserBean = (UserBean) request.getSession().getAttribute("userBean");
		user.setUserID(currentUserBean.getUserID());
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		UserDS userDB = new UserDS(ds);
		BillDS fattDS = new BillDS(ds);
		try {
			userDB.doUpdate(user);
			System.out.println(user.getUserID());
			BillBean bill = new BillBean(-1, user.getUserID(), userData.get("nome"), userData.get("cognome"), userData.get("email"),
							userData.get("indirizzo"), userData.get("citta"), userData.get("cap"));
			fattDS.doSave(bill);
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
			return;
		}
		request.getSession().setAttribute("userBean", user);
		response.sendRedirect(response.encodeRedirectURL("pannello_utente.jsp"));
	}
	

}

package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
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

@WebServlet("/Register")
public class Register extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException { // Validazione completa, eseguita quando l'utente manda l'intero form
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
		
		System.out.println("userdata: "+userData);
		boolean valid = Validator.validate(userData); // ogni elemento di userData dovrebbe avere una regex associata.
		System.out.println(valid);
		if(!valid) { // la validazione ha fallito
			response.sendError(421, "Dati non validi");
			return;
		}
		UserBean user = new UserBean(userData);
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		UserDS userDB = new UserDS(ds);
		BillDS fattDS = new BillDS(ds);
		try {
			userDB.doSave(user);
			System.out.println(user.getUserID());
			BillBean bill = new BillBean(-1, user.getUserID(), userData.get("nome"), userData.get("cognome"), userData.get("email"),
							userData.get("indirizzo"), userData.get("citta"), userData.get("cap"));
			fattDS.doSave(bill);
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
			return;
		}
		request.getSession().setAttribute("userBean", user);
		response.sendRedirect(response.encodeRedirectURL("index.jsp"));
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // Validazione parziale (email only), eseguita quando l'utente immette una email sintatticamente valida (lato client).
		
		Enumeration<String> parameterNames = request.getParameterNames();
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		
		while(parameterNames.hasMoreElements()) {
			
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			
			if(Validator.matches(paramName, paramValue)) {
				
				boolean specialBehaviour = Validator.doSpecialBehaviour(paramName, paramValue, ds);
				if(!specialBehaviour) {
					response.sendError(420,   "TODO e"); // ARRAY su validator in base al paramName
				} else {
					response.setStatus(HttpServletResponse.SC_OK);
				}
				
				
			} else {
				response.sendError(421, "Email sintatticamente invalida");
			}
			
		}
		
		
		
	}
	
	
	
	
	/*protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // Validazione parziale (email only), eseguita quando l'utente immette una email sintatticamente valida (lato client).
		String email = request.getParameter("email");
		System.out.println("Ajax ricevuta, valore email " + email);
		if(Validator.matches("email", email))  { // validazione sintattica lato server
			System.out.println("email validata");
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			UserDAM userDB = new UserDAM(ds);
			try {
				if(userDB.doRetrieveByEmail(email) != null) {
					response.sendError(420, "Email già presente nel database");
				}
			} catch (SQLException e) {
				System.out.println("Error:" + e.getMessage());
			} catch (NonExistentAccountException e) {
				response.setStatus(HttpServletResponse.SC_OK);
			}
		} else {
			response.sendError(421, "Email sintatticamente invalida");
		}
	}*/
}

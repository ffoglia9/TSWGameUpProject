package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.UserBean;
import model.UserDS;
import model.UserDS.NonExistentAccountException;
import model.UserDS.WrongPasswordException;

@WebServlet("/SignIn")
public class SignIn extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String pw = request.getParameter("password");
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		UserDS userDS = new UserDS(ds);
		PrintWriter writer = response.getWriter();
		response.setContentType("text/plain"); // fixa l'errore nella console di firefox
		System.out.println("SignIn evocato con dati " + email + " e " + pw);
		try {
			UserBean user = userDS.doRetrieveByEmailAndPassword(email, pw);
			if(user != null) { 
				request.getSession().setAttribute("userBean", user);
				writer.println("User bean settato");
				response.setStatus(HttpServletResponse.SC_OK);
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
			response.sendError(500);
		} catch (NonExistentAccountException e) {
			response.sendError(432); // "Account non trovato"
		} catch (WrongPasswordException e) {
			response.sendError(433); // "Password errata"
		} finally {
			writer.close();
		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}

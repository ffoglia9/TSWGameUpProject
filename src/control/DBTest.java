package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.GameDS;
import model.GameBean;

@WebServlet("/DBTest")
public class DBTest extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		int id = Integer.parseInt(request.getParameter("id"));
		
		GameBean testBean = gameDS.doRetrieveByKey(id);
		if(testBean != null)
			System.out.println("GameBean ricevuto: "+ testBean.getTitle());
		
		
	}
}

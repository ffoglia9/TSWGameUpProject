package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import model.GameBean;
import model.GameDS;
import model.UserDS;
import model.Cart;

@WebServlet("/CartManager")
public class CartManager extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			int gameID = Integer.parseInt(request.getParameter("ID"));
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			GameDS gameDS = new GameDS(ds);
			GameBean gb = gameDS.doRetrieveByKey(gameID);
			if(gb != null){
				
				HttpSession session = request.getSession();
				Cart shoppingCart = (Cart) session.getAttribute("ShoppingCart");
				
				if(shoppingCart == null)
					shoppingCart = new Cart();
				
				shoppingCart.addProduct(gb);
				session.setAttribute("ShoppingCart", shoppingCart);
				
			}
				
			
		}catch(NumberFormatException e) {
			System.out.println("Invalid ID");
		}
		
	}
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

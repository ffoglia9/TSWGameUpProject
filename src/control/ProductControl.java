package control;

/*import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Cart;
import model.GameBean;
import model.GameDS;

@WebServlet("/ProductControl")
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	static ProductModelDM model = new ProductModelDM();
	
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		@SuppressWarnings("unchecked")
		Cart<ProductBean> cart = (Cart<ProductBean>) 
				request.getSession().getAttribute("carrello");
		if(cart == null) {
			cart = new Cart<ProductBean>();
			request.getSession().setAttribute("carrello", cart);
		}
		
		
		String action = request.getParameter("action");
		
		String sort = request.getParameter("sort");
		
		try {
			if(action != null) {
				if(action.equalsIgnoreCase("insert")) {
					String name = request.getParameter("name");
					String description = request.getParameter("description");
					int price = Integer.parseInt(request.getParameter("price"));
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					
					ProductBean bean = new ProductBean();
					bean.setName(name);
					bean.setDescription(description);
					bean.setPrice(price);
					bean.setQuantity(quantity);
					
					model.doSave(bean);
					request.setAttribute("message", "Product added");
				} else if(action.equalsIgnoreCase("details")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", model.doRetrieveByKey(id));
				} else if(action.equalsIgnoreCase("update")) {
					int id = Integer.parseInt(request.getParameter("id"));
					String name = request.getParameter("name");
					String description = request.getParameter("description");
					int price = Integer.parseInt(request.getParameter("price"));
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					
					ProductBean bean = new ProductBean();
					bean.setCode(id);
					bean.setName(name);
					bean.setDescription(description);
					bean.setPrice(price);
					bean.setQuantity(quantity);		
					
					model.doUpdate(bean);
					request.setAttribute("message", "Product updated");
				} else if(action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					ProductBean bean = model.doRetrieveByKey(id);
					if(bean != null) {
						model.doDelete(bean);
						request.setAttribute("message", "Product deleted");
					}	
				} else if(action.equalsIgnoreCase("addCart")) {
					int id = Integer.parseInt(request.getParameter("id"));
					ProductBean bean = model.doRetrieveByKey(id);
					if(bean != null) {
						cart.addItem(bean);
						request.setAttribute("message", "Product added to cart");
					}	
				} else if(action.equalsIgnoreCase("deleteCart")) {
					int id = Integer.parseInt(request.getParameter("id"));
					ProductBean bean = model.doRetrieveByKey(id);
					if(bean != null) {
						cart.deleteItem(bean);	
						request.setAttribute("message", "Product deleted from cart");
					}	
				} else if(action.equalsIgnoreCase("clearCart")) {
					cart.deleteAll();
					request.setAttribute("message", "Cart cleaned");
				}
			}
		} catch(SQLException | NumberFormatException e) {
			System.out.println("Error:" + e.getMessage());
			request.setAttribute("error", e.getMessage());			
		}
		
		request.getSession().setAttribute("carrello", cart);
		request.setAttribute("cart", cart);
		
		
		try {
			request.removeAttribute("products");
			request.setAttribute("products", model.doRetrieveAll(sort));
		} catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}

		RequestDispatcher dispatcher = this.getServletContext().
				getRequestDispatcher("/ProductView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}*/

package control;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserBean;
import model.UserBean.tipoUtente;

/**
 * Servlet Filter implementation class Auth
 */
@WebFilter(urlPatterns = {"/checkout.jsp", "/pannello_utente.jsp", "/ModificaInfo", "/PendingGames"}) // Aggiungere pannello utente
public class Auth implements Filter {
	HashMap<String, tipoUtente> permissionsMap;
    /**
     * Default constructor. 
     */
    public Auth() {
        permissionsMap = new HashMap<>();
        permissionsMap.put("/checkout.jsp", tipoUtente.User);
        permissionsMap.put("/pannello_utente.jsp", tipoUtente.User);
        permissionsMap.put("/ModificaInfo", tipoUtente.User);
        permissionsMap.put("/PendingGames", tipoUtente.Admin);
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest rq = (HttpServletRequest) request;
		HttpServletResponse hresp = (HttpServletResponse) response; 
		HttpSession session = rq.getSession(false);
		if(session == null) {
			hresp.sendRedirect(hresp.encodeRedirectURL("./index.jsp?forceSignIn=1"));
			return;
		}
		
		UserBean uBean = (UserBean) session.getAttribute("userBean");
		if(uBean == null) {
			hresp.sendRedirect(hresp.encodeRedirectURL("./index.jsp?forceSignIn=1"));
			return;
		}
		
		String servletName = rq.getServletPath();
		tipoUtente userTypeRequired = permissionsMap.get(servletName);
		if(userTypeRequired != null) {
			int userTypeRequiredID = Integer.parseInt(UserBean.getUserTypeValue(userTypeRequired));
			int uBeanUserTypeID = Integer.parseInt(uBean.getUserTypeID());
			if(userTypeRequiredID > uBeanUserTypeID) { // l'utente non è dello stesso tipo ne è più importante
				hresp.sendRedirect(hresp.encodeRedirectURL("./index.jsp?forceSignIn=1"));
				return;
			}
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}

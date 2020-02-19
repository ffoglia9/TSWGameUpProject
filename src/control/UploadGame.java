package control;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import model.GameBean;
import model.GameDS;
import model.UserDS;

@WebServlet("/upload")
@MultipartConfig
public class UploadGame extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String title = request.getParameter("nome");
	    String desc = request.getParameter("descGioco");
	    String selectedCategory = "";
	    
	  //Upload della cover
	    Part filePart = request.getPart("cover"); // Retrieves <input type="file" name="cover">
	    String coverFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
	    InputStream fileContent = filePart.getInputStream();
	    
	  //Upload dell'icon
	    Part filePart1 = request.getPart("icon"); // Retrieves <input type="file" name="icon">
	    String iconFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
	    InputStream fileContent1 = filePart.getInputStream();
	    
	    double price = Double.parseDouble(request.getParameter("price"));
	    int selectedItem = Integer.parseInt(request.getParameter("Categories"));
	    
	    switch(selectedItem) {
	    	case 1: selectedCategory = "Action";
	    		break;
	    	case 2: selectedCategory = "FPS";
	    		break;
	    	case 3: selectedCategory = "Adventure";
    			break;
	    	case 4: selectedCategory = "Puzzle";
    			break;
	    	case 5: selectedCategory = "Arcade";
    			break;
	    }
	    
	    GameBean gb = new GameBean(title, desc, price, coverFileName, iconFileName, selectedCategory);
	    DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		
		try {
			gameDS.doSave(gb);
		} catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
			response.sendError(500);
		}
	}
}

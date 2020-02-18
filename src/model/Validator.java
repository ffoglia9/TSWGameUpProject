package model;

import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import model.UserDS.NonExistentAccountException;

abstract public class Validator {
	private static final Map<String, Pattern> idToRegex;
	
	static {
		
		//Blocco relativo a idToRegex
		HashMap<String, Pattern> temp = new HashMap<>();
		temp.put("email", Pattern.compile("^\\w+(?:[\\.-]?\\w+)*@\\w+(?:[\\.-]?\\w+)*(?:\\.\\w{2,4})+"));
		Pattern onlyLetters = Pattern.compile("^[A-Za-z]+$");
		temp.put("nome", onlyLetters);
		temp.put("cognome", onlyLetters);
		temp.put("username", Pattern.compile("^[A-Za-z0-9\\-\\_]+$"));
		temp.put("password", Pattern.compile("^.{8,}$"));
		temp.put("indirizzo", Pattern.compile("^[a-zA-Z0-9\\s,]+$"));
		temp.put("citta", Pattern.compile("^[A-Za-z\\s]+$"));
		temp.put("cap", Pattern.compile("^\\d{5}$"));
		temp.put("developer", Pattern.compile("^[10]$")); // Solo "1" o "0"
		idToRegex = Collections.unmodifiableMap(temp);
	}
	
	static public boolean isPresentEmail(String email, DataSource ds) {
		
		
		UserDS userDB = new UserDS(ds);
		try {
			if(userDB.doRetrieveByEmail(email) != null) {
				return false;
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
			return false;
		} catch (NonExistentAccountException e) {
			return true;
		}		
		
		return false;
	}
	
	static public boolean isPresentUsername(String username, DataSource ds) {
		
		
		UserDS userDB = new UserDS(ds);
		try {
			if(userDB.doRetrieveByUsername(username) != null) {
				return false;
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
			return false;
		} catch (NonExistentAccountException e) {
			return true;
		}		
		
		return false;
	}
	
	
	static public boolean matches(String id, String input) {
		Pattern pattern = idToRegex.get(id);
		if(pattern != null) {
			if(input == null) {
				return false;
			}
			Matcher matcher = pattern.matcher(input);
			boolean a = matcher.matches();
			System.out.println("result:"+a);
			return a;
		}
		return true;
	}
	
	
	static public boolean doSpecialBehaviour(String field, String value, DataSource ds) {
		
		switch(field) {
			case "email": return isPresentEmail(value, ds);
			case "username": return isPresentUsername(value, ds);
			default: return true;
		}
	}
	
	
}

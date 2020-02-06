package model;

import java.sql.SQLException;
import java.util.Collection;

/* Data access model. Interfaccia di base contenente le 5 operazioni CRUD:
Create (doSave), Retrieve (doRetrieve byKey/All), Update (doUpdate) e Delete (doDelete)
Tale interfaccia viene implementata da un DataSource che funge da oggetto intermedio tra il bean e il database.
*/
public interface DataAccessModel<T> {
	public void doSave(T data) throws SQLException;

	public boolean doDelete(int code) throws SQLException;
	
	public boolean doUpdate(T data) throws SQLException;

	public T doRetrieveByKey(int code) throws SQLException;
	
	public Collection<T> doRetrieveAll(String order) throws SQLException;
}

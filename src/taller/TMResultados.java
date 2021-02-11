/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package taller;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableModel;
import java.util.List;
import java.util.ArrayList;
import javax.swing.table.DefaultTableModel;
import taller.Resultado;
import taller.Conexion;
/**
 *
 * @author Administrador
 */
public class TMResultados implements TableModel {
    public List <Resultado> resultado;
    private Conexion con;
    public TMResultados(){
        this.resultado=Listar();
    }
    
    public ArrayList<Resultado> Listar(){
        ArrayList<Resultado> list = new ArrayList<Resultado>();
        Conexion conec = new Conexion();
        conec.Conexion1();
        String sql = "select * from resultados;";
       
        ResultSet rs = null;
        PreparedStatement ps = null;
        int in=0;
        try{           
            ps = conec.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            
            while(rs.next()){              
                Resultado res=new Resultado();
                res.setIdEquipo(rs.getString(1));
                res.setEquipo(rs.getString(2));
                res.setPuntos(rs.getString(3));
                res.setPg(rs.getString(4));
                res.setPe(rs.getString(5));
                res.setPp(rs.getString(6));
                res.setPj(rs.getString(7));
                list.add(res);
                
                in++;
            }
            
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{
                ps.close();
                rs.close();
                conec.desconectar();
            }catch(Exception ex){}
        }
        return list;
    }
    
    public TMResultados(List<Resultado> lista){
        this.resultado=lista;
    }
    @Override
    public int getRowCount() {
        return resultado.size();
    }

    @Override
    public int getColumnCount() {
        return 7;
    }

    @Override
    public String getColumnName(int columnIndex) {
        String titulo=null;
        switch(columnIndex){
            case 0:titulo="Id";break;
            case 1:titulo="Equipo";break;
            case 2:titulo="Puntos";break;
            case 3:titulo="P. Ganados";break;
            case 4:titulo="P. Empatados";break;
            case 5:titulo="P. Perdidos";break;
            case 6:titulo="P. Jugados";break;
        }
        return titulo;
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return String.class;
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        boolean res=true;
        switch(columnIndex){
            case 0:res=false;break;
            case 1:res=false;break;
            case 2:res=false;break;
            case 3:res=false;break;
            case 4:res=false;break;
            case 5:res=false;break;
            case 6:res=false;break;
        }
        return res;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Resultado p= resultado.get(rowIndex);
        String titulo=null;
        switch(columnIndex){
            case 0:titulo=p.getIdEquipo();break;
            case 1:titulo=p.getEquipo();break;
            case 2:titulo=p.getPuntos();break;
            case 3:titulo=p.getPg();break;
            case 4:titulo=p.getPe();break;
            case 5:titulo=p.getPp();break;
            case 6:titulo=p.getPj();break;
        }
       return titulo;        
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
        /*
       Resultado p= resultado.get(rowIndex);
        switch(columnIndex){
            case 0:p.setIdEquipo(aValue.toString());break;
            case 1:p.setEquipo(aValue.toString());break;
            case 2:p.setPuntos(aValue.toString());break;
            case 3:p.setPg(aValue.toString());break;
            case 4:p.setPe(aValue.toString());break;
            case 5:p.setPp(aValue.toString());break;
            case 6:p.setPj(aValue.toString());break;
        }
        */
    }

    @Override
    public void addTableModelListener(TableModelListener l) {
        
    }

    @Override
    public void removeTableModelListener(TableModelListener l) {
        
    }
    
}

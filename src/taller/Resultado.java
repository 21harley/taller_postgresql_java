/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package taller;

/**
 *
 * @author Administrador
 */
public class Resultado {
    private String idEquipo;
    private String equipo;
    private String puntos;
    private String pg;
    private String pe;
    private String pp;
    private String pj;

    public Resultado(){
        this.idEquipo="";
        this.equipo="";
        this.puntos="";
        this.pg="";
        this.pe="";
        this.pp="";
        this.pj="";
    }
    public Resultado(String idEquipo,String equipo,String puntos,String pg,String pe,String pp,String pj){
        this.idEquipo=idEquipo;
        this.equipo=equipo;
        this.puntos=puntos;
        this.pg=pg;
        this.pe=pe;
        this.pp=pp;
        this.pj=pj;
    }     
    public String getIdEquipo() {
        return idEquipo;
    }

    public void setIdEquipo(String idEquipo) {
        this.idEquipo = idEquipo;
    }

    public String getEquipo() {
        return equipo;
    }

    public void setEquipo(String equipo) {
        this.equipo = equipo;
    }

    public String getPuntos() {
        return puntos;
    }

    public void setPuntos(String puntos) {
        this.puntos = puntos;
    }

    public String getPg() {
        return pg;
    }

    public void setPg(String pg) {
        this.pg = pg;
    }

    public String getPe() {
        return pe;
    }

    public void setPe(String pe) {
        this.pe = pe;
    }

    public String getPp() {
        return pp;
    }

    public void setPp(String pp) {
        this.pp = pp;
    }

    public String getPj() {
        return pj;
    }

    public void setPj(String pj) {
        this.pj = pj;
    }
    
}

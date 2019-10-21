package model;

import java.util.Date;

public class Contato {
	public String getDetalhe() {
		return detalhe;
	}
	public void setDetalhe(String detalhe) {
		this.detalhe = detalhe;
	}
	public Date getDataContato() {
		return dataContato;
	}
	public void setDataContato(Date dataContato) {
		this.dataContato = dataContato;
	}
	public String getNomeAgente() {
		return nomeAgente;
	}
	public void setNomeAgente(String nomeAgente) {
		this.nomeAgente = nomeAgente;
	}
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	private int codigo;
	private Date dataContato;
	private String nomeAgente;
	private String detalhe;
	
}

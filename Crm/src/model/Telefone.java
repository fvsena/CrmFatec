package model;

public class Telefone {
	public String getDdd() {
		return ddd;
	}
	public void setDdd(String ddd) {
		this.ddd = ddd;
	}
	public String getFone() {
		return fone;
	}
	public void setFone(String fone) {
		this.fone = fone;
	}
	public String getTelefone() {
		return this.ddd+this.fone;
	}
	private String ddd = "";
	private String fone = "";
}

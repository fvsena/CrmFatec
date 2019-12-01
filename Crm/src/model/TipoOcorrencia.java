package model;

public class TipoOcorrencia {
	private int codigoGrupo;
	private int codigoSubGrupo;
	private int codigoDetalhe;
	private String grupo;
	private String subGrupo;
	private String detalhe;
	
	public int getCodigoGrupo() {
		return codigoGrupo;
	}
	public void setCodigoGrupo(int codigoGrupo) {
		this.codigoGrupo = codigoGrupo;
	}
	public int getCodigoSubGrupo() {
		return codigoSubGrupo;
	}
	public void setCodigoSubGrupo(int codigoSubGrupo) {
		this.codigoSubGrupo = codigoSubGrupo;
	}
	public int getCodigoDetalhe() {
		return codigoDetalhe;
	}
	public void setCodigoDetalhe(int codigoDetalhe) {
		this.codigoDetalhe = codigoDetalhe;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public String getSubGrupo() {
		return subGrupo;
	}
	public void setSubGrupo(String subGrupo) {
		this.subGrupo = subGrupo;
	}
	public String getDetalhe() {
		return detalhe;
	}
	public void setDetalhe(String detalhe) {
		this.detalhe = detalhe;
	}
	
}

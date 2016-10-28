package br.com.silvaesouza.cucumbersample.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "TBL_TEST_TA_AFETACAO_PARCIAL")
@SequenceGenerator(name = "sequence_taafetacao", sequenceName = "SEQ_TA_AFETACAO_PARCIAL")
public class TaAfetacaoParcial implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "sequence_taafetacao")
	@Column(name = "AAP_CODIGO", nullable = false, precision = 10, scale = 0)
	private Integer codigo;

	@Column(name = "AAP_VOZ", precision = 10, scale = 0)
	private Integer voz;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "AAP_DATA", length = 7)
	private Date data;
	
	@Column(name="AAP_TRANSMISSAO", precision=10, scale=0)
    private Integer transmissao;
	
	@Column(name="AAP_DETERMINISTICA", precision=10, scale=0)
    private Integer deterministica;
	
	@Column(name="AAP_SPEEDY", precision=10, scale=0)
    private Integer speedy;
	
	@Column(name="AAP_CLIENTE", precision=10, scale=0)
    private Integer cliente;
	
	@Column(name="AAP_CP", precision=10, scale=0)
    private Integer cp;
	
	@Column(name="AAP_REDEIP", precision=10, scale=0)
    private Integer redeip;
	
	@Column(name="AAP_INTERCONEXAO", precision=10, scale=0)
    private Integer interconexao;
	
	@Column(name="AAP_SPPAC", precision=10, scale=0)
    private Integer sppac;
	
	@Column(name="AAP_DTH", precision=10, scale=0)
    private Integer dth;
	
	@Column(name="AAP_FTTX", precision=10, scale=0)
    private Integer fttx;
	
	@Column(name="AAP_IPTV", precision=10, scale=0)
    private Integer iptv;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "AAP_TA", nullable = false)
	@org.hibernate.annotations.ForeignKey( name = "none") 
	private TA ta;

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public Integer getVoz() {
		return voz;
	}

	public void setVoz(Integer voz) {
		this.voz = voz;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public TA getTa() {
		return ta;
	}

	public void setTa(TA ta) {
		this.ta = ta;
	}

	public Integer getTransmissao() {
		return transmissao;
	}

	public void setTransmissao(Integer transmissao) {
		this.transmissao = transmissao;
	}

	public Integer getDeterministica() {
		return deterministica;
	}

	public void setDeterministica(Integer deterministica) {
		this.deterministica = deterministica;
	}

	public Integer getSpeedy() {
		return speedy;
	}

	public void setSpeedy(Integer speedy) {
		this.speedy = speedy;
	}

	public Integer getCliente() {
		return cliente;
	}

	public void setCliente(Integer cliente) {
		this.cliente = cliente;
	}

	public Integer getCp() {
		return cp;
	}

	public void setCp(Integer cp) {
		this.cp = cp;
	}

	public Integer getRedeip() {
		return redeip;
	}

	public void setRedeip(Integer redeip) {
		this.redeip = redeip;
	}

	public Integer getInterconexao() {
		return interconexao;
	}

	public void setInterconexao(Integer interconexao) {
		this.interconexao = interconexao;
	}

	public Integer getSppac() {
		return sppac;
	}

	public void setSppac(Integer sppac) {
		this.sppac = sppac;
	}

	public Integer getDth() {
		return dth;
	}

	public void setDth(Integer dth) {
		this.dth = dth;
	}

	public Integer getFttx() {
		return fttx;
	}

	public void setFttx(Integer fttx) {
		this.fttx = fttx;
	}

	public Integer getIptv() {
		return iptv;
	}

	public void setIptv(Integer iptv) {
		this.iptv = iptv;
	}

}

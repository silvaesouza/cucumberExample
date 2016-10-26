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

	@Column(name = "AAP_VOZ", nullable = false, precision = 10, scale = 0)
	private Integer voz;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "AAP_DATA", nullable = false, length = 7)
	private Date data;

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

}
